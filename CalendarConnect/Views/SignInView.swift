//
//  SignInView.swift
//  CalendarConnect
//
//  Created by Reo Ogundare on 10/22/24.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleUtilities
import GoogleSignInSwift

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack{
            HStack {
                VStack {
                    Button("Sign in", action: authViewModel.signIn)
                        .accessibilityIdentifier("GoogleSignInButton")
                        .accessibilityHint("Sign in with Google button.")
                        .padding()
                }
            }
        }
    }
}
