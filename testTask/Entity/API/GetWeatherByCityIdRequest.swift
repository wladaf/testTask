//
// Created by Владислав Афанасьев on 08/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import ObjectMapper

class GetWeatherByCityIdRequest: APIRequest {
    let method: String = "data/2.5/weather"

    private var id = 498817
    private var appId = "206c7e5250c394570f876038ac6ee3d8"

    init() {}

    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        appId <- map["APPID"]
    }
}