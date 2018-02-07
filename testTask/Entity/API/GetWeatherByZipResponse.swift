//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import ObjectMapper

class GetWeatherByZipResponse: APIResponse {

    var temp: Double!

    required init?(map: ObjectMapper.Map) {

    }

    func mapping(map: ObjectMapper.Map) {
        temp <- map["main.temp"]
    }
}