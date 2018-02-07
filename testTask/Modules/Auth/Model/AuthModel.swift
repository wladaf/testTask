//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

class AuthModel {
    lazy private var weatherApiAdapter: WeatherAPIAdapter = { return WeatherAPIAdapter() }()

    func login(withCompletion completion: @escaping (String) -> ()) {
        completion("Results")
    }
}