//
//  SavedCardsListView.swift
//  magic-database
//
//  Created by Victor Chirino on 30/09/2022.
//

import SwiftUI

struct SavedCardsListView: View {
    var savedCards: [Card]
    var body: some View {
            List(self.savedCards, id: \.id) { card in
                HStack {
                    AsyncImage(url: URL(string: card.imageURIs.large)) { image in
                        image.resizable()
                            .scaledToFit()
//                            .overlay(Material.ultraThin)
                    } placeholder: {
                        ProgressView()
                            .padding(25)
                    }.frame(height: 100, alignment: .center)
                        .padding([.trailing], 5)

                    VStack(alignment: .leading ,spacing: 5) {
                        Text("Name: \(card.name)")
                            .font(.system(size: 16))
                        Text("Type: \(card.type)")
                            .font(.system(size: 12))
                        Text("Rarity: \(card.rarity)")
                            .font(.system(size: 12))
                        Text("Set: \(card.setName)")
                            .font(.system(size: 12))

                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        .listStyle(.grouped)
        .navigationTitle("Saved cards")
    }
}

struct SavedCardsListView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCardsListView(savedCards: [TestCard.card, TestCard.card])
    }
}
