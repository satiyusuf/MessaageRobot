//
//  TabViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 05/03/21.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let items = tabBar.items {
            items.enumerated().forEach { if $1 == item { print("your index is: \($0)") } }
        }
    }
}
