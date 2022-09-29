//
//  CardInformationView.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import SwiftUI

struct CardInformationView: View {
    
    var informationTitle: String!
    var informationDescription: String?
    var isItalic: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if let _informationDescription = informationDescription {
                Text(informationTitle)
                    .font(.headline)
//                    .underline()
                
                Spacer()
                    .frame(height: 10)
                
                Text(_informationDescription)
                    .font(.subheadline)
                    .active(isItalic, Text.italic)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
    }
}

struct CardInformationView_Previews: PreviewProvider {
    static var previews: some View {
        CardInformationView(informationTitle: "Title", informationDescription: "Lorem impusum description that is quite long but could be not too long.")
    }
}
