//
//  SJLayoutSpecVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/3.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJLayoutSpecVC: SJMenuVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "layout Overview"
        
        SBName = "LayoutSpec"
        items = ["inset","stack", "relative", "ratio", "overlay", "absolute"]
    }

}


