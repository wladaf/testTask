//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import RxSwift

class WeatherAPIAdapter {
    lazy private var weatherAPI: WeatherAPI = { return WeatherAPI() }()

    func getWeather(byZip zip: Int, andCountryCode countryCode: String) -> Observable<GetWeatherByZipResponse> {
        let request = GetWeatherByZipRequest(withZip: zip, andCountryCode: countryCode)
        return weatherAPI.sendRequest(request)
    }
}