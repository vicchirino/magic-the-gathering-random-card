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
        fetchRandomCard { [weak self] card in
            if (self?.savedCards.filter { $0.id == card.id }.count) ?? 0 > 0 {
                self?.getRandomCard()
            } else {
                self?.randomCard = card
            }
        }
    }
    
    override init() {
        let request: NSFetchRequest<CardData> = CardData.fetchRequest()
        request.sortDescriptors =  [NSSortDescriptor(keyPath: \CardData.id, ascending: true)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                   managedObjectContext: PersistenceController.shared.container.viewContext,
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
                // TODO: - Remove this
                print(card)
                completion(card)
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
        // TODO: - Remove this
        for card in fetchedResultsController.fetchedObjects ?? [] {
            print("Card saved: ", card.name)
        }
        savedCards = fetchedResultsController.fetchedObjects ?? []
    }
    
    func save(card: Card?) {
        // TODO: Move this to other part.
        let cardForSave = CardData(context: context)
        cardForSave.setName = card?.setName
        cardForSave.rarity = card?.rarity
        cardForSave.artist = card?.artist
        cardForSave.flavorText = card?.flavorText
        cardForSave.oracleText = card?.oracleText
        cardForSave.type = card?.type
        cardForSave.name = card?.name
        cardForSave.layout = card?.layout
        cardForSave.id = card?.id
        cardForSave.artURL = card?.imageURIs.artCrop
        cardForSave.imageURL = card?.imageURIs.large
        
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
