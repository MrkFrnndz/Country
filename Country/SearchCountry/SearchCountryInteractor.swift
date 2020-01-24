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
    func setData(countries: [Country])
}

protocol SearchCountryListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchCountryInteractor: PresentableInteractor<SearchCountryPresentable>, SearchCountryInteractable, SearchCountryPresentableListener {

    weak var router: SearchCountryRouting?
    weak var listener: SearchCountryListener?

    private var countryService = CountryService()
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SearchCountryPresentable,
                  countryService: CountryService) {
        self.countryService = countryService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        
        countryService.getAllCountry()
        .subscribe(onSuccess: { [weak self] countries in
            self?.presenter.setData(countries: countries)
            })
        .disposeOnDeactivate(interactor: self)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
