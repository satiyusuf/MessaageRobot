//
//  FeatureCell.swift
//  Test_Demo
//
//  Created by Kapil Sanghani on 22/06/21.
//

import UIKit

class FeatureCell: UICollectionViewCell {

    @IBOutlet weak var viewBack: UIView!
    @IBOutlet var lblRoutineName: UILabel!
    @IBOutlet var lblSubCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        viewBack.layer.shadowColor = UIColor.darkGray.cgColor
//        viewBack.layer.shadowOpacity = 1
//        viewBack.layer.shadowOffset = .zero
//        viewBack.layer.shadowRadius = 10
//
//        viewBack.layer.shadowPath = UIBezierPath(rect: viewBack.bounds).cgPath
//        viewBack.layer.shouldRasterize = true


    }

}
