//
//  dataViewController.swift
//  anime
//
//  Created by moafaq waleed simbawa on 23/02/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit

class dataViewController: UIViewController {

    let dataController = DataController(modelName: "anime")
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController.load()
    }
    


}
