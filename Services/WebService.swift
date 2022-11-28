//
//  webservice.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import Foundation
import Combine
import Networking

protocol Request {
    
}

public class CardService {
    private let networkingService: NetworkingService
    
    private init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    public convenience init() {
        self.init(networkingService: DefaultNetworkingService())
    }
    
    public func getRandomCard() async -> Result<Card, NetworkingError> {
        let request = CardRequest.randomCard
        return await networkingService.execute(request: request)
    }
}

public final class WebService {
    
    private var baseURL = "https://api.scryfall.com/"
    
    func getRandomCard() -> AnyPublisher<Card, Error> {
        guard let url = URL(string: baseURL + "cards/random") else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Card.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getCardBy(_ id: String) -> AnyPublisher<Card, Error> {
        guard let url = URL(string: baseURL + "cards/" + id) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Card.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
