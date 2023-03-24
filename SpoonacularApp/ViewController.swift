//
//  ViewController.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 23/03/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let filtered = FilteredRecipeEndpoint(search: "pasta").getURL()
        print(filtered)
        // Do any additional setup after loading the view.
    }


}

 
