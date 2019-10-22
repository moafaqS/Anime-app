//
//  SearchBarViewController.swift
//  anime
//
//  Created by moafaq waleed simbawa on 22/02/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var animeList : [AnimeSearch] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
}


extension SearchViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        
        cell.animeName.text = animeList[indexPath.row].title
    
        let url = URL(string:  animeList[indexPath.row].imageUrl)!
        
        NetworkingClient.getImage(from: url ) { (data, response, error) in
             DispatchQueue.main.async() {
               cell.animePoster.image = UIImage(data: data!)
            }
        }
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeID = animeList[indexPath.row].id
        
        performSegue(withIdentifier: "toSearchDetails", sender: animeID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AnimeViewController
        {
            let vc = segue.destination as? AnimeViewController
             vc?.animeID = sender as? Int
        }
    }
    
    
}

extension SearchViewController : UISearchBarDelegate{
    
    
            
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let string = searchBar.text!
        let searchString = String(string.filter { !" \n\t\r".contains($0) })
        print(searchString)
        
        if searchString != ""{
            NetworkingClient.getAnimeSearchResulst(animeName: searchString ) { (searchList, error) in
                if error == nil{
                    self.animeList = searchList!
                    searchBar.text = ""
                    self.tableView.reloadData()
                }else{

                    let alert = UIAlertController(title: "Error?", message: error?.localizedDescription , preferredStyle: .alert)
                    self.present(alert, animated: true)
                    
                    print(error?.localizedDescription)
                }
            }
        }
    }

    
}



