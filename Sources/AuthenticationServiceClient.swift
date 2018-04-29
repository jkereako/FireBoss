//
//  AuthenticationServiceClient.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/28/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import Foundation
import Firebase

final class AuthenticationServiceClient {
    private let authenticationService: Auth

    init(authenticationService: Auth = Auth.auth()) {
        self.authenticationService = authenticationService
    }

    func registerUserWithEmail(_ email: String, password: String,
                               completionHandler: @escaping (_ error: Error?) -> ()) {
        authenticationService.createUser(withEmail: email, password: password) { (_, error) in
            completionHandler(error)
        }
    }

    func signInWithEmail(_ email: String, password: String,
                         completionHandler: @escaping (_ error: Error?) -> ()) {
        authenticationService.signIn(withEmail: email, password: password) { (user, error) in
            completionHandler(error)
        }
    }
}
