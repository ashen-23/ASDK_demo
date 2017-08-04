//
//  SJOverLaySpecVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/4.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJOverlaySpecVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let overlay = OverlayNode()
        overlay.frame = SJPagingRect
        view.addSubnode(overlay)
    }
}


fileprivate class OverlayNode: ASDisplayNode {

    lazy var bgNode = ASDisplayNode()
    lazy var foreNode = ASDisplayNode()
    
    lazy var textNode = ASTextNode()
    
    override init() {
        super.init()
        
        bgNode.backgroundColor = SJColor(20, green: 130, blue: 240)
        foreNode.backgroundColor = UIColor.purple

        // 添加的顺序很重要, 如果fore在前, overlaySpec不生效
        addSubnode(bgNode)
        addSubnode(foreNode)
        
        textNode.attributedText = NSAttributedString(string: "purple is overlay blue", attributes: defaultAttri())
        // 设置frame 可以不在layoutSpecThatFits再次设置
        textNode.frame = CGRect(x: 100, y: 200, width: UIScreen.main.bounds.size.width - 100, height: 50)
        addSubnode(textNode)
                
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30), child: foreNode)
        return ASOverlayLayoutSpec(child: bgNode, overlay: inset)
    }
}
