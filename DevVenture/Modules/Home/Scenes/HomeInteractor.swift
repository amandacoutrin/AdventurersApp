//
//  HomeInteractor.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 23/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func loadScreenValues()
    func selectAdventurer(id: Int)
}

protocol HomeDataStore {
    var adventurers: [Home.Model.Adventurer]? { get set }
    var selectedAdventurer: Int { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    // MARK: - DataStore
    
    var adventurers: [Home.Model.Adventurer]?
    var selectedAdventurer: Int = 0
    
    // MARK: - Archtecture Objects
    
    var presenter: HomePresentationLogic?
    let worker: HomeWorker
    
    // MARK: - Init
    
    init(worker: HomeWorker = HomeWorker()) {
        self.worker = worker
    }
    
    // MARK: - Functions
    
    func loadScreenValues() {
        let request = Home.Model.Request()
        worker.fetchAdventurers(request: request) { [weak self] result in
            guard let self = self, let advList = result else { return }
            self.adventurers = advList
            self.presenter?.presentPhotoCardMenu(adventurers: advList)
            guard advList.indices.contains(self.selectedAdventurer) else { return }
            self.presenter?.presentAdventurerDetails(adventurer: advList[self.selectedAdventurer])
        }
    }
    
    func selectAdventurer(id: Int) {
        guard let adv = adventurers?.first(where: { $0.id == id } ) else { return }
        selectedAdventurer = id
        self.presenter?.presentAdventurerDetails(adventurer: adv)
    }
}
