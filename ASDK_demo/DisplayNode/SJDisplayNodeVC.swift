//
//  SJDisplayNodeVC.swift
//  ASDK_demo
//
//  Created by shiQ on 2017/8/26.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// 添加手势
// UIView 添加 Node
// node 添加 UIView
// 使用frame，snpkit布局

class SJDisplayNodeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 手势
        let gestureNode = GestureNode()
        gestureNode.frame = CGRect(x: 0, y: 64, width: SJScreenW, height: 45)
        view.addSubnode(gestureNode)
        
        
        
    }

    
}

fileprivate class GestureNode: ASDisplayNode {

    lazy var textNode = ASTextNode()
    
    override init() {
        
        super.init()
        
        textNode.attributedText = NSAttributedString(string: "点我试试", attributes: defaultAttri())
        addSubnode(textNode)
    }
    
    // didLoad是线程安全的，在该方法中进行与UIView相关操作
    override func didLoad() {
        super.didLoad()
        
        textNode.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickMe)))
    }
    
    func clickMe() {
    
        self.view.makeToast("点中啦！！")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: textNode)
    }
}
