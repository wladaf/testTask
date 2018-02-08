//
// Created by Владислав Афанасьев on 08/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import UIKit

class RegisterButton: UIButton {
    var action: () -> () = {}

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)

        customize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        customize()
    }

    private func customize() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .clear
        setTitle(StringManager.Auth.createNewAccount, for: UIControlState())
        setTitleColor(.customBlue, for: UIControlState())
        titleLabel?.font = UIFont.systemFont(ofSize: 15)

        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
    }

    @objc func onTouchUpInside() {
        action()
    }
}