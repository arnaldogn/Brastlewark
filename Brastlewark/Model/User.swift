//
//  User.swift
//  Brastlewark
//
//  Created by Arnaldo Gnesutta on 11/04/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//
import GoogleSignIn

struct User {
    var userId: String?
    var idToken: String?
    var fullName: String?
    var givenName: String?
    var familyName: String?
    var email: String?    
}

extension User {
    init(user: GIDGoogleUser) {
        self.userId = user.userID
        self.idToken = user.authentication.idToken
        self.fullName = user.profile.name
        self.givenName = user.profile.givenName
        self.familyName = user.profile.familyName
        self.email = user.profile.email
    }
}
