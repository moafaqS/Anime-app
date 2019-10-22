//
//  topResponse.swift
//  anime
//
//  Created by moafaq waleed simbawa on 22/02/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import Foundation


struct topResponse : Codable{
    let hash : String
    let cached : Bool
    let expiry : Int
    let top : [TopAnime]
    
    enum CodingKeys: String, CodingKey {
        case hash =  "request_hash"
        case cached = "request_cached"
        case expiry =  "request_cache_expiry"
        case top
    }
    
}

struct TopAnime : Codable{
    var id : Int
    var rank : Int
    var title : String
    var url : String
    var imageUrl : String
    var type : String
    var episodes : Int?
    var start : String?
    var end : String?
    var members : Int
    var score : Double
    
    
    
    
       enum CodingKeys: String, CodingKey {
            case id = "mal_id"
            case rank
            case title
            case url
            case imageUrl = "image_url"
            case type
            case episodes
            case start = "start_date"
            case end = "end_date"
            case members
            case score
       }
    
    
    
    
    

}
