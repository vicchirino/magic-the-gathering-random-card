//
//  RandomCardViewModel.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import Foundation
import Combine

class RandomCardViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    @Published var randomCard: Card?
    
    func fetchRandomCard() {
        self.cancellable = WebService().getRandomCard()
            .sink(receiveCompletion: { _ in }, receiveValue: { card in
                print(card)
                self.randomCard = card
            })
    }
}
