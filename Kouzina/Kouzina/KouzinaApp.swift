//
//  KouzinaApp.swift
//  Kouzina
//
//  Created by AS on 1/11/2021.
//

import SwiftUI

@main
struct KouzinaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
