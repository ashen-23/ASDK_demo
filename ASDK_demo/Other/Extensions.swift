//
//  Extensions.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/4.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

extension UIEdgeInsets {

    func top(offset: CGFloat) -> UIEdgeInsets {
    
        return UIEdgeInsets(top: top + offset, left: left, bottom: bottom, right: right)
    }
    
    func left(offset: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: top, left: left + offset, bottom: bottom, right: right)
    }
    
    func bottom(offset: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: top, left: left, bottom: bottom + offset, right: right)
    }
    
    func right(offset: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right + offset)
    }
}
