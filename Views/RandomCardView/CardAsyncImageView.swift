//
//  CardAsyncImageView.swift
//  magic-database
//
//  Created by Victor Chirino on 29/09/2022.
//

import SwiftUI

struct CardAsyncImageView: View {
    var cardImageURL: String?
    
    var body: some View {
        AsyncImage(url: URL(string: cardImageURL ?? "")) { phase in
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
}

struct CardAsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        CardAsyncImageView(cardImageURL: TestCard.card.imageURIs.large)
    }
}
