//
//  SJStyleSizeVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/19.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJStyleSizeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let aNode = StyleSizeNode()
        aNode.frame = SJPagingRect
        self.view.addSubnode(aNode)
    }

}



fileprivate class StyleSizeNode: ASDisplayNode {

    var node1 = ASDisplayNode()
    
    var node2 = ASDisplayNode()

    var node3 = ASTextNode()
    
    var node4 = ASTextNode()

    var node5 = ASTextNode()
    
    override init() {
        super.init()
        
        
        node1.style.width = ASDimensionMake(100)
        node1.style.height = ASDimensionMake(50)
        
        node2.style.preferredSize = CGSize(width: 100, height: 50)
        
        node3.style.maxWidth = ASDimensionMake(300)
       // node3.style.maxHeight = ASDimensionMake(50)
        
        node4.style.maxSize = CGSize(width: 300, height: 50)
        
        //
        node1.backgroundColor = UIColor.purple
        addSubnode(node1)
        
        node2.backgroundColor = UIColor.cyan
        addSubnode(node2)
        
        node3.attributedText = NSAttributedString(string: displayStr, attributes: defaultAttri())
        addSubnode(node3)
        
        node4.attributedText = NSAttributedString(string: displayStr, attributes: defaultAttri())
        addSubnode(node4)
        
        node5.attributedText = NSAttributedString(string: displayStr, attributes: defaultAttri())
        addSubnode(node5)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASStackLayoutSpec(direction: .vertical, spacing: 20, justifyContent: .start, alignItems: .start, children: [node1, node2, node3, node4, node5])
    }
}
