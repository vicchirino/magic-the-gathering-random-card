//
//  NetworkingErrorHandler.swift
//  
//
//  Created by Victor Chirino on 21/10/2022.
//

import Foundation
public protocol NetworkingErrorHandler {
    func handle(data: Data?, response: URLResponse?, error: Error?) -> NetworkingError?
}
