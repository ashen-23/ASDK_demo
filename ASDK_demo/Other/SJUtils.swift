//
//  SJUtils.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/1.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//
import UIKit

/// stotyBoard创建控制器
func storyBoard(name: String, identifier: String? = nil) -> UIViewController {
    
    let aSB = UIStoryboard(name: name, bundle: Bundle.main)
    if let aIdfier = identifier {
        
        return aSB.instantiateViewController(withIdentifier: aIdfier)
    }
    return aSB.instantiateInitialViewController()!
}


func defaultAttri() -> [String: Any] {

    return [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.black]
}

public func SJColor(_ red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat = 1.0) ->UIColor
{
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}
