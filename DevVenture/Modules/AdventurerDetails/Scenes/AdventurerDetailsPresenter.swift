//
//  AdventurerDetailsPresenter.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 24/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

protocol AdventurerDetailsPresentationLogic {
    func presentAdventurerData(name: String, socialNetwrokings: Home.Model.SocialNetworking)
}

class AdventurerDetailsPresenter: AdventurerDetailsPresentationLogic {
    
    // MARK: Archtecture Objects
    
    weak var viewController: AdventurerDetailsDisplayLogic?
    
    // MARK: Functions
    
    func presentAdventurerData(name: String, socialNetwrokings: Home.Model.SocialNetworking) {
        let socialNetworking = [socialNetwrokings.facebook,
                                socialNetwrokings.instagram,
                                socialNetwrokings.linkedin,
            socialNetwrokings.twitter].compactMap({$0}).joined(separator: "\n\n")
        let viewModel = AdventurerDetails.Model.ViewModel(name: name, detailsText: socialNetworking)
        viewController?.displayAdventurer(viewModel: viewModel)
    }
}
