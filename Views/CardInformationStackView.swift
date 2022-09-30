//
//  CardInformationStackView.swift
//  magic-database
//
//  Created by Victor Chirino on 30/09/2022.
//

import SwiftUI

private enum InformationType {
    case name
    case type
    case rarity
    case oracleText
    case flavorText
    case artist
    case imageURL
    case set
}

private struct Information {
    let text: String
    let type: InformationType
    
    func getTitle() -> String {
        switch type {
        case .type:
            return "Type"
        case .name:
            return "Name"
        case .rarity:
            return "Rarity"
        case .oracleText:
            return "Oracle text"
        case .flavorText:
            return "Flavor text"
        case .set:
            return "Set"
        case .artist:
            return "Artist"
        default:
            return ""
        }
        
    }
}

struct CardInformationStackView: View {
    fileprivate var information: [Information]
    fileprivate var imageURL: String
    var body: some View {
        VStack(spacing: 20) {
            ForEach(information.filter { $0.type != .imageURL}, id: \.type.hashValue) { info in
                CardInformationView(informationTitle: info.getTitle(), informationDescription: info.text)
            }
            CardAsyncImageView(cardImageURL: imageURL)
        }
    }
}

struct CardInformationStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardInformationStackView(card: TestCard.card)
    }
}

extension CardInformationStackView {
    init(card: Card?) {
        guard let card = card else {
            self.information = []
            self.imageURL = ""
            return
        }
        var cardInformation: [Information] = []
        cardInformation.append(Information(text: card.name, type: .name))
        cardInformation.append(Information(text: card.type, type: .type))
        cardInformation.append(Information(text: card.rarity, type: .rarity))
        cardInformation.append(Information(text: card.oracleText, type: .oracleText))
        if let text = card.flavorText  {
            cardInformation.append(Information(text: text, type: .flavorText))
        }
        cardInformation.append(Information(text: card.setName, type: .set))
        cardInformation.append(Information(text: card.artist, type: .artist))
        self.information = cardInformation
        self.imageURL = card.imageURIs.artCrop
    }
}
