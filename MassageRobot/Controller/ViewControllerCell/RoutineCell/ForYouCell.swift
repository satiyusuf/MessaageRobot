//
//  ForYouCell.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 22/06/21.
//

import UIKit

class ForYouCell: UICollectionViewCell {

    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var lblRoutineName: UILabel!
    @IBOutlet var lblDuration: UILabel!
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblSubCategory: UILabel!
    @IBOutlet weak var imgBannarPic: UIImageView!
    
    @IBOutlet var activityIndicat: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
