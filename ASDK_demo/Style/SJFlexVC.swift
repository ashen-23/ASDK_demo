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
        aNode.frame = CGRect(x: 0, y: 4, width: UIScreen.main.bounds.size.width, height: 50)
        self.view.addSubnode(aNode)
        
        // flexShrink
        let aNode2 = FlexShrinkNode()
        aNode2.frame = CGRect(x: 0, y: 54, width: UIScreen.main.bounds.size.width, height: 50)
        self.view.addSubnode(aNode2)
        
        // ratio
        let aNode3 = FlexRatioNode()
        aNode3.frame = CGRect(x: 0, y: 104, width: UIScreen.main.bounds.size.width, height: 50)
        self.view.addSubnode(aNode3)
        
    }

}

//1 grow 充满
//2 shrink 换行
//3 ratio 按比例拉伸
//递进


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
        
        flexNode.style.preferredSize = CGSize(width: 0, height: 25) // 防止控制台警告
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

// ratio
fileprivate class FlexRatioNode: ASDisplayNode {
    
    lazy var dsp1 = ASDisplayNode()
    lazy var dsp2 = ASDisplayNode()

    lazy var flexNode1 = ASDisplayNode()
    lazy var flexNode2 = ASDisplayNode()

    override init() {
        super.init()
        
        dsp1.backgroundColor = UIColor.purple
        dsp2.backgroundColor = UIColor.brown
        
        dsp1.style.preferredSize = CGSize(width: 50, height: 30)
        dsp2.style.preferredSize = CGSize(width: 50, height: 30)
        
        addSubnode(dsp1)
        addSubnode(dsp2)
        
        // flexShrink 同理
        
        flexNode1.style.preferredSize = CGSize(width: 0, height: 25) // 防止控制台警告
        flexNode1.style.flexGrow = 1
        flexNode1.backgroundColor = UIColor.cyan
        addSubnode(flexNode1)
        
        flexNode2.style.preferredSize = CGSize(width: 0, height: 25) // 防止控制台警告
        flexNode2.style.flexGrow = 2
        flexNode2.backgroundColor = UIColor.cyan
        addSubnode(flexNode2)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASStackLayoutSpec(direction: .horizontal, spacing: 15, justifyContent: .start, alignItems: .start, children: [dsp1, flexNode1, dsp2, flexNode2])
    }
}
