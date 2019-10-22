//
//  WatchlistViewController.swift
//  anime
//
//  Created by moafaq waleed simbawa on 22/02/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit
import CoreData

class WatchlistViewController: dataViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var watchlistAnime : [Anime] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchResquest : NSFetchRequest<Anime> = Anime.fetchRequest()
        if let results = try? dataController.viewContext.fetch(fetchResquest){
            watchlistAnime = results
            collectionView.reloadData()
        }
    }
    
}


extension WatchlistViewController : UICollectionViewDelegate  , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        watchlistAnime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchlistAnimeCell", for: indexPath) as! WatchlistAnimeCell
        
        cell.animeName.text = watchlistAnime[indexPath.row].title
        cell.animePoster.image =  UIImage(data: self.watchlistAnime[indexPath.row].image!)
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAnime = Int(watchlistAnime[indexPath.row].animeID!)
        performSegue(withIdentifier: "toAnimeWatchListDetails", sender: selectedAnime)
    }
    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AnimeViewController
            {
                let vc = segue.destination as? AnimeViewController
                vc?.animeID = sender as? Int
            }
    }
    
    
   
    
    
}
