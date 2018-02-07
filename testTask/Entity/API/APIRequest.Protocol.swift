//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import ObjectMapper

protocol APIRequest: Mappable {
    var method: String { get }
}