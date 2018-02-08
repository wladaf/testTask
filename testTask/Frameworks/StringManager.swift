//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class StringManager {
    struct Alert {
        static let attention = "attention".localized()
        static let ok = "OK".localized()

        static let forgotPasswordText = "forgotPasswordText".localized()
        static let registerText = "registerText".localized()

        static let temperatureInPetersburg = "temp".localized()
    }

    struct Auth {
        static let title = "Authorization".localized()
        static let login = "login".localized()
        static let createNewAccount = "createNewAccount".localized()
        static let forgotPassword = "forgotPassword".localized()

        static let email = "email".localized()
        static let password = "password".localized()
    }

    struct Validator {
        static let emailValidationFailed = "EmailHasWrongFormat".localized()
        static let passwordValidationFailed = "PasswordHasWrongFormat".localized()
    }
}