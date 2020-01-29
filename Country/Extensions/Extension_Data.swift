//
//  Extension_Data.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/24/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import Foundation

extension String: Error {}

extension Data {
    func toObject<T>(type: T.Type) throws -> T where T : Decodable {
        guard let object = try? JSONDecoder().decode(type, from: self) else{
            throw "Decoding error"
        }
        
        return object
    }
}
