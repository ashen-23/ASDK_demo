//
//  SJInsetSpecVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/3.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJInsetSpecVC: UIViewController {

    lazy fileprivate var insetNode = InsetSpecNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        insetNode.frame = CGRect(x: 50, y: 100, width: 300, height: 300)
        view.addSubnode(insetNode)
    }

}

fileprivate class InsetSpecNode: ASDisplayNode {

    lazy var aNode = ASDisplayNode()
    
    override init() {
        
        super.init()
        
        initUI()
    }
    
    func initUI() {
    
        aNode.backgroundColor = UIColor.purple
        addSubnode(aNode)
        
        backgroundColor = SJColor(230, green: 230, blue: 230)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let inset = UIEdgeInsets(top: 20, left: 35, bottom: 20, right: 30)
        return ASInsetLayoutSpec(insets: inset, child: aNode)
    }
}
