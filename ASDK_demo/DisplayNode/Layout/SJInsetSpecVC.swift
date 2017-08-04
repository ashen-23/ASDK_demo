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
    
    fileprivate var controlNode: ControlNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        insetNode.frame = CGRect(x: 50, y: 100, width: 300, height: 300)
        view.addSubnode(insetNode)
        
        let titles = ["top", "left", "bottom", "right", "reset"]
        
        controlNode = ControlNode(info: ControlInfo.creat(titles: titles)) { [weak self] index in
            
            self?.changeInset(index: index)
        }
        
        controlNode?.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 220, width: UIScreen.main.bounds.size.width, height: 75)
        
        view.addSubnode(controlNode!)
    }
    
    func changeInset(index: Int) {
    
        var inset = insetNode.inset
        
        switch index {
        case 0:
            
            inset = inset.top(offset: 10)
            
        case 1:
            inset = inset.left(offset: 10)
            
        case 2:
            
            inset = inset.bottom(offset: 10)
            
        case 3:
            
            inset = inset.right(offset: 10)
            
        default:
            
            inset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        }
        
        insetNode.inset = inset
        
        insetNode.setNeedsLayout()
    }
    
}

fileprivate class InsetSpecNode: ASDisplayNode {

    lazy var aNode = ASDisplayNode()
    
    var inset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    
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
        
        return ASInsetLayoutSpec(insets: inset, child: aNode)
    }
}


