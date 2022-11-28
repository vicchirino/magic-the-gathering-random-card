//
//  NetworkingService.swift
//  
//
//  Created by Victor Chirino on 21/10/2022.
//

import Foundation
import OSLog

public protocol NetworkingService {
    func execute<T: Decodable>(request: NetworkingRequest) async -> Result<T, NetworkingError>
}

@available(iOS 13.0, *)
public class DefaultNetworkingService: NetworkingService {
    private let session: URLSession
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let requestModifier: NetworkingRequestModifier?
    private let tokenRefresher: TokenRefresher?
    private let errorHandler: NetworkingErrorHandler?

    private init(
        session: URLSession,
        encoder: JSONEncoder,
        decoder: JSONDecoder,
        requestModifier: NetworkingRequestModifier?,
        tokenRefresher: TokenRefresher?,
        errorHandler: NetworkingErrorHandler?
    ) {
        self.session = session
        self.encoder = encoder
        self.decoder = decoder
        self.requestModifier = requestModifier
        self.tokenRefresher = tokenRefresher
        self.errorHandler = errorHandler
    }

    public convenience init(requestModifier: NetworkingRequestModifier? = nil,
                            tokenRefresher: TokenRefresher? = nil,
                            errorHandler: NetworkingErrorHandler? = nil) {
        self.init(
            session: .shared,
            encoder: .standard,
            decoder: .standard,
            requestModifier: requestModifier,
            tokenRefresher: tokenRefresher,
            errorHandler: errorHandler
        )
    }

    @MainActor
    public func execute<T: Decodable>(request: NetworkingRequest) async -> Result<T, NetworkingError> {
        let result: Result<T, NetworkingError> = await fire(request: request)
        if case let Result.failure(error) = result,
           let shouldReFireRequest = await tokenRefresher?.wasTokenRefreshed(error: error),
           shouldReFireRequest {
            return await fire(request: request)
        }
        return result
    }

    private func fire<T: Decodable>(request: NetworkingRequest) async -> Result<T, NetworkingError> {
        await withCheckedContinuation { continuation in
            guard let urlRequest = request.urlRequest(using: encoder, requestModifier: requestModifier) else {
//                Logger.networking.error("[\(request.method.rawValue, privacy: .public)] \(request.endpoint, privacy: .public) error: \(NetworkingError.invalidRequest, privacy: .public)")
                continuation.resume(returning: .failure(.invalidRequest))
                return
            }
            session.dataTask(with: urlRequest) { [weak decoder, errorHandler] data, response, error in
                if let handledError = errorHandler?.handle(data: data, response: response, error: error) {
//                    Logger.networking.error("[\(request.method.rawValue, privacy: .public)] \(request.endpoint, privacy: .public) error: \(handledError, privacy: .public)")
                    continuation.resume(returning: .failure(handledError))
                    return
                }
                guard let data = data else {
//                    Logger.networking.error("[\(request.method.rawValue, privacy: .public)] \(request.endpoint, privacy: .public) error: \(NetworkingError.invalidResponse, privacy: .public)")
                    continuation.resume(returning: .failure(.invalidResponse))
                    return
                }
                guard !data.isEmpty else {
                    if let empty = Empty() as? T {
//                        Logger.networking.info("[\(request.method.rawValue, privacy: .public)] \(request.endpoint, privacy: .public) Empty result")
                        continuation.resume(returning: .success(empty))
                    } else {
//                        Logger.networking.error("[\(request.method.rawValue, privacy: .public)] \(request.endpoint, privacy: .public) error: \(NetworkingError.decodingFailed, privacy: .public)")
                        continuation.resume(returning: .failure(.decodingFailed))
                    }
                    return
                }
                guard let object = try? decoder?.decode(T.self, from: data) else {
//                    Logger.networking.error("[\(request.method.rawValue, privacy: .public)] \(request.endpoint, privacy: .public) error: \(NetworkingError.decodingFailed, privacy: .public)")
                    continuation.resume(returning: .failure(.decodingFailed))
                    return
                }
//                Logger.networking.info("[\(request.method.rawValue, privacy: .public)] \(request.endpoint, privacy: .public) result: \(String(data: data, encoding: .utf8) ?? "")")
                continuation.resume(returning: .success(object))
            }.resume()
        }
    }
}

