//
//  DetailsInteractor.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/29/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs
import RxSwift

protocol DetailsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DetailsPresentable: Presentable {
    var listener: DetailsPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setData(country: Country)
}

protocol DetailsListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DetailsInteractor: PresentableInteractor<DetailsPresentable>, DetailsInteractable, DetailsPresentableListener {

    weak var router: DetailsRouting?
    weak var listener: DetailsListener?

    var country: Country?
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: DetailsPresentable, country: Country) {
        self.country = country
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        presenter.setData(country: country ?? Country(flag: "", name: "", capital: "", alpha2Code: "", population: 0))
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
