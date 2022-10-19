//
//  CardSetView.swift
//  magic-database
//
//  Created by Victor Chirino on 19/10/2022.
//

import SwiftUI
import MTGSetIcon

struct CardSetView: View {
    var setText: String
    var set: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Set")
                .font(.headline)
            
            Spacer()
                .frame(height: 10)
            
            HStack {
                MTGSetIconView(set: set)
                    .frame(width: 20, height: 20)
                Text(setText)
                    .font(.subheadline)
            }
        }
        .foregroundColor(.black)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
    }
}

struct CardSetView_Previews: PreviewProvider {
    static var previews: some View {
        CardSetView(setText: "Invasion", set: "inv")
    }
}
