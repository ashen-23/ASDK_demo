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
        overlay.frame = CGRect(x: 0, y: 4, width: UIScreen.main.bounds.size.width, height: 200)
        view.addSubnode(overlay)
        
        let bgNode = BackNode()
        bgNode.frame = CGRect(x: 0, y: 250, width: UIScreen.main.bounds.size.width, height: 200)
        view.addSubnode(bgNode)
        
        view.backgroundColor = SJColor(230, green: 230, blue: 230)
    }
}


fileprivate class OverlayNode: ASDisplayNode {

    lazy var bgNode = ASDisplayNode()
    lazy var foreNode = ASDisplayNode()
    
    lazy var textNode = ASTextNode()
    
    override init() {
        super.init()
        
        bgNode.backgroundColor = SJColor(20, green: 130, blue: 240)
        // 只设置bg的尺寸, overlay尺寸和bg尺寸相同
        bgNode.style.preferredSize = CGSize(width: 150, height: 150)
        foreNode.backgroundColor = UIColor.purple

        // 添加的顺序很重要, 如果fore在前, overlaySpec不生效
        addSubnode(bgNode)
        addSubnode(foreNode)
        
        textNode.attributedText = NSAttributedString(string: "purple is overlay blue", attributes: defaultAttri())
        // 设置frame 可以不在layoutSpecThatFits再次设置
        textNode.frame = CGRect(x: 110, y: 190, width: UIScreen.main.bounds.size.width - 100, height: 50)
        addSubnode(textNode)
                
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30), child: foreNode)
        let overlay = ASOverlayLayoutSpec(child: bgNode, overlay: inset)
        return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: overlay)
    }
}

fileprivate class BackNode: ASDisplayNode {
    
    lazy var bgNode = ASDisplayNode()
    lazy var foreNode = ASDisplayNode()
    
    lazy var textNode = ASTextNode()
    
    override init() {
        super.init()
        
        bgNode.backgroundColor = SJColor(20, green: 130, blue: 240)
        foreNode.backgroundColor = UIColor.purple
        // 只设置fore的尺寸, bg尺寸和fore尺寸相同
        foreNode.style.preferredSize = CGSize(width: 150, height: 150)
        
        // 添加的顺序很重要, 如果fore在前, overlaySpec不生效
        addSubnode(bgNode)
        addSubnode(foreNode)
        
        textNode.attributedText = NSAttributedString(string: "blue is back of purple", attributes: defaultAttri())
        // 设置frame 可以不在layoutSpecThatFits再次设置
        textNode.frame = CGRect(x: 110, y: 220, width: UIScreen.main.bounds.size.width - 100, height: 50)
        addSubnode(textNode)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30), child: foreNode)
        let back = ASBackgroundLayoutSpec(child: inset, background: bgNode)
        
        return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: back)
    }
}
