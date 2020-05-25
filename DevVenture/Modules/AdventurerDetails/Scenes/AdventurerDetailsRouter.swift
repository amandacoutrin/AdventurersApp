//
//  AdventurerDetailsRouter.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 24/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

@objc protocol AdventurerDetailsRoutingLogic {}

protocol AdventurerDetailsDataPassing {
    var dataStore: AdventurerDetailsDataStore? { get }
}

class AdventurerDetailsRouter: NSObject, AdventurerDetailsRoutingLogic, AdventurerDetailsDataPassing {
    
    // MARK: Archtecture Objects
    
    weak var viewController: AdventurerDetailsViewController?
    var dataStore: AdventurerDetailsDataStore?
   
}
