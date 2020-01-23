//
//  Extension_LanguageFeatures.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/23/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import UIKit
protocol HasApply { }

extension HasApply {
    func apply(closure:(Self) -> ()) -> Self {
        closure(self)
        return self
    }
}

extension UIView: HasApply { }
extension UICollectionViewLayout: HasApply { }
