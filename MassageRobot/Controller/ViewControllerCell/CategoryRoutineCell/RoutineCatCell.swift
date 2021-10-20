//
//  RoutineCatCell.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 29/06/21.
//

import UIKit

protocol RoutineCatCellDelegate {
    func onClickRoutineDetailOpen(index: NSInteger)
}

class RoutineCatCell: UITableViewCell {

    @IBOutlet var constWidthImg: NSLayoutConstraint!
    
    @IBOutlet var lblRoutineName: UILabel!
    @IBOutlet var lblRoutineTime: UILabel!
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblRLocation: UILabel!
    @IBOutlet var lblLLocation: UILabel!
    
    @IBOutlet weak var imgBannarPic: UIImageView!
    
    var delegate : RoutineCatCellDelegate?
    var intIndex: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("Height>>>>> \(UIScreen.main.bounds.size.height)")
        
        if SharedFunctions.sharedInstance().isiPhoneXs() {
            constWidthImg.constant = 140.0
        }else if SharedFunctions.sharedInstance().isiPhone12() {
            constWidthImg.constant = 150.0
        }else if SharedFunctions.sharedInstance().isiPhone6() {
            constWidthImg.constant = 140.0
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickSelectRoutineBtn(_ sender: Any) {
        delegate?.onClickRoutineDetailOpen(index: intIndex)
    }
    
}
