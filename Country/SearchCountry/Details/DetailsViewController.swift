//
//  DetailsViewController.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/29/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol DetailsPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class DetailsViewController: UIViewController, DetailsPresentable, DetailsViewControllable {

    weak var listener: DetailsPresentableListener?
}
