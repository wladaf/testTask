//
// Created by Владислав Афанасьев on 08/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import UIKit

class RegisterButton: UIButton {
    var action: () -> () = {}

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue

            if isHighlighted {
                setTitleColor(.gray, for: UIControlState())
            } else {
                setTitleColor(.customBlue, for: UIControlState())
            }
        }
    }

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

        backgroundColor = .white
        setTitle(StringManager.Auth.createNewAccount, for: UIControlState())
        setTitleColor(.customBlue, for: UIControlState())
        titleLabel?.font = UIFont.systemFont(ofSize: 15)

        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
    }

    @objc func onTouchUpInside() {
        action()
    }
}