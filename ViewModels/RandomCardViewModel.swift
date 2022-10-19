//
//  RandomCardViewModel.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import Foundation
import Combine
import CoreData

class RandomCardViewModel: NSObject, ObservableObject{
    
    func getRandomCard() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
                        
        if let lastRandomCardDisplayedDateString = UserDefaults.standard.string(forKey: "LAST_RANDOM_CARD_DATE"),
           let lastRandomCardDisplayedDate = dateFormatter.date(from: lastRandomCardDisplayedDateString), Calendar.current.isDateInToday(lastRandomCardDisplayedDate),
           let randomCardOfTheDayID = UserDefaults.standard.string(forKey: "LAST_RANDOM_CARD_ID") {
            fetchCardBy(randomCardOfTheDayID)
        } else {
            fetchRandomCard { [weak self] card in
                if (self?.savedCards.filter { $0.id == card.id }.count) ?? 0 > 0 {
                    self?.getRandomCard()
                } else {
                    self?.randomCard = card
                    UserDefaults.standard.set(card.id, forKey: "LAST_RANDOM_CARD_ID")
                    UserDefaults.standard.set(dateFormatter.string(from: Date()), forKey: "LAST_RANDOM_CARD_DATE")
                }
            }
        }
    }
    
    override init() {
        let request: NSFetchRequest<CardData> = CardData.fetchRequest()
        request.sortDescriptors =  [NSSortDescriptor(keyPath: \CardData.id, ascending: true)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                   managedObjectContext: context,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
        super.init()
        setupFetchResultsController()
    }
    
    // MARK: - WebService request
    
    private var cancellable: AnyCancellable?
    @Published var randomCard: Card?
    
    private func fetchRandomCard(completion: @escaping (Card) -> Void) {
        self.cancellable = WebService().getRandomCard()
            .sink(receiveCompletion: { _ in }, receiveValue: { card in
                completion(card)
            })
    }
    
    private func fetchCardBy(_ id: String) {
        self.cancellable = WebService().getCardBy(id)
            .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] card in
                do {
                    self?.randomCard = card
                    if let cards = self?.savedCards, cards.contains(where: { $0.id == card.id }) {
                        self?.randomCard?.setSaved()
                    }
                }
            })
    }

    // MARK: - Core Data request
    
    private let context = PersistenceController.shared.container.viewContext
    private let fetchedResultsController: NSFetchedResultsController<CardData>
    
    @Published var savedCards: [CardData] = []
    
    private func setupFetchResultsController() {
        self.fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError()
        }
        savedCards = fetchedResultsController.fetchedObjects?.map({ $0 }) ?? []
    }
    
    func save(card: Card) {
        if card.saved, let cardToDelete = self.savedCards.first(where: { $0.id == card.id }) {
            context.delete(cardToDelete)
            self.savedCards = self.savedCards.filter { $0.id != card.id }
        } else {
            // TODO: Move this to other part.
            let cardForSave = CardData(context: context)
            cardForSave.setName = card.setName
            cardForSave.rarity = card.rarity
            cardForSave.artist = card.artist
            cardForSave.flavorText = card.flavorText
            cardForSave.oracleText = card.oracleText
            cardForSave.type = card.type
            cardForSave.name = card.name
            cardForSave.layout = card.layout
            cardForSave.id = card.id
            cardForSave.artURL = card.imageURIs.artCrop
            cardForSave.imageURL = card.imageURIs.large
            cardForSave.set = card.set
            
            self.savedCards.append(cardForSave)
        }
        self.randomCard?.setSaved()
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}

extension RandomCardViewModel: NSFetchedResultsControllerDelegate {
    
}
