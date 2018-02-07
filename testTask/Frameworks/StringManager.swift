//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class StringManager {
    struct Alert {
        static let attention = "attention".localized()
        static let ok = "OK".localized()
    }

    struct Auth {
        static let login = "login".localized()
        static let createNewAccount = "createNewAccount".localized()
        static let forgotPassword = "forgotPassword".localized()
    }

    struct Validator {
        static let emailValidationFailed = "EmailHasWrongFormat".localized()
        static let passwordValidationFailed = "PasswordHasWrongFormat".localized()
    }
}