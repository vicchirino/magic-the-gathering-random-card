//
//  RandomCardView.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import SwiftUI

struct RandomCardView: View {
    
    var randomCard: Card?
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack {
                        Text(randomCard?.name ?? "")
                            .font(Font.system(size: 30))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Spacer()
                            .frame(height: 60)
                        
                        AsyncImage(url: URL(string: randomCard?.imageURIs.large ?? "")) { phase in
                            switch phase {
                            case .empty:
                                EmptyView()
        
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .failure:
                                Text("Failed fetching image. Make sure to check your data connection and try again.")
                                    .foregroundColor(.red)
                            @unknown default:
                                // Since the AsyncImagePhase enum isn't frozen,
                                // we need to add this currently unused fallback
                                // to handle any new cases that might be added
                                // in the future:
                                Color.orange
                            }
                        }
                        
                    }
                    .padding(20)
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .topLeading)
                    
                    Divider()

                    VStack(spacing: 20) {
                        
                        CardInformationView(informationTitle: "Type", informationDescription: randomCard?.type)
                        
                        CardInformationView(informationTitle: "Rarity", informationDescription: randomCard?.rarity)
                                                
                        CardInformationView(informationTitle: "Oracle text", informationDescription: randomCard?.oracleText)
                                            
                        CardInformationView(informationTitle: "Flavor text", informationDescription: randomCard?.flavorText,
                                            isItalic: true)
                        
                        CardInformationView(informationTitle: "Illustrated by", informationDescription: randomCard?.artist)
                        
                        AsyncImage(url: URL(string: randomCard?.imageURIs.artCrop ?? "")) { phase in
                            switch phase {
                            case .empty:
                                EmptyView()
        
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .failure:
                                Text("Failed fetching image. Make sure to check your data connection and try again.")
                                    .foregroundColor(.red)
                            @unknown default:
                                // Since the AsyncImagePhase enum isn't frozen,
                                // we need to add this currently unused fallback
                                // to handle any new cases that might be added
                                // in the future:
                                Color.orange
                            }
                        }
                        
                        CardInformationView(informationTitle: "Set", informationDescription: randomCard?.setName)
                        
                    }
                    .padding(20)
                    .frame(minWidth: proxy.size.width, minHeight: proxy.size.height, maxHeight: .infinity, alignment: .topLeading)
//                    .background(Color.yellow)

            }
        }
        .background(Color(uiColor: .lightGrayColor))
        }
    }
}

struct RandomCardView_Previews: PreviewProvider {
    static var previews: some View {
        RandomCardView(randomCard: nil)
    }
}
