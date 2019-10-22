//
//  TabBarViewController.swift
//  anime
//
//  Created by moafaq waleed simbawa on 21/02/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit
import CoreData

class TabBarViewController: UITabBarController , UITabBarControllerDelegate  {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 1
    
    }
    

    

}

