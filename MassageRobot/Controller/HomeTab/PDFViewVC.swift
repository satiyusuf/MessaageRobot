//
//  PDFViewVC.swift
//  Intergems
//
//  Created by AdditMac on 08/09/21.
//  Copyright © 2021 My Mac. All rights reserved.
//

import UIKit
import Foundation


//MARK:- ********** UICollectionViewCell Cell Class **********
class ColleDemoCell: UICollectionViewCell
{
    @IBOutlet weak var lblThree: UILabel!
    @IBOutlet weak var ImgImage: UIImageView!
}

//MARK:- ********** UITableViewCell Cell Class **********
class tblDemoCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var ColleDemo: UICollectionView!
    public var data = NSArray()
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.ColleDemo.delegate = self
        self.ColleDemo.dataSource = self
    }
    
    //MARK:- UICollectionViewDelegate DeleGate And DataSource Method
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return  data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: ColleDemoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColleDemoCell", for: indexPath) as? ColleDemoCell
        {
            
            let NewData = data[indexPath.row] as! NSDictionary
            let Key = NewData["lable"] as? String ?? ""
            let Value = NewData["value"] as? String ?? ""
            
            cell.lblThree.text = "\(Key):-\(Value)"
            cell.ImgImage.image = UIImage(named: "7")

            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = (self.ColleDemo.frame.width - 30) / 1.5
        return CGSize(width: width, height: width )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }
}

//MARK:- ********** PDFViewVC Class **********
class PDFViewVC: UIViewController {

    //MARK:- Outlet
    @IBOutlet weak var tblDemo: UITableView!
    
    //MARK:- Variable
    private var arrAllCateGory = [[String:Any]]()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tblDemo.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    //MARK:- Action
    @IBAction func btnBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- UITableView DeleGate And DataSource Method
extension PDFViewVC: UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {

        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.white
        
        let FrameWidth = self.view.frame.size.width
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: FrameWidth - 20, height: 40))
        myView.layer.backgroundColor = #colorLiteral(red: 0.0546258837, green: 0.3569004238, blue: 0.7489250302, alpha: 1)
        let label = UILabel(frame: CGRect(x: 30, y: 5, width: FrameWidth - 100, height: 30))
        label.font = UIFont(name: "futura", size: 18)
        label.textColor = UIColor.white
        label.textAlignment = .center
        myView.addSubview(label)
        header.addSubview(myView)
        
        let data = arrAllCateGory[section] as NSDictionary
        label.text = "CERT.NO : \(data["CertificateNo"] as? String ?? "")"
    
        let headerFrame = self.view.frame.size
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 50 , y: 10, width: 25, height: 25));
        theImageView.image = UIImage(named: "Down")
        header.addSubview(theImageView)
        
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(self.HideSection(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrAllCateGory.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tblDemoCell", for: indexPath) as? tblDemoCell
        {
            let arrayOfItems = self.arrAllCateGory[indexPath.section] as NSDictionary
            let arrItems = arrayOfItems["details"] as! NSArray
            cell.data = arrItems
            cell.ColleDemo.reloadData()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let width = (self.tblDemo.frame.width) / 1.5
        return width
    }
}

//MARK:- Action Header Call
extension PDFViewVC
{
    @objc
    private func HideSection(_ sender: UITapGestureRecognizer)
    {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        print(section)
    }
}

