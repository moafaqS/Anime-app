//
//  ViewController.swift
//  anime
//
//  Created by moafaq waleed simbawa on 21/02/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController  , UICollectionViewDataSource , UICollectionViewDelegate{
    
    var topAiring : [TopAnime] = []
    var topUpcoming : [TopAnime] = []
    var topPopular : [TopAnime] = []
    var topRanked : [TopAnime] = []
    @IBOutlet weak var activityController: UIActivityIndicatorView!
    
    @IBOutlet weak var topAiringCollection: UICollectionView!
    @IBOutlet weak var topUpcomingAnime: UICollectionView!
    @IBOutlet weak var topPopularAnimeCollection: UICollectionView!
    @IBOutlet weak var topRankedAnimeCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        activityController.startAnimating()
      
        topAiringCollection.dataSource = self
        topAiringCollection.delegate = self
        
        topUpcomingAnime.dataSource = self
        topUpcomingAnime.delegate = self
        
        topPopularAnimeCollection.dataSource = self
        topPopularAnimeCollection.delegate = self
        
        topRankedAnimeCollection.dataSource = self
        topRankedAnimeCollection.delegate = self
        
        setUpData()
        
     
    }
    
    func setUpData() {
        getData(topType: .airing) { (animeList) in
            self.topAiring = animeList
            self.topAiringCollection.reloadData()
        }
        
        getData(topType: .upcoming) { (animeList) in
            self.topUpcoming = animeList
            self.topUpcomingAnime.reloadData()
        }
        getData(topType: .favorite) { (animeList) in
            self.topRanked = animeList
            self.topRankedAnimeCollection.reloadData()
            
        }
        getData(topType: .bypopularity) { (animeList) in
            self.topPopular = animeList
            self.topPopularAnimeCollection.reloadData()
        }
            
        
    }
    
    func getData(topType : NetworkingClient.topAnime , completion : @escaping ([TopAnime]) -> Void){
        NetworkingClient.getAnimeTop(topType: topType) { (animes, error) in
            self.activityController.stopAnimating()
            self.activityController.isHidden = true
            if error == nil{
                completion(animes)
            }else{
                completion([])
                print(error?.localizedDescription)
                let alert = UIAlertController(title: "Error", message: "error in getting data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }

    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topAiringCollection{
            return topAiring.count
        }else if collectionView == topUpcomingAnime{
            return topUpcoming.count
        }else if collectionView == topRankedAnimeCollection{
            return topRanked.count
        }else{
            return topPopular.count
        }
       
       }
  
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topAiringCollection{
            let cell = helperCollectionViewCell(indexPath: indexPath, array: topAiring)
            return cell
        }
        else if collectionView == topRankedAnimeCollection{
            let cell = helperCollectionViewCell(indexPath: indexPath, array: topRanked)
            return cell
        }
        else if collectionView == topUpcomingAnime{
            let cell = helperCollectionViewCell(indexPath: indexPath, array: topUpcoming)
            return cell
        }else {
            let cell = helperCollectionViewCell(indexPath: indexPath, array: topPopular)
            return cell
        }
       
       
       }
    
    func helperCollectionViewCell(indexPath : IndexPath , array : [TopAnime]) -> AnimeCell {
        let cell = topAiringCollection.dequeueReusableCell(withReuseIdentifier: "AnimeCell", for: indexPath) as! AnimeCell
                       
                cell.animeName.text = array[indexPath.row].title
                
                let url = URL(string:  array[indexPath.row].imageUrl)!
                
                NetworkingClient.getImage(from: url ) { (data, response, error) in
                    if error == nil{
                        DispatchQueue.main.async() {
                           cell.animePoster.image = UIImage(data: data!)
                        }
                    }else{
                        let alert = UIAlertController(title: "Error", message: "error in getting image", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                     
                }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == topAiringCollection{
            let selectedAnime = topAiring[indexPath.row].id
            performSegue(withIdentifier: "toAnimeVC", sender: selectedAnime)
               }
               else if collectionView == topRankedAnimeCollection{
            let selectedAnime = topRanked[indexPath.row].id
                              performSegue(withIdentifier: "toAnimeVC", sender: selectedAnime)
               }
               else if collectionView == topUpcomingAnime{
            let selectedAnime = topUpcoming[indexPath.row].id

                             performSegue(withIdentifier: "toAnimeVC", sender: selectedAnime)
               }else {
            let selectedAnime = topPopular[indexPath.row].id
                              performSegue(withIdentifier: "toAnimeVC", sender: selectedAnime)
               }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AnimeViewController
           {
               let vc = segue.destination as? AnimeViewController
                vc?.animeID = sender as?Int
           }
    }
    
    
    



}

