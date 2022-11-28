//
//  TokenRefresh.swift
//  
//
//  Created by Victor Chirino on 21/10/2022.
//

import Foundation

public protocol TokenRefresher {
    func wasTokenRefreshed(error: NetworkingError) async -> Bool
}
