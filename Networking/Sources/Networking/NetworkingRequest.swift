//
//  NetworkingRequest.swift
//  
//
//  Created by Victor Chirino on 21/10/2022.
//

import Foundation

public protocol NetworkingRequest {
    var basePath: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [HTTPHeader] { get }
    var body: HTTPBody? { get }
}

extension NetworkingRequest {
    func urlRequest(using encoder: JSONEncoder, requestModifier: NetworkingRequestModifier?) -> URLRequest? {
        guard let url = URL(string: basePath.appending(endpoint)) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body?.encode(encoder: encoder)
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.name) }
        let modifiedRequest = requestModifier?.modify(request: request) ?? request
        return modifiedRequest
    }
}
