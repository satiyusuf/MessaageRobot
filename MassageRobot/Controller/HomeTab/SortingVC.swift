//
//  SortingVC.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 17/08/21.
//

import UIKit

class SortingVC: UIViewController {

    @IBOutlet var btnAlphabeticalHToL: UIButton!
    @IBOutlet var btnAlphabeticalLToH: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickResetBtn(_ sender: Any) {
        btnAlphabeticalHToL.isSelected = false
        btnAlphabeticalLToH.isSelected = false
    }
    
    @IBAction func onClickCancelBtn(_ sender: Any) {
        btnAlphabeticalHToL.isSelected = false
        btnAlphabeticalLToH.isSelected = false
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickAlphabeticalHToLBtn(_ sender: Any) {
        btnAlphabeticalHToL.isSelected = true
        btnAlphabeticalLToH.isSelected = false
    }
    
    @IBAction func onClickAlphabeticalLToHBtn(_ sender: Any) {
        btnAlphabeticalHToL.isSelected = false
        btnAlphabeticalLToH.isSelected = true
    }
    
    @IBAction func onClickApplyBtn(_ sender: Any) {
        
        if btnAlphabeticalHToL.isSelected == false && btnAlphabeticalLToH.isSelected == false {
            let alert = UIAlertController(title: "Alert!", message: "Please select sorting option.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if btnAlphabeticalHToL.isSelected == true {
            UserDefaults.standard.set("DESC", forKey: SORTING)
        }else {
            UserDefaults.standard.set("ASC", forKey: SORTING)
        }
        navigationController?.popViewController(animated: true)
    }
}
