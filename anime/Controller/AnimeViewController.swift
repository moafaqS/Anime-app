//
//  AnimeViewController.swift
//  anime
//
//  Created by moafaq waleed simbawa on 22/02/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit
import CoreData

class AnimeViewController: dataViewController {
    
    @IBOutlet weak var animePoster: UIImageView!
    @IBOutlet weak var animeName: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var episodes: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var premired: UILabel!
    @IBOutlet weak var studio: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var synopsis: UITextView!
    @IBOutlet weak var addToWatchList: UIButton!
    
    
    
    var animeID : Int!
    var addedToWatchList = false
    var watchListAnime : Anime!
    
    fileprivate func getDataFromAPI() {
        NetworkingClient.getAnimeDetails(animeID: animeID) { (anime, error) in
            if error == nil{
                
                self.animeName.text = anime!.title
                self.type.text = anime!.type
                self.rank.text = "\(anime!.rank ?? 0)"
                self.episodes.text = anime?.episodes == nil ? "-" : "\( anime?.episodes ?? 0)"
                self.score.text = anime!.score == nil ? "-" : "\(anime?.score ?? 0)"
                
                self.popularity.text = anime?.popularity == nil ? "-" : String(anime!.popularity)
                self.premired.text = anime?.premiered == nil ? "-" : anime?.premiered
                var genres = ""
                for genre in anime!.genres{
                    genres = genres + "  \(genre.name)"
                }
                self.genre.text = genres
                
                var studios = ""
                for studio in anime!.studios{
                    studios = studios + "  \(studio.name)"
                }
                self.studio.text = studios
                self.synopsis.text = anime?.synopsis == nil ? "No synopsis avalible" : anime?.synopsis
                
                NetworkingClient.getImage(from: URL(string: anime!.imageUrl)! ) { (data, response, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.animePoster.image = UIImage(data: data!)
                        }
                        
                    }else{

                        let alert = UIAlertController(title: "Error?", message: error?.localizedDescription , preferredStyle: .alert)
                        self.present(alert, animated: true)
                        
                        print(error?.localizedDescription)
                    }
                }
                
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        synopsis.delegate = self
        let image = addedToWatchList ? UIImage(named: "inWatchList") : UIImage(named: "notInWatchList")
        addToWatchList.setImage(image, for: .normal)
        infoView.layer.cornerRadius = 8.0
        
        let fetchResquest : NSFetchRequest<Anime> = Anime.fetchRequest()
        let predicate = NSPredicate(format: "animeID == %@",String(animeID))
        fetchResquest.predicate = predicate
        if let results = try? dataController.viewContext.fetch(fetchResquest){
            
            if results.count == 0 {
                getDataFromAPI()
            }else{
                addedToWatchList = true
                addToWatchList.setImage(UIImage(named: "inWatchList"), for: .normal)
                
                self.animeName.text = results[0].title
                self.type.text = results[0].type
                self.rank.text = results[0].rank
                self.episodes.text = results[0].episodes
                self.score.text = results[0].score
                self.popularity.text = results[0].popularity
                self.premired.text = results[0].premires
                self.genre.text = results[0].genre
                self.studio.text = results[0].studio
                self.synopsis.text = results[0].synopsis
                self.animePoster.image = UIImage(data: results[0].image!) 
                self.watchListAnime = results[0]
            }
           
        }
   
        
    }
    
  
    @IBAction func watchlistPressed(_ sender: Any) {
        
        if !addedToWatchList{
            saveAnime()
        }else{
            deleteAnime()
        }
               
        
        print(addedToWatchList)
        addedToWatchList = !addedToWatchList
        let image = addedToWatchList ? UIImage(named: "inWatchList") : UIImage(named: "notInWatchList")
        addToWatchList.setImage(image, for: .normal)
    }
    
    
    func saveAnime()  {
        
        let anime = Anime(context: dataController.viewContext)
        anime.episodes = self.episodes.text
        anime.genre = self.genre.text
        anime.popularity = self.popularity.text
        anime.premires = self.premired.text
        anime.rank = self.rank.text
        anime.score = self.score.text
        anime.image = self.animePoster.image?.pngData()
        anime.studio = self.studio.text
        anime.synopsis = self.synopsis.text
        anime.title = self.animeName.text
        anime.type = self.type.text
        anime.animeID = String(self.animeID)
        
        try? dataController.viewContext.save()
        
        self.watchListAnime = anime

    }
    
    func deleteAnime() {
        dataController.viewContext.delete(watchListAnime)
        try? dataController.viewContext.save()
       
        
    }
    

    
    

}

extension AnimeViewController : UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    
    


}
