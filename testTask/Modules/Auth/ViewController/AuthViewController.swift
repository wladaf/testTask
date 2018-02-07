//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import UIKit

class AuthViewController: UIViewController {
    lazy private var viewModel: AuthViewModel = {
        let router = AuthRouter(withRootViewController: self)
        return AuthViewModel(withRouter: router)
    }()

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white
    }
}