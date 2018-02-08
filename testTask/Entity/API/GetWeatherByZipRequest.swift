//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import ObjectMapper

class GetWeatherByZipRequest: APIRequest {
    let method: String = "data/2.5/weather"

    private var zip: Int!
    private var countryCode: String!

    private var appId = "206c7e5250c394570f876038ac6ee3d8"

    init(withZip zip: Int, andCountryCode code: String) {
        self.zip = zip
        self.countryCode = code
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        var zipPlusCountryCode = "\(zip),\(countryCode)"
        zip <- map["zip"]
        appId <- map["APPID"]
    }
}