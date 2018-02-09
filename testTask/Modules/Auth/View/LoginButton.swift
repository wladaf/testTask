//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import UIKit

class LoginButton: UIButton {
    var action: () -> () = {}

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue

            if isHighlighted {
                backgroundColor = UIColor.customOrange.withAlphaComponent(0.8)
            } else {
                backgroundColor = .customOrange
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

        backgroundColor = .customOrange
        setTitle(StringManager.Auth.login, for: UIControlState())
        setTitleColor(.white, for: UIControlState())
        titleLabel?.font = UIFont.systemFont(ofSize: 15)

        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.frame.height / 2
    }

    @objc func onTouchUpInside() {
        action()
    }
}