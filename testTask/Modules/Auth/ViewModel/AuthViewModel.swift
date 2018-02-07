//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class AuthViewModel {
    lazy private var validator: Validator = { return Validator() }()
    lazy private var model: AuthModel = { return AuthModel() }()

    private let router: AuthRouter

    init(withRouter router: AuthRouter) {
        self.router = router
    }

    private func login(withEmail email: String, password: String) {
        let emailValidationResult = validator.validateEmail(email)
        let passwordValidationResult = validator.validatePassword(password)

        switch (emailValidationResult, passwordValidationResult) {
            case (.ok, .ok):
                model.login() { temp in
                    self.router.showAlertView(withTitle: StringManager.Alert.attention, message: temp)
                }
            case (.failed(let description), _),
                 (.ok, .failed(let description)):
                router.showAlertView(withTitle: StringManager.Alert.attention, message: description)
        }
    }
}