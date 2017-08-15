//
//  SJFlexVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/15.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJFlexVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Flex style"
        
        // flexGrow
        let aNode = FlexGrowNode()
        aNode.frame = CGRect(x: 0, y: 4, width: UIScreen.main.bounds.size.width, height: 60)
        self.view.addSubnode(aNode)
        
        // flexShrink
        let aNode2 = FlexShrinkNode()
        aNode2.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: 60)
        self.view.addSubnode(aNode2)
    }

}

//1 grow 充满
//2 shrink 换行
//3 ratio 按比例拉伸
fileprivate class StyleFlexNode: ASDisplayNode {

    let flexNode = FlexGrowNode()
    
    override init() {
        super.init()
        
        addSubnode(flexNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .start, children: [flexNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20), child: stack)
    }
    
}

// grow
fileprivate class FlexGrowNode: ASDisplayNode {

    lazy var dsp1 = ASDisplayNode()
    lazy var dsp2 = ASDisplayNode()
    
    lazy var flexNode = ASDisplayNode()
    
    override init() {
        super.init()
        
        dsp1.backgroundColor = UIColor.purple
        dsp2.backgroundColor = UIColor.brown
        
        dsp1.style.preferredSize = CGSize(width: 50, height: 30)
        dsp2.style.preferredSize = CGSize(width: 50, height: 30)

        addSubnode(dsp1)
        addSubnode(dsp2)
        
        flexNode.style.height = ASDimensionMake(20)
        flexNode.style.flexGrow = 1
        flexNode.backgroundColor = UIColor.cyan
        addSubnode(flexNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASStackLayoutSpec(direction: .horizontal, spacing: 15, justifyContent: .start, alignItems: .start, children: [dsp1, flexNode, dsp2])
    }
}

// shrink
fileprivate class FlexShrinkNode: ASDisplayNode {
    
    lazy var dsp1 = ASDisplayNode()
    
    lazy var flexNode = ASTextNode()
    
    override init() {
        super.init()
        
        dsp1.backgroundColor = UIColor.purple
        dsp1.style.preferredSize = CGSize(width: 50, height: 30)
        addSubnode(dsp1)
        
        flexNode.style.flexShrink = 1
        flexNode.backgroundColor = UIColor.cyan
        flexNode.attributedText = NSAttributedString(string: displayStr)
        addSubnode(flexNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASStackLayoutSpec(direction: .horizontal, spacing: 15, justifyContent: .start, alignItems: .start, children: [dsp1, flexNode])
    }
}
