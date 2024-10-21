//
//  UserProfileView.swift
//  CalendarConnect
//
//  Created by user on 10/21/24.
//

import Foundation
import SwiftUI
import GoogleSignIn

struct UserProfileView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var userViewModel: UserProfileModel
    
    private var user: GIDGoogleUser? {
        return GIDSignIn.sharedInstance.currentUser
    }
    
    var body: some View {
        if let userProfile = user?.profile {
            VStack(spacing: 10) {
                HStack(alignment: .top) {
                    Text("User info:")
                    VStack(alignment: .leading){
                        Text(userProfile.name).font(.headline)
                        Text(userProfile.email)
                    }
                }
            }
        }
        Text("User")
    }
}
