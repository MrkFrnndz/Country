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
    func routeToDetails(country: Country)
    func detachCurrentChild()
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
    
    private var countries: [Country] = []
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
        
        fetchCountry()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func searchCountry(_ q: String) {
        let searched = self.countries.filter({ country in country.name.contains(q) || country.alpha2Code.contains(q) || country.capital.contains(q) })
        print("SEARCHED : \(searched)")
        
        presenter.setData(countries: searched)
    }
    
    func fetchCountry() {
        countryService.getAllCountry()
        .subscribe(onSuccess: { [weak self] countries in
            
            self?.countries.removeAll()
            self?.countries.append(contentsOf: countries)
            
            self?.presenter.setData(countries: countries)
            })
        .disposeOnDeactivate(interactor: self)
    }
    
    func goToDetails(country: Country) {
        router?.routeToDetails(country: country)
    }
}
