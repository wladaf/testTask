//
// Created by Владислав Афанасьев on 27.11.17.
// Copyright (c) 2017 Livemaster. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class TextFieldWithAnimatedPlaceholder: UIView {
	fileprivate enum TextFieldWithAnimatedPlaceholderState {
		case empty
		case filled
	}

	var maxLength: Int = 0

	private var textField: UITextField!
	private var placeholderLabel: UILabel!


	fileprivate var state: TextFieldWithAnimatedPlaceholderState

	private let disposeBag: DisposeBag

	var isEditingEnabled: Bool = true {
		didSet {
			textField.isUserInteractionEnabled = isEditingEnabled
		}
	}

	var isEmpty: Bool {
		return textField.text?.isEmpty ?? true
	}

	var placeholderText: String = "" {
		didSet {
			placeholderLabel.text = placeholderText
		}
	}

	var text: String {
		return textField.text ?? ""
	}

	var valueChangedAction: ( (String?) -> () )?

	private let bigFontSize: CGFloat = 16.0
	private let smallFontSize: CGFloat = 13.0

	private let viewDefaultInset: CGFloat = 6.0

	private var smallFontLineHeight: CGFloat { return UIFont.systemFont(ofSize: smallFontSize).lineHeight }
	private var bigFontLineHeight: CGFloat { return UIFont.systemFont(ofSize: bigFontSize).lineHeight }

	private var fullHeight: CGFloat { return smallFontLineHeight + bigFontLineHeight + 3 * self.viewDefaultInset }

	private let animationDuration: Double = 0.2

	private var textFieldHeightConstraint: NSLayoutConstraint!

	private var placeholderLabelHeightConstraint: NSLayoutConstraint!
	private var placeholderLabelTopSpaceConstraint: NSLayoutConstraint!
	private var placeholderLabelBottomSpaceConstraint: NSLayoutConstraint!

	override init(frame: CGRect = CGRect.zero) {
		state = .empty
		disposeBag = DisposeBag()
		super.init(frame: frame)
		initSubviews()
	}

	required init?(coder aDecoder: NSCoder) {
		state = .empty
		disposeBag = DisposeBag()
		super.init(coder: aDecoder)
		initSubviews()
	}

	private func initSubviews() {
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(startEditing))
		self.addGestureRecognizer(tapRecognizer)

		textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.borderStyle = .none
		textField.delegate = self

		textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)

		textField.autocorrectionType = .no
		textField.spellCheckingType = .no

		if let font = textField.font?.withSize(bigFontSize) {
			textField.font = font
		}

		addSubview(textField)

		placeholderLabel = UILabel()
		placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
		placeholderLabel.textColor = .gray
		placeholderLabel.baselineAdjustment = .alignCenters

		if let font = placeholderLabel.font?.withSize(smallFontSize) {
			placeholderLabel.font = font
		}

		addSubview(placeholderLabel)

		setConstraints()
	}

	@objc func textChanged() {
		var value: String? = nil

		if let text = textField.text, text.isEmpty == false {
			value = textField.text
		}

		valueChangedAction?(value)
	}

	private func setConstraints() {
		self.heightAnchor.constraint(equalToConstant: fullHeight).isActive = true

		placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		placeholderLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

		textField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

		textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -viewDefaultInset).isActive = true


		placeholderLabelBottomSpaceConstraint = placeholderLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -viewDefaultInset)
		placeholderLabelBottomSpaceConstraint.isActive = true

		placeholderLabelTopSpaceConstraint = placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: viewDefaultInset)
		placeholderLabelTopSpaceConstraint.isActive = true

		textFieldHeightConstraint = textField.heightAnchor.constraint(equalToConstant: bigFontLineHeight)
		textFieldHeightConstraint.isActive = true

		changeState(.empty, animated: false)
	}

	fileprivate func changeState(_ newState: TextFieldWithAnimatedPlaceholderState, animated: Bool = true) {
		state = newState

		switch state {
			case .empty:
				setEmptyState(animated: animated)
			case .filled:
				setFilledState(animated: animated)
		}
	}

	private func setEmptyState(animated: Bool) {
		self.textFieldHeightConstraint.constant = 0.0

		self.placeholderLabelTopSpaceConstraint.constant = fullHeight - 2 * viewDefaultInset - smallFontLineHeight
		self.placeholderLabelBottomSpaceConstraint.constant = 0

		self.placeholderLabel.font = self.placeholderLabel.font.withSize(self.bigFontSize)

		if animated {
			animateLayout()
		} else {
			self.layoutIfNeeded()
		}
	}

	private func setFilledState(animated: Bool) {
		self.textFieldHeightConstraint.constant = bigFontLineHeight

		self.placeholderLabelTopSpaceConstraint.constant = viewDefaultInset
		self.placeholderLabelBottomSpaceConstraint.constant = -viewDefaultInset

		self.placeholderLabel.font = self.placeholderLabel.font.withSize(self.smallFontSize)

		self.textField.becomeFirstResponder()

		if animated {
			animateLayout()
		} else {
			self.layoutIfNeeded()
		}
	}

	private func animateLayout() {
		UIView.animate(withDuration: animationDuration) {
			self.layoutIfNeeded()
		}
	}

	@objc private func startEditing() {
		if isEditingEnabled {
			changeState(.filled)
		}
	}

	func setSecure(_ value: Bool) {
		textField.isSecureTextEntry = value
	}

    func setKeyboardType(_ type: UIKeyboardType) {
        textField.keyboardType = type
    }
}

extension TextFieldWithAnimatedPlaceholder: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if maxLength == 0 { return true }
		guard let text = textField.text else { return true }
		
		let newLength = text.characters.count + string.characters.count - range.length
		return newLength <= maxLength
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField.text?.isEmpty ?? true {
			switch state {
				case .filled:
					changeState(.empty)
				default:
					break
			}
		}
	}

    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeState(.filled)
    }
}
