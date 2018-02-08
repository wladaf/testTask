//
// Created by Владислав Афанасьев on 08/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import UIKit

class SeparatorLine: UIView {
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)

        customize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        customize()
    }

    private func customize() {
        backgroundColor = UIColor.customGray.withAlphaComponent(0.5)
        heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}