//
//  SearchCountryRouter.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/23/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs

protocol SearchCountryInteractable: Interactable {
    var router: SearchCountryRouting? { get set }
    var listener: SearchCountryListener? { get set }
}

protocol SearchCountryViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchCountryRouter: LaunchRouter<SearchCountryInteractable, SearchCountryViewControllable>, SearchCountryRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchCountryInteractable, viewController: SearchCountryViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
