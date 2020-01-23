//
//  Extension_UIFont.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/23/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func appRegularFontWith(ofSize: CGFloat) -> UIFont{
        return  UIFont(name: "Nunito-Regular", size: ofSize)!
    }
    class func appBoldFontWith(ofSize: CGFloat) -> UIFont{
        return  UIFont(name: "Nunito-Bold", size: ofSize)!
    }
}

