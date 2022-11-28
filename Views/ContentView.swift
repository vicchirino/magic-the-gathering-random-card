//
//  ContentView.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        NavigationView {
            RandomCardView()
                .navigationTitle("Card of the day")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
