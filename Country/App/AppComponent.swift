//
//  AppComponent.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/23/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs

class AppComponent: Component<EmptyDependency>, SearchCountryDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
