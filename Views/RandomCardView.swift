//
//  RandomCardView.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import SwiftUI

struct RandomCardView: View {
    
    @StateObject private var randomCardVM = RandomCardViewModel()

    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    VStack {
                        CardAsyncImageView(cardImageURL: randomCardVM.randomCard?.imageURIs.large)
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    .frame(width: proxy.size.width, height: proxy.size.width * 1.39, alignment: .topLeading)
                    
                    Button {
                        withAnimation {
                            randomCardVM.save(card: randomCardVM.randomCard)
                        }
                    } label: {
                        HStack {
                            Image(systemName: (randomCardVM.randomCard?.saved ?? false) ? "square.and.arrow.down.fill" : "square.and.arrow.down")
                                .resizable()
                                .frame(width: 20, height: 25, alignment: .center)
                            Text((randomCardVM.randomCard?.saved ?? false) ? "Card saved!" : "Save the card")
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        }.foregroundColor(.black)
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()

                    CardInformationStackView(card: randomCardVM.randomCard)
                    .padding(20)
                    .frame(minWidth: proxy.size.width, minHeight: proxy.size.height, maxHeight: .infinity, alignment: .topLeading)
            }
                .toolbar {
                    Button {
                        print("Saved List")
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
