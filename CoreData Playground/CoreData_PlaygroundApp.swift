//
//  CoreData_PlaygroundApp.swift
//  CoreData Playground
//
//  Created by Martin Václavík on 29.12.2023.
//

import SwiftUI

@main
struct CoreData_PlaygroundApp: App {
    let persistenceController = PersistenceController.preview

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
