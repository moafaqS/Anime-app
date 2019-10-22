//
//  File.swift
//  anime
//
//  Created by moafaq waleed simbawa on 21/02/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import Foundation



class NetworkingClient {
    
    enum endpoints {
        static let base = "https://api.jikan.moe/v3"
        case getTopAnime
        case getAnimeDetails(Int)
        case getSearch(String)
        
        var stringValue : String{
            switch self {
            case .getTopAnime: return endpoints.base + "/top/anime/1/"
            case .getAnimeDetails(let animeID) : return endpoints.base + "/anime/\(animeID)"
            case .getSearch(let animeName) : return endpoints.base + "/search/anime?q=\(animeName)&page=1"
            }
        }
        
    }
    
    enum topAnime : String{
        case airing = "airing"
        case upcoming = "upcoming"
        case bypopularity = "bypopularity"
        case favorite = "favorite"
        
    }
    
    static func makeUrl(stringValue : String) -> URL {
            return URL(string: stringValue)!

    }
    
    
    static func getAnimeTop(topType : topAnime , completion : @escaping ([TopAnime],Error?) -> Void) {
        let url = makeUrl(stringValue: endpoints.getTopAnime.stringValue + topType.rawValue)
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                   guard let data = data else {
                       DispatchQueue.main.async {
                        completion([],error)
                       }
                       return
                   }
                   let decoder = JSONDecoder()
                   do {
                       let responseObject = try decoder.decode(topResponse.self, from: data)
                       DispatchQueue.main.async {
                        completion(responseObject.top , nil)
                       }
                   } catch {
                       DispatchQueue.main.async {
                        print(error)
                           completion([], error)
                       }
                       
                   }
               }
               task.resume()
       
    }
    
    static func getImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    static func getAnimeDetails(animeID : Int,completion : @escaping (AnimeDetailsResponse?,Error?) -> Void){
        let url = makeUrl(stringValue: endpoints.getAnimeDetails(animeID).stringValue)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                          guard let data = data else {
                              DispatchQueue.main.async {
                                completion(nil,error)
                              }
                              return
                          }
                          let decoder = JSONDecoder()
                          do {
                              let responseObject = try decoder.decode(AnimeDetailsResponse.self, from: data)
                              DispatchQueue.main.async {
                               completion(responseObject , nil)
                              }
                          } catch {
                              DispatchQueue.main.async {
                               print(error)
                                completion(nil, error)
                              }
                              
                          }
                      }
                task.resume()
    }
    
    
    
    static func getAnimeSearchResulst(animeName : String,completion : @escaping ([AnimeSearch]?,Error?) -> Void){
        let url = makeUrl(stringValue: endpoints.getSearch(animeName).stringValue)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                          guard let data = data else {
                              DispatchQueue.main.async {
                                completion(nil,error)
                              }
                              return
                          }
                          let decoder = JSONDecoder()
                          do {
                              let responseObject = try decoder.decode(SearchResponse.self, from: data)
                              DispatchQueue.main.async {
                                completion(responseObject.results , nil)
                              }
                          } catch {
                              DispatchQueue.main.async {
                               print(error)
                                completion(nil, error)
                              }
                              
                          }
                      }
                task.resume()
    }
    

}









