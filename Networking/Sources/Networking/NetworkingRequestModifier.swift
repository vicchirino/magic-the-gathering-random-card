//
//  NetworkingRequestModifier.swift
//  
//
//  Created by Victor Chirino on 21/10/2022.
//

import Foundation

public protocol NetworkingRequestModifier {
    func modify(request: URLRequest) -> URLRequest
}
