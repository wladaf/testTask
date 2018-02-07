//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import UIKit

class AuthRouter {
    private let viewController: UIViewController

    init(withRootViewController viewController: UIViewController) {
        self.viewController = viewController
    }

    func showAlertView(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: StringManager.Alert.ok, style: .cancel))
        viewController.present(alertController, animated: true)
    }
}