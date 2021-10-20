//
//  TextField.swift
//  Colab
//
//  Created by rohit on 09/03/20.
//  Copyright © 2020 tedmate. All rights reserved.
//

import UIKit

@IBDesignable
class UnderlineTextField: UITextField {

    @IBInspectable var leftImage: UIImage?
    @IBInspectable var rightImage: UIImage?
    @IBInspectable var underline: Bool = false
    @IBInspectable var needPadding: Bool = false

    var paddingNo: CGFloat = 10
    var leftPadding: CGFloat = 0
    var rightPadding: CGFloat = 15
    var underLineColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0)
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code

        if leftImage != nil
        {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
//            view.backgroundColor = .red
            imageView.center = view.center
            imageView.image = leftImage
            view.addSubview(imageView)
            self.leftView = view
            self.leftViewMode = .always
            
            if needPadding
            {
                leftPadding = 40
                padding = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0)
            }
            else
            {
                padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }

        if rightImage != nil
        {
            let frm = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
            let view = UIView(frame: frm)
            let imageView = UIImageView(frame: frm)

            imageView.center = view.center
            imageView.contentMode = .center
            imageView.image = rightImage
            view.addSubview(imageView)
            self.rightView = view
            self.rightViewMode = .always
            
            
            if needPadding
            {
                rightPadding = self.frame.height
                padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightPadding)
            }
            else
            {
                rightPadding = self.frame.height
                padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightPadding)
            }
        }

        addUnderline()
        
        if needPadding
        {
            leftPadding = 40
            padding = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
        }
    }

    func addUnderline()
    {
        if underline
        {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
            bottomLine.backgroundColor = underLineColor.cgColor
            borderStyle = .none
            layer.addSublayer(bottomLine)
        }
    }

    func addRightImage()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 26, height: self.frame.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 17))
//            view.backgroundColor = .red
        imageView.center = view.center
        imageView.image = #imageLiteral(resourceName: "flag")
        view.addSubview(imageView)
        self.leftView = view
        self.leftViewMode = .always
        self.padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 15)
        needPadding = true
    }

    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UnderlineTextField
{
    func addEyeButton()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
//                        view.backgroundColor = .red
        button.center = view.center
        button.setImage(UIImage(named: "icon_ionic_md_eye"), for: .normal)
        button.setImage(UIImage(named: "closed_eye"), for: .selected)
        button.addTarget(self, action: #selector(btnEyeAction(_:)), for: .touchUpInside)
        view.addSubview(button)
        self.rightView = view
        self.rightViewMode = .always
        self.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
    }

    @objc func btnEyeAction(_ sender: UIButton)
    {
        print("eye tappend")
        self.isSecureTextEntry = !self.isSecureTextEntry
        sender.isSelected = !sender.isSelected
    }
}

