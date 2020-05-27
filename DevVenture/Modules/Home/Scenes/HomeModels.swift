//
//  HomeModels.swift
//  DevVenture
//
//  Created by Amanda Coutrin on 23/05/20.
//  Copyright (c) 2020 Amanda. All rights reserved.
//

import UIKit

enum Home {
    enum Model {
        struct Request {
            let url = URL(string: "https://gist.githubusercontent.com/amandacoutrin/052853920631c3ebbd26f6630e88cb87/raw/cd2c95ede469e37a1672d97924712f9c02217b56/adventurers")
        }
        
        struct Response: Codable {
            let adventurers: [Adventurers]
        }
        
        struct Adventurers: Codable {
            let adventurers : [Adventurer]?
            
            enum CodingKeys: String, CodingKey {
                case adventurers = "adventurers"
            }
        }
        
        struct Adventurer: Codable {
            let id : Int?
            let name : String?
            let surname : String?
            let description : String?
            let socialNetworking : SocialNetworking?
            let imageName: String?
            
            enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
                case surname = "surname"
                case description = "description"
                case socialNetworking = "socialNetworking"
                case imageName = "imageName"
            }
        }
        
        struct SocialNetworking : Codable {
            let facebook : String?
            let linkedin : String?
            let twitter : String?
            let instagram : String?
            
            enum CodingKeys: String, CodingKey {
                case facebook = "facebook"
                case linkedin = "linkedin"
                case twitter = "twitter"
                case instagram = "instagram"
            }
        }
        
        struct PhotoCardViewModel {
            let photoCardMenus: [PhotoCardMenuModel.Button]
        }
        
        struct DetailsViewModel {
            let name: String
            let description: String
        }
    }
    
}

