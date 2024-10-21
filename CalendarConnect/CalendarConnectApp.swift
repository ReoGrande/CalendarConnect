//
//  CalendarConnectApp.swift
//  CalendarConnect
//
//  Created by user on 10/21/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
@main
struct CalendarConnectApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var authViewModel = AuthenticationViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authViewModel)
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        if let user = user {
                            self.authViewModel.state = .signedIn(user)
                        } else if let error = error {
                            self.authViewModel.state = .signedOut
                            print("There was an error restoring the previous sign-in: \(error)")
                        } else {
                            self.authViewModel.state = .signedOut
                        }
                    }
                }
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
