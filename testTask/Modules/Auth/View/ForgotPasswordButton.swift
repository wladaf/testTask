//
// Created by Владислав Афанасьев on 08/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class ForgotPasswordButton: UIButton {
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

        backgroundColor = .white
        setTitle(StringManager.Auth.forgotPassword, for: UIControlState())
        setTitleColor(.customGray, for: UIControlState())
        titleLabel?.font = UIFont.systemFont(ofSize: 12)

        layer.borderWidth = 1
        layer.borderColor = UIColor.customLightGray.cgColor

        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.frame.height / 5
    }

    @objc func onTouchUpInside() {
        action()
    }
}