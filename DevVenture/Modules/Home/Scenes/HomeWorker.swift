//
//  HomeWorker.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 23/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

class HomeWorker {
    
    // MARK: Functions
    
    func fetchAdventurers(request: Home.Model.Request, completion: @escaping ([Home.Model.Adventurer]?) -> Void) {
        guard let url = request.url else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode), let jsonData = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let jsonBase = try decoder.decode(Home.Model.Adventurers.self, from: jsonData)
                let adventurers = jsonBase.adventurers
                completion(adventurers)
            } catch {
                print("ERROR")
            }
            
        }
        task.resume()
    }
    
    
}

