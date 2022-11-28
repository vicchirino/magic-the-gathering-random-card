//
//  RandomCardView.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import SwiftUI
import MTGSetIcon

struct RandomCardView: View {
    
    @StateObject private var randomCardVM = RandomCardViewModel()
    @State private var isDisplayingSavedCards = false

    var body: some View {
            GeometryReader { proxy in
                NavigationLink(destination: SavedCardsListView(savedCards: randomCardVM.savedCards.map { $0.toCardModel() }), isActive: $isDisplayingSavedCards) { EmptyView() }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 0) {
                        VStack {
                            CardAsyncImageView(cardImageURL: randomCardVM.randomCard?.imageURIs.large)
                                .allowsHitTesting(false)
                        }.padding([.top, .leading, .trailing], 20)
                            .frame(width: proxy.size.width, height: proxy.size.width * 1.39, alignment: .topLeading)
                        
                        
                        Button {
                            withAnimation {
                                guard let randomCard = randomCardVM.randomCard else {
                                    return
                                }
                                randomCardVM.save(card: randomCard)
                            }
                        } label: {
                            HStack {
                                Image(systemName: (randomCardVM.randomCard?.saved ?? false) ? "square.and.arrow.down.fill" : "square.and.arrow.down")
                                    .resizable()
                                    .frame(width: 20, height: 25, alignment: .center)
                                Text((randomCardVM.randomCard?.saved ?? false) ? "Card saved!" : "Save the card")
                                    .padding([.top], 5)
                            }.foregroundColor(.black)
                        }.padding([.leading, .trailing, .bottom], 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                        
                        CardInformationStackView(card: randomCardVM.randomCard)
                            .padding(20)
                            .frame(minWidth: proxy.size.width, minHeight: proxy.size.height, maxHeight: .infinity, alignment: .topLeading)
                    }
                    .toolbar {
                        Button {
                            self.isDisplayingSavedCards = true
                        } label: {
                            Image(systemName: "heart.text.square.fill").foregroundColor(.white)
                        }
                    }
                }.redacted(reason: randomCardVM.randomCard == nil ? .placeholder : [])
                    .background(Color(uiColor: .lightGrayColor))
        }
        .onAppear {
            self.randomCardVM.getRandomCard()
        }
    }
}

struct RandomCardView_Previews: PreviewProvider {
    static var previews: some View {
        RandomCardView()
    }
}
