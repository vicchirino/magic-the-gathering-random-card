//
//  SavedCardsListView.swift
//  magic-database
//
//  Created by Victor Chirino on 30/09/2022.
//

import SwiftUI
import MTGSetIcon

struct SavedCardsListView: View {
    var savedCards: [Card]
    var body: some View {
            List(self.savedCards, id: \.id) { card in
                HStack {
                    AsyncImage(url: URL(string: card.imageURIs.large)) { image in
                        image.resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                            .padding(25)
                    }.frame(height: 100, alignment: .center)
                        .padding([.trailing], 5)

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Name: \(card.name)")
                            .font(.system(size: 16))
                        Text("Type: \(card.type)")
                            .font(.system(size: 12))
                        Text("Rarity: \(card.rarity.capitalized)")
                            .font(.system(size: 12))
                        HStack {
                            Text("Set: \(card.setName)")
                                .font(.system(size: 12))
                            MTGSetIconView(set: card.set)
                                .frame(width: 12)
                        }
                        Text("Artist: \(card.artist)")
                            .font(.system(size: 12))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .foregroundColor(.black)
                    .padding([.top, .bottom], 5)
                }
            }
        .listStyle(.grouped)
        .navigationTitle("Saved cards")
        .background()
    }
    
}

struct SavedCardsListView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCardsListView(savedCards: [TestCard.card, TestCard.card])
    }
}
