//
//  SegmentPlayCell.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 26/07/21.
//

import UIKit

protocol SegmentPlayCellDelegate {
    func onSetStartProgressNextCell()
}

class SegmentPlayCell: UITableViewCell {

    @IBOutlet weak var horizontalBar: PlainHorizontalProgressBar!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblL_Location: UILabel!
    @IBOutlet weak var lblR_Location: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    
    @IBOutlet weak var viewLeftLocation: UIView!
    @IBOutlet weak var viewRightLocation: UIView!
    
    @IBOutlet weak var imgLL: UIImageView!
    @IBOutlet weak var imgLR: UIImageView!
    
    var timerTest : Timer?
    
    var totalDuration = 0
    var totalStoreDu = 0
    var timeRemaining = 0
    var segmentTime = 0
    
    var delegate : SegmentPlayCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func startTimerForCell() {
        timerTest = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setProgressBar), userInfo: nil, repeats: true)
    }
    
    @objc func setProgressBar() {
        
        timeRemaining += 1
        let completionPercentage = Int(((Float(segmentTime) - Float(timeRemaining))/Float(segmentTime)) * 100)
//         progressView.setProgress(Float(timeRemaining)/Float(totalTime), animated: false)
        
        let fltValue: Float = Float(timeRemaining)/Float(segmentTime)
        horizontalBar.progress = CGFloat(fltValue)
          print("progressLabel \(completionPercentage)% done")
  //       progressLabel.text = "\(completionPercentage)% done"
         let minutesLeft = Int(timeRemaining) / 60 % 60
         let secondsLeft = Int(timeRemaining) % 60
          
          print("timeLabel \(minutesLeft):\(secondsLeft)")
  //       timeLabel.text = "\(minutesLeft):\(secondsLeft)"
          print("manageTimerEnd \(timeRemaining)")
        
        if totalDuration < 10 {
            
            //01:00/02:00
            if minutesLeft < 10 {
                if secondsLeft < 10 {
                    lblTime.text = "0" + String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + "0" + String(secondsLeft)
                }else {
                    lblTime.text = "0" + String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + String(secondsLeft)
                }
            }else {
                lblTime.text = String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + String(secondsLeft)
            }
        }else {
            
            if minutesLeft < 10 {
                
                if secondsLeft == 0 {
                    lblTime.text = String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + "00"
                }else {
                    lblTime.text = String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + String(secondsLeft)
                }
            }else {
                
                if secondsLeft == 0 {
                    lblTime.text = String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + "00"
                }else {
                    lblTime.text = String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + String(secondsLeft)
                }
            }
        }
        
        if segmentTime == timeRemaining {
            timerTest?.invalidate()
            timerTest = nil
            
            delegate?.onSetStartProgressNextCell()
        }
    }
    
    func setStopTimerForCell() {
        timerTest?.invalidate()
        timerTest = nil
    }
}
