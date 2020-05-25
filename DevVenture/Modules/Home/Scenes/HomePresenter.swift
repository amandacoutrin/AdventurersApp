//
//  HomePresenter.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 23/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentPhotoCardMenu(adventurers: [Home.Model.Adventurer])
    func presentAdventurerDetails(adventurer: Home.Model.Adventurer)
}

class HomePresenter: HomePresentationLogic {
    
    // MARK: Archtecture Objects
    
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Functions
    
    func presentPhotoCardMenu(adventurers: [Home.Model.Adventurer]) {
        let adventurersCardMenu = adventurers.compactMap {
            PhotoCardMenuModel.Button(id: $0.id ?? 0, name: $0.name ?? "", photoName: $0.imageName)
        }
        let photoCardViewModel = Home.Model.PhotoCardViewModel(photoCardMenus: adventurersCardMenu)
        viewController?.displayPhotoCard(viewModel: photoCardViewModel)
    }
    
    func presentAdventurerDetails(adventurer: Home.Model.Adventurer) {
        let detailsViewModel = Home.Model.DetailsViewModel(name: adventurer.name ?? "",
                                                           description: adventurer.description ?? "")
        viewController?.displayDetails(viewModel: detailsViewModel)
    }
}
