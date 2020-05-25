//
//  HomeRouter.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 23/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToAdventurerDetails()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    
    // MARK: Archtecture Objects
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    // MARK: Routing
    
    func routeToAdventurerDetails() {
        let adventurerDetailsVC = AdventurerDetailsViewController()
        var adventurerDS = adventurerDetailsVC.router?.dataStore
        passData(source: dataStore, destination: &adventurerDS)
        viewController?.present(adventurerDetailsVC, animated: true)
    }
    
    func passData(source: HomeDataStore?, destination: inout AdventurerDetailsDataStore?) {
        guard let source = source,
            let adventures = source.adventurers else { return }
        let advID = source.selectedAdventurer
        let selectedAdv = adventures[advID]
        destination?.adventurerName = selectedAdv.name
        destination?.socialNetworkings = selectedAdv.socialNetworking
    }
    
}
