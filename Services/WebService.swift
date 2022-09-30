//
//  webservice.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import Foundation
import Combine

protocol Request {
    
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
    
}
