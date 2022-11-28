//
//  NetworkingError.swift
//  
//
//  Created by Victor Chirino on 21/10/2022.
//

import Foundation

public enum NetworkingError: Error {
    case invalidRequest
    case invalidResponse
    case decodingFailed
    case connectionFailed
    case unauthorized
    case forbidden
    case resourceNotFound
    case other(code: Int)
    case unknown(error: Error)
    case badRequest
    case custom(error: CustomAPIError)

    public init(statusCode: Int) {
        switch statusCode {
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 404: self = .resourceNotFound
        default: self = .other(code: statusCode)
        }
    }

    public init(error: Error) {
        if let error = error as? URLError, error.isConnectionRelated {
            self = .connectionFailed
        } else {
            self = .unknown(error: error)
        }
    }
}

extension NetworkingError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidRequest: return "Invalid request"
        case .invalidResponse: return "Invalid response"
        case .decodingFailed: return "Decoding failed"
        case .connectionFailed: return "Connection failed"
        case .unauthorized: return "Unauthorized"
        case .forbidden: return "Forbidden"
        case .resourceNotFound: return "Resource not found"
        case .other(let code): return "Error code: \(code)"
        case .unknown(let error): return "Unknown error: \(error.localizedDescription)"
        case .badRequest: return "Bad request"
        case .custom(let error): return error.localizedDescription
        }
    }
}

extension NetworkingError: CustomStringConvertible {
    public var description: String {
        errorDescription ?? "Empty description"
    }
}
