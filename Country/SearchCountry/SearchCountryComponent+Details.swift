//
//  SearchCountryComponent+Details.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/29/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of SearchCountry to provide for the Details scope.
// TODO: Update SearchCountryDependency protocol to inherit this protocol.
protocol SearchCountryDependencyDetails: Dependency {
    // TODO: Declare dependencies needed from the parent scope of SearchCountry to provide dependencies
    // for the Details scope.
}

extension SearchCountryComponent: DetailsDependency {
    // TODO: Implement properties to provide for Details scope.
}
