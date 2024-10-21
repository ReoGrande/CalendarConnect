//
// AuthenticationViewModel.swift
// CalendarConnect
//
// Created by Reo Ogundare on 10/20/24.
//

import SwiftUI
import GoogleSignIn

@Observable
final class AuthenticationViewModel: ObservableObject {

  var state: State!
  private var authenticator: GoogleSignInAuthenticator {
    return GoogleSignInAuthenticator(authViewModel: self)
  }

  var authorizedScopes: [String] {
    switch state {
    case .signedIn(let user):
      return user.grantedScopes ?? []
    case .signedOut:
      return []
    default:
      return []
    }
  }

  init() {
    if let user = GIDSignIn.sharedInstance.currentUser {
      self.state = .signedIn(user)
    } else {
      self.state = .signedOut
    }
  }

  func signIn() {
    authenticator.signIn()
  }

  func signOut() {
    authenticator.signOut()
  }

  func disconnect() {
    authenticator.disconnect()
  }

  var hasBirthdayReadScope: Bool {
    true
  }

  func addBirthdayReadScope() {

  }
}

extension AuthenticationViewModel {
 /// An enumeration representing logged in status.
 enum State {
  /// The user is logged in and is the associated value of this case.
  case signedIn(GIDGoogleUser)
  /// The user is logged out.
  case signedOut
 }
}
