//
//  DGDefines.swift
//  SwiftShop
//
//  Created by GQ on 2019/8/2.
//  Copyright © 2019 GQ. All rights reserved.
//

import Foundation
import UIKit



/// DGImage(图片名称)
public var DGImage:(String) -> UIImage? = { (imgName : String) -> UIImage? in
    guard let image = UIImage(named: imgName) else { return nil }
    let image1 = image.withRenderingMode(.alwaysOriginal)
    return image1
}


/// DGView(背景色)
public var DGView:(UIColor) -> UIView = { (bgColor : UIColor) -> UIView in
    let view = UIView()
    view.backgroundColor = bgColor
    return view
}


/// DGLabel(文本,文本颜色,对齐方式,字体)
public var DGLabel:(String?,UIColor?,NSTextAlignment?,UIFont?) -> UILabel = { (text : String?, textColor : UIColor?, textAlignment : NSTextAlignment?, font : UIFont?) -> UILabel in
    let label = UILabel()
    label.text = text
    label.textColor = textColor
    label.textAlignment = textAlignment ?? .left
    label.font = font
    return label
}


/// DGButton(背景色,标题,标题颜色)
public var DGButton:(_ : UIColor, _ : String, _ : UIColor) -> UIButton = { (bgColor : UIColor, title : String, titleColor : UIColor) -> UIButton in
    let button = UIButton(type: .custom)
    button.backgroundColor = bgColor
    button.setTitle(title, for: .normal)
    button.setTitleColor(titleColor, for: .normal)
    
    return button
}


/// DGImageView(填充方式,图片名称,超出裁剪,用户交互)
public var DGImageView:(UIView.ContentMode,String?,Bool,Bool) -> UIImageView = { (contentMode : UIView.ContentMode, imageName : String?, maskToBounds : Bool, userInteractionEnabled : Bool) -> UIImageView in
    let imageView = UIImageView()
    imageView.contentMode = contentMode
    if (imageName != nil) {
        imageView.image = DGImage(imageName ?? "")
    }
    imageView.layer.masksToBounds = maskToBounds
    imageView.isUserInteractionEnabled = userInteractionEnabled
    
    return imageView
}


/// DGTextField(字体颜色,字体,占位,代理,键盘)
public var DGTextField:(UIColor,UIFont,String,UITextFieldDelegate,UIKeyboardType) -> UITextField = { (textColor: UIColor, font: UIFont, placeholder: String, delegate: UITextFieldDelegate, keyboardType: UIKeyboardType) -> UITextField in
    let textfield = UITextField()
    textfield.textColor = textColor;
    textfield.font = font
    textfield.placeholder = placeholder
    textfield.delegate = delegate
    textfield.keyboardType = keyboardType
    
    return textfield
}


/// DGTableView()
public var DGTableView:(UITableView.Style,UIColor,AnyObject,NSArray,NSArray,NSArray) -> UITableView = { (style: UITableView.Style, bgColor: UIColor, delegate: AnyObject, registerCells: NSArray, registerHeaderViews: NSArray, registerFooterViews: NSArray) -> UITableView in
    let tableView = UITableView(frame: CGRect.zero, style: style)
    tableView.backgroundColor = bgColor
    tableView.delegate = delegate as? UITableViewDelegate
    tableView.dataSource = delegate as? UITableViewDataSource
    for item in registerCells {
        tableView.register(NSClassFromString("\(item)"), forCellReuseIdentifier: "\(item)")
    }
    for item in registerHeaderViews {
        tableView.register(NSClassFromString("\(item)"), forHeaderFooterViewReuseIdentifier: "\(item)")
    }
    for item in registerFooterViews {
        tableView.register(NSClassFromString("\(item)"), forHeaderFooterViewReuseIdentifier: "\(item)")
    }
    tableView.estimatedRowHeight = 0
    tableView.estimatedSectionHeaderHeight = 0
    tableView.estimatedSectionFooterHeight = 0
    if #available(iOS 11.0, *) {
        tableView.contentInsetAdjustmentBehavior = .never
    } else {
        // Fallback on earlier versions
    }
    return tableView
}



