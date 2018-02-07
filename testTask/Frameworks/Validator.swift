//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

enum ValidatorResult {
    case ok
    case failed(description: String)
}

class Validator {
    func validateEmail(_ email: String) -> ValidatorResult {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        if validate(email, withRegex: emailRegEx) {
            return .ok
        } else {
            return .failed(description: StringManager.Validator.emailValidationFailed)
        }
    }

    func validatePassword(_ password: String) -> ValidatorResult {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}&"

        if validate(password, withRegex: passwordRegEx) {
            return .ok
        } else {
            return .failed(description: StringManager.Validator.passwordValidationFailed)
        }
    }

    private func validate(_ string: String, withRegex regex: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: string)
    }
}