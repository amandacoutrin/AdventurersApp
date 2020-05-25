//
//  MainRouter.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 23/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

@objc protocol MainViewRoutingLogic {
    func routeToHome()
}

class MainViewRouter: NSObject, MainViewRoutingLogic {
    
    // MARK: Archtecture Objects
    
    weak var viewController: MainViewController?
    
    // MARK: Routing
    
    func routeToHome() {
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .currentContext
        viewController?.present(homeVC, animated: false, completion: nil)
    }
}
