//
// GoogleSignInAuthenticator.swift
// CalendarConnect
//
// Created by Reo Ogundare on 10/20/24.
//

import Foundation
import GoogleSignIn

final class GoogleSignInAuthenticator: ObservableObject {
  private var authViewModel: AuthenticationViewModel
  init(authViewModel: AuthenticationViewModel) {
    self.authViewModel = authViewModel
  }

  func signIn() {
#if os(iOS)
    guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
      print("There is no root view controller")
      return
    }
    let manualNonce = UUID().uuidString
    //Dunno what for?d

      GIDSignIn.sharedInstance.signIn(
        withPresenting: rootViewController,
        hint: nil,
        additionalScopes: nil
        //nonce: manualNonce
        //Not finding nonce in GIDSignIn framework idk why
      ) { signInResult, error in
          guard let signInResult = signInResult else {
              print("Error! \(String(describing: error))")
              return
      }

      //Compare returned nonce to manual nonce
//      guard let idToken = signInResult.user.idToken?.tokenString,
//         let returnedNonce = self.decodeNonce(fromJWT: idToken),
//         returnedNonce == manualNonce else {
//        assertionFailure("ERROR: Return nonce doesn't match manuel nonce!")
//        return
//      }
      self.authViewModel.state = .signedIn(signInResult.user)
      }
#endif
    }

  func signOut() {
    GIDSignIn.sharedInstance.signOut()
    authViewModel.state = .signedOut
  }

  func disconnect() {
    GIDSignIn.sharedInstance.disconnect { error in
      if let error = error {
        print("Encountered error disconnecting scope: \(error).")
      }
      self.signOut()
    }
  }
}

private extension GoogleSignInAuthenticator {
  func decodeNonce(fromJWT jwt: String) -> String? {
    let segments = jwt.components(separatedBy: ".")
    guard let parts = decodeJWTSegment(segments[1]),
       let nonce = parts["nonce"] as? String else {
      return nil
    }
    return nonce
  }

  func decodeJWTSegment(_ segment: String) -> [String: Any]? {
    guard let segmentData = base64UrlDecode(segment),
       let segmentJSON = try? JSONSerialization.jsonObject(with: segmentData,
                                 options: []),
       let payload = segmentJSON as? [String: Any] else {
      return nil
    }
    return payload
  }

  func base64UrlDecode(_ value: String) -> Data? {
    var base64 = value
      .replacingOccurrences(of: "-", with: "+")
      .replacingOccurrences(of: "_", with: "/")
    let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
    let requiredLength = 4 * ceil(length / 4.0)
    let paddingLength = requiredLength - length
    if paddingLength > 0 {
      let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
      base64 = base64 + padding
    }
    return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
  }
}
