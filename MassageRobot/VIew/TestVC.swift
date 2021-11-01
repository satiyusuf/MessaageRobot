//
//  TestVC.swift
//  MassageRobot
//
//  Created by Emp-Mac on 30/10/21.
//

import UIKit

class TestVC: UIViewController {

    @IBOutlet weak var DataLoadView: newtestvc!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataLoadView.lblone.text = "yusuf"
        DataLoadView.lblTwo.text = "Sati"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
