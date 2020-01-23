//
//  SearchCountryInteractor.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/23/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs
import RxSwift

protocol SearchCountryRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchCountryPresentable: Presentable {
    var listener: SearchCountryPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchCountryListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchCountryInteractor: PresentableInteractor<SearchCountryPresentable>, SearchCountryInteractable, SearchCountryPresentableListener {

    weak var router: SearchCountryRouting?
    weak var listener: SearchCountryListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchCountryPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
