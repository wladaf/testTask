//
// Created by Владислав Афанасьев on 07/02/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import ObjectMapper
import RxSwift

class WeatherAPI {
    lazy private var disposeBag: DisposeBag = { return DisposeBag() }()
    private let baseURL = "api.openweathermap.org/"

    func sendRequest<T: APIResponse>(_ request: APIRequest) -> Observable<T> {
        let url = baseURL + request.method
        let parameters = request.toJSON()

        return RxAlamofire.request(.get, url, parameters: parameters)
                .flatMap { request -> Observable<T> in
                    let validatedRequest = request.validate(statusCode: 200..<300)
                            .validate(contentType: ["text/json"])

                    return validatedRequest.rx.json().flatMap { json -> Observable<T> in
                        if let jsonDict = json as? [String: AnyObject],
                           let response = T.init(JSON: jsonDict) {
                            return Observable.of(response)
                        } else {
                            return Observable.error(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                    }
                }.observeOn(MainScheduler.instance)
    }
}