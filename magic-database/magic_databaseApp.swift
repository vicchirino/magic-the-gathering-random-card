//
//  magic_databaseApp.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import SwiftUI

@main
struct magic_databaseApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        let barAppearance = UINavigationBar.appearance()

        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(displayP3Red: 173/255, green: 81/255, blue: 0/255, alpha: 1.0)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            barAppearance.standardAppearance = appearance
            barAppearance.scrollEdgeAppearance = appearance
        } else {
            barAppearance.backgroundColor = UIColor(displayP3Red: 173/255, green: 81/255, blue: 0/255, alpha: 1.0)
            barAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            barAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
        barAppearance.tintColor = .white
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
