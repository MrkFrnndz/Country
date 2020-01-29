//
//  DetailsRouter.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/29/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs

protocol DetailsInteractable: Interactable {
    var router: DetailsRouting? { get set }
    var listener: DetailsListener? { get set }
}

protocol DetailsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DetailsRouter: ViewableRouter<DetailsInteractable, DetailsViewControllable>, DetailsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DetailsInteractable, viewController: DetailsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
