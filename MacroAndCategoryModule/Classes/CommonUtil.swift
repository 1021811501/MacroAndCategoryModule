//
//  File.swift
//  MaiDianPu-Swift
//
//  Created by JasonLee on 2018/4/17.
//  Copyright © 2018年 JasonLee. All rights reserved.
//

import Foundation
import UIKit

/**************************************************************************************/


/**************************************************************************************/

//MARK: -

//MARK: app版本号
public let APP_Version : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

//MARK: app名称
public let APP_DisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName")

//MARK: 手机系统版本号
public let APP_SystemVersion = UIDevice.current.systemVersion

//MARK: app的bundle identifier
public let APP_BundleID = Bundle.main.bundleIdentifier
//当前语言
public let AppLanguage = NSLocale.preferredLanguages[0]

/**************************************************************************************/


//MARK: -

//MARK: 屏幕宽度
public let SCREEN_WIDTH = UIScreen.main.bounds.size.width

//MARK: 屏幕高度
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//MARK: 本机屏幕宽度与iPhone8的屏宽比例
public let HEIGHT_SCAL = SCREEN_WIDTH/375.0

//MARK: 状态栏高度
public let kStatusBarH : CGFloat = UIApplication.shared.statusBarFrame.size.height

//MARK: 导航栏高度
public let kNavBarH : CGFloat = 44.0

//MARK: 状态栏和导航栏高度
public let kStatusNavH : CGFloat = kStatusBarH + kNavBarH
public let KDeveice_isPad :Bool = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
//MARK: 判断IPHONEX
public let kDevice_IPHONE_X : Bool = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), (UIScreen.main.currentMode?.size)!) && !KDeveice_isPad: false
//MARK: 判断IPHONEXR
public let kDevice_IPHONE_XR : Bool = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 828, height: 1792), (UIScreen.main.currentMode?.size)!) && !KDeveice_isPad: false
//MARK: 判断IPHONEX
public let kDevice_IPHONE_XS : Bool = kDevice_IPHONE_X
//MARK: 判断IPHONEXSMax
public let kDevice_IPHONE_XS_MAX : Bool = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1242, height: 2688), (UIScreen.main.currentMode?.size)!) && !KDeveice_isPad: false
//判断iPhoneX及以上版本
public let kDevice_IPHONE_X_MORE :Bool = kDevice_IPHONE_X || kDevice_IPHONE_XR || kDevice_IPHONE_XS || kDevice_IPHONE_XS_MAX
//MARK: - 判断是否是横屏
public let kIsLandScape :Bool = (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeLeft || UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeRight)

//MARK: 标签栏高度
public let kTabbarH : CGFloat = kDevice_IPHONE_X_MORE ? (49.0 + 34.0) : 49.0

//MARK: 安全区高度
public let kTabbarSafeBottomMargin : CGFloat = kDevice_IPHONE_X_MORE ? 34.0 : 0.0

//MARK: 表视图高度
public let kTableH : CGFloat = SCREEN_HEIGHT - kStatusNavH - kTabbarSafeBottomMargin
public let kTableHaveTabBarH : CGFloat = SCREEN_HEIGHT - kStatusNavH - kTabbarH

//MARK: UserDefault
public let USERDEFAULT = UserDefaults.standard

public let kPlaceHolderImage = UIImage(named: "dg_default_pic")
/**************************************************************************************/



/**************************************************************************************/


/**************************************************************************************/

//MARK: -
//MARK: 日志格式化打印
public func DLog<T>(_ message: T, file: String = #file, funcName : String = #function, lineNumber : Int = #line){
    
    #if DEBUG
    
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    
    let fileName = (file as NSString).lastPathComponent
    
    print("\n——————————————————————————DLog-satrt—————————————————————————\n︳\n︳时间: \(dateFormater.string(from: NSDate() as Date))\n︳文件名称: \(fileName)\n︳方法: \(funcName)\n︳行数: \(lineNumber)\n︳打印内容: \(message)\n︳\n———————————————————————————DLog-end———————————————————————————\n\n")
    #endif
}
public func NSLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    
    let fileName = (file as NSString).lastPathComponent
    
    print("\n——————————————————————————DLog-satrt—————————————————————————\n︳\n︳时间: \(dateFormater.string(from: NSDate() as Date))\n︳文件名称: \(fileName)\n︳方法: \(function)\n︳行数: \(lineNumber)\n︳打印内容: \(message)\n︳\n———————————————————————————DLog-end———————————————————————————\n\n")
    #endif
}

//MARK: - Alert
public func alert(vc:UIViewController,title:String,content:String,cancel:String,confirm:String,cancelAction:((UIAlertAction) -> Void)?,confirmAction:((UIAlertAction) -> Void)?) {
    let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
    let action1 = UIAlertAction(title: cancel, style: .default, handler: cancelAction)
    let action2 = UIAlertAction(title: confirm, style: .default, handler: confirmAction)
    alert.addAction(action1)
    alert.addAction(action2)
    vc.present(alert, animated: true, completion: nil)
}
public  func compareVersion(newVersion:String) -> Bool{
    return APP_Version.compare(newVersion, options: .numeric) == .orderedAscending
}
public func replaceMethod(cls : AnyClass,originSelector: Selector,newSelector:Selector) -> Bool{
    guard let oriMethod = class_getInstanceMethod(cls, originSelector) else{
        return false
    }
    guard let newMethod = class_getInstanceMethod(cls, newSelector) else{
        return false
    }
    let isAdd :Bool = class_addMethod(cls, originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))
    if isAdd {
        class_replaceMethod(cls, newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod))
    }else{
        method_exchangeImplementations(oriMethod, newMethod)
    }
    return true
}
public func NSClassFromString(classStr:String)-> AnyClass?{
    var nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    if nameSpace .contains("-") {
        nameSpace = nameSpace.replacingOccurrences(of: "-", with: "_");
    }
    return NSClassFromString(nameSpace+"."+classStr)
}
