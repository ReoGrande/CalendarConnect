//
//  CalendarConnectApp.swift
//  CalendarConnect
//
//  Created by user on 10/21/24.
//

import SwiftUI

@main
struct CalendarConnectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
