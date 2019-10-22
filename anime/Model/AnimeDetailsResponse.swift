//
//  animeDetailsResponse.swift
//  anime
//
//  Created by moafaq waleed simbawa on 22/02/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import Foundation

struct AnimeDetailsResponse : Codable{
    let premiered : String?
    let genres : [Genre]
    let studios : [Studio]
    let synopsis : String?
    let popularity : Int
    
    let title : String
    let type : String
    let rank : Int?
    let episodes : Int?
    let score : Double?
    var imageUrl : String
  
    
    enum CodingKeys: String, CodingKey {
        case premiered
        case genres
        case studios
        case synopsis
        case popularity
        case title
        case type
        case rank
        case episodes
        case score
        case imageUrl = "image_url"
    }
}

struct Genre : Codable{
    let id : Int
    let type : String
    let name : String
    
    
    enum CodingKeys: String, CodingKey {
    case id = "mal_id"
    case type
    case name
    }
    
}


struct Studio : Codable {
    
    let id : Int
    let type : String
    let name : String
    
    enum CodingKeys: String, CodingKey {
    case id = "mal_id"
    case type
    case name
    }
}



