//
//  CountryService.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/23/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

protocol CountryServiceProtocol {
    func getAllCountry() -> Single<[Country]>
    func getSpecificCountry()
}

final class CountryService: CountryServiceProtocol {
    func getSpecificCountry() {
        
    }
    
    
    func getAllCountry() -> Single<[Country]> {
        return Single<[Country]>.create { [self] single in
            Alamofire.request("https://restcountries.eu/rest/v2/all",
                              method: .get,
                              parameters: nil,
                              encoding: URLEncoding.queryString,
                              headers: nil)
                .responseJSON { response in
                    
                    guard response.error == nil else {
                        print("response.error")
                        single(.error(response.error!))
                        return
                    }

                    guard let data = response.data else {
                        return
                    }

                    guard let json = try? JSONSerialization.jsonObject(with: data) as? [Any] else {
                        print("Nil data received from server")
                        return
                    }
                    
                    var countries: [Country] = []
                    if json != nil {
                        for jsonObject in json {
                            
                            //Serialize the Dictionary into a JSON Data representation, then decode it using the Decoder().
                            if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []) {
                                guard let parsedData = try? data.toObject(type: Country.self) else {
                                    guard let error = try? data.toObject(type: ErrorResponse.self) else {
                                        single(.error("Country could not be decoded."))
                                        return
                                    }
                                    single(.error(error.error.toThrowable()))
                                    return
                                }
                                print(parsedData)
                                countries.append(parsedData)
                            }
                        }
                        print("success")
                    } else {
                        return
                    }
                    single(.success(countries))
                    
                    
                    
                    
                    
            }
            
            return Disposables.create()
        }
    }
    
}
