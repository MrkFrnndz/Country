//
//  SearchCountryRouter.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/23/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs

protocol SearchCountryInteractable: Interactable, DetailsListener {
    var router: SearchCountryRouting? { get set }
    var listener: SearchCountryListener? { get set }
}

protocol SearchCountryViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class SearchCountryRouter: LaunchRouter<SearchCountryInteractable, SearchCountryViewControllable>, SearchCountryRouting {

    var detailsBuilder: DetailsBuildable
    private var currentChild: ViewableRouting?

    override func didLoad() {
        super.didLoad()
    }
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SearchCountryInteractable,
         viewController: SearchCountryViewControllable,
         detailsBuilder: DetailsBuildable) {
        self.detailsBuilder = detailsBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
            self.currentChild = nil
        }
    }
    
    func routeToDetails(country: Country) {
        let child = detailsBuilder.build(withListener: interactor, country: country)
        self.currentChild = child
        viewController.uiviewController.modalPresentationStyle = .overFullScreen
        viewController.present(viewController: child.viewControllable)
        attachChild(child)
    }
}
