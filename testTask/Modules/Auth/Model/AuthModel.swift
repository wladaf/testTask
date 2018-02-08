//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import RxSwift

class AuthModel {
    lazy private var weatherApiAdapter: WeatherAPIAdapter = { return WeatherAPIAdapter() }()
    lazy private var disposeBag: DisposeBag = { return DisposeBag() }()

    func login(withCompletion completion: @escaping (String) -> (), errorBlock: @escaping (String) -> ()) {
        weatherApiAdapter.getWeatherForSaintPetersburg().subscribe(onNext: { data in
            let c = data.temp - 273.15
            let cString = String(format: "%.2f", c)
            completion(StringManager.Alert.temperatureInPetersburg + ": " + cString + " градусов по Цельсию")
        }, onError: { error in
            errorBlock(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}