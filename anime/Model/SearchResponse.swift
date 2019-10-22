//
//  SearchResponse.swift
//  anime
//
//  Created by moafaq waleed simbawa on 23/02/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import Foundation


struct SearchResponse :Codable{
    let results : [AnimeSearch]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct AnimeSearch : Codable{
    let id : Int
    let title : String
    let imageUrl : String
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case title
        case imageUrl = "image_url"
    }
}
