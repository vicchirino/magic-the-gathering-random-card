//
//  CustomAPIError.swift
//  
//
//  Created by Victor Chirino on 21/10/2022.
//

import Foundation

public protocol CustomAPIError: LocalizedError {
    var statusCode: Int! { get }
}
