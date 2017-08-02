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

func SJColor(_ red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat = 1.0) ->UIColor
{
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

/// 随机图片路径
func randomImgUrl() -> URL? {

    let width = 350 + 2 * arc4random_uniform(10)
    let height = 350 + 4 * arc4random_uniform(10)
    
    return URL(string: "https://placekitten.com/\(width)/\(height)")
}

func randomName(length: Int = 7) -> String {

    let letters: NSString = "abcdefghijklmnopqrstuvwxyz"
    var str = ""
    
    for _ in 0..<length {
    
        let index = Int(arc4random_uniform(UInt32(letters.length)))
        str += NSString(format: "%c", letters.character(at: index)) as String
    }
    
    return str

}

let SJScreenRect = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 64)
