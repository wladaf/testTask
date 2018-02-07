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

    init(withZip zip: Int, andCountryCode code: String) {
        self.zip = zip
        self.countryCode = code
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        var zipPlusCountryCode = "\(zip),\(countryCode)"
        zip <- map["zip"]
    }
}