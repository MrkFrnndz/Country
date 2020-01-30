//
//  SearchCountryBuilder.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/23/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs

protocol SearchCountryDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchCountryComponent: Component<SearchCountryDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    let searchCountryViewController: SearchCountryViewController
    
    var countryService = CountryService()

    init(dependency: SearchCountryDependency,
         searchCountryViewController: SearchCountryViewController,
         countryService: CountryService) {
        self.searchCountryViewController = searchCountryViewController
        self.countryService = countryService
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol SearchCountryBuildable: Buildable {
    func build() -> LaunchRouting
}

final class SearchCountryBuilder: Builder<SearchCountryDependency>, SearchCountryBuildable {

    override init(dependency: SearchCountryDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let countryService = CountryService()
        
        let viewController = SearchCountryViewController()
        let component = SearchCountryComponent(dependency: dependency,
                                               searchCountryViewController: viewController,
                                               countryService: countryService)
        let interactor = SearchCountryInteractor(presenter: viewController,
                                                 countryService: countryService)
        let detailsBuilder = DetailsBuilder(dependency: component)
        return SearchCountryRouter(interactor: interactor,
                                   viewController: viewController,
                                   detailsBuilder: detailsBuilder)
    }
}
