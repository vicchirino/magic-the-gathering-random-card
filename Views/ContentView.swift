//
//  ContentView.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject private var randomCardVM = RandomCardViewModel()

    var body: some View {
        NavigationView {
            RandomCardView(randomCard: randomCardVM.randomCard)
                .navigationTitle("Card of the day")
        }
        .navigationViewStyle(.stack)
        .onAppear {
            self.randomCardVM.fetchRandomCard()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
