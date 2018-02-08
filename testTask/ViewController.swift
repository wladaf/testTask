//
//  ViewController.swift
//  testTask
//
//  Created by Владислав Афанасьев on 07/02/2018.
//  Copyright © 2018 Владислав Афанасьев. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func loadView() {
        super.loadView()

        let loginButton = LoginButton()
        loginButton.setTitle(StringManager.Auth.title, for: UIControlState())
        loginButton.action = {
            let controller = AuthViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }

        view.addSubview(loginButton)

        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        loginButton.heightAnchor.constraint(equalTo: loginButton.widthAnchor, multiplier: 1/3).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = " "
    }


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }



}
