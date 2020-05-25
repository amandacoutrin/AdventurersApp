//
//  AdventurerDetailsInteractor.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 24/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

protocol AdventurerDetailsBusinessLogic {
    func loadSocialNetworking()
}

protocol AdventurerDetailsDataStore {
    var socialNetworkings: Home.Model.SocialNetworking? { get set }
    var adventurerName: String? { get set }
}

class AdventurerDetailsInteractor: AdventurerDetailsBusinessLogic, AdventurerDetailsDataStore {
    
    // MARK: Archtecture Objects
    
    var presenter: AdventurerDetailsPresentationLogic?
    
    //MARK: - DataStore Objects
    
    var socialNetworkings: Home.Model.SocialNetworking?
    var adventurerName: String?
    
    // MARK: Functions
    
    func loadSocialNetworking() {
        guard let name = adventurerName,
            let socialNets = socialNetworkings else { return }
        presenter?.presentAdventurerData(name: name, socialNetwrokings: socialNets)
    }
}
