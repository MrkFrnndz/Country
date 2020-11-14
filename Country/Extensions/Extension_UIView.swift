//
//  Extension_UIView.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/23/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import UIKit

protocol HasAddTo { }

extension HasAddTo {
    func addTo(_ view: UIView) {
        view.addSubview(self as! UIView)
    }
}

extension UIView : HasAddTo { }


//extension UIView: SVGView {}
