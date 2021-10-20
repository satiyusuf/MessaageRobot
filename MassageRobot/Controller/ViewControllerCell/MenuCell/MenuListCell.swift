//
//  MenuListCell.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 07/07/21.
//

import UIKit

protocol MenuListCellDelegate {
    func onClickOpenMenuOPT(index: NSInteger)
}

class MenuListCell: UITableViewCell {

    @IBOutlet weak var lblMenuName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    var delegate : MenuListCellDelegate?
    var intIndex: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickOPTBtn(_ sender: Any) {
        delegate?.onClickOpenMenuOPT(index: intIndex)
    }
    
}
