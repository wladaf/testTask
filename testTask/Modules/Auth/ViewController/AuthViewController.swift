//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import UIKit
import RxKeyboard
import RxSwift

class AuthViewController: UIViewController {
    lazy private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.view.addSubview(view)
        return view
    }()

    lazy private var emailTextField: TextFieldWithAnimatedPlaceholder = {
        let textField = TextFieldWithAnimatedPlaceholder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setKeyboardType(.emailAddress)
        textField.placeholderText = StringManager.Auth.email
        self.contentView.addSubview(textField)
        return textField
    }()

    lazy private var emailSeparatorLine: SeparatorLine = {
        let view = SeparatorLine()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        return view
    }()

    lazy private var passwordTextField: TextFieldWithAnimatedPlaceholder = {
        let textField = TextFieldWithAnimatedPlaceholder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholderText = StringManager.Auth.password
        textField.setSecure(true)
        self.contentView.addSubview(textField)
        return textField
    }()

    lazy private var passwordSeparatorLine: SeparatorLine = {
        let view = SeparatorLine()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        return view
    }()

    lazy private var loginButton: LoginButton = {
        let button = LoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.action = self.login
        self.contentView.addSubview(button)
        return button
    }()

    lazy private var registerButton: RegisterButton = {
        let button = RegisterButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.action = self.register
        self.contentView.addSubview(button)
        return button
    }()

    lazy private var forgotPasswordButton: ForgotPasswordButton = {
        let button = ForgotPasswordButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.action = self.forgotPassword
        self.contentView.addSubview(button)
        return button
    }()

    lazy private var viewModel: AuthViewModel = {
        let router = AuthRouter(withRootViewController: self)
        return AuthViewModel(withRouter: router)
    }()

    lazy private var disposeBag: DisposeBag = {
        return DisposeBag()
    }()

    private let defaultInset: CGFloat = 15.0

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func endEditing() {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = StringManager.Auth.title

        let backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        backBarButtonItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        backBarButtonItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .highlighted)
        navigationItem.backBarButtonItem = backBarButtonItem

        setConstraints()
    }

    private func setConstraints() {
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultInset).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultInset).isActive = true
        let contentViewYConstraint = contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        contentViewYConstraint.isActive = true

        RxKeyboard.instance.visibleHeight.drive(onNext: { height in
            contentViewYConstraint.constant = -height/2
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }).disposed(by: disposeBag)

        emailTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive =  true
        emailTextField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true

        emailSeparatorLine.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        emailSeparatorLine.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        emailSeparatorLine.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 4).isActive = true

        passwordTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSeparatorLine.bottomAnchor, constant: 12).isActive = true

        forgotPasswordButton.leftAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: 12).isActive = true
        forgotPasswordButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        forgotPasswordButton.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 3/5).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor, multiplier: 0.8).isActive = true

        passwordSeparatorLine.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        passwordSeparatorLine.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        passwordSeparatorLine.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4).isActive = true

        loginButton.topAnchor.constraint(equalTo: passwordSeparatorLine.bottomAnchor, constant: 34).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/5).isActive = true
        loginButton.heightAnchor.constraint(equalTo: loginButton.widthAnchor, multiplier: 1/3).isActive = true

        registerButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        registerButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 21).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func login() {
        let email = emailTextField.text
        let password = passwordTextField.text

        viewModel.login(withEmail: email, password: password)
    }

    private func register() {
        viewModel.register()
    }

    private func forgotPassword() {
        viewModel.forgotPassword()
    }
}