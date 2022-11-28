//
//  CardRequest.swift
//  magic-database
//
//  Created by Victor Chirino on 14/11/2022.
//

import Networking

public enum CardRequest: NetworkingRequest {
    case randomCard
    
    public var basePath: String {
        "https://api.scryfall.com/"
    }
    
    public var endpoint: String {
        switch self {
        case .randomCard: return "cards/random"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .randomCard: return .get
        }
    }
    
    public var headers: [HTTPHeader] {
        [
            .defaultUserAgent,
            .jsonContentType
        ]
    }
    
    public var body: HTTPBody? {
        switch self {
        case .randomCard:
            return nil
        }
    }
}
