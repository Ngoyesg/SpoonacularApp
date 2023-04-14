//
//  SpyNavigationController.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 5/04/23.
//

import UIKit

class SpyNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool){
        super.pushViewController(viewController, animated: animated)
        
        pushedViewController = viewController
    }
}
