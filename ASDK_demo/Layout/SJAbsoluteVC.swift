//
//  SJAbsoluteVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/4.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJAbsoluteVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let spec = AbsoluteNode()
        spec.frame = SJPagingRect
        view.addSubnode(spec)
    }

}

fileprivate class AbsoluteNode: ASDisplayNode {

    lazy var imgNode = ASImageNode()
    
    lazy var buttonNode = ASButtonNode()
    
    lazy var textNode = ASTextNode()
    
    override init() {
        super.init()
        
        buttonNode.setTitle("stack", with: UIFont.systemFont(ofSize: 16), with: UIColor.darkText, for: .normal)
        setBorder(node: buttonNode)
        buttonNode.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        imgNode.image = UIImage(named: "button_normal")
        imgNode.clipsToBounds = true
        setBorder(node: imgNode)
        
        textNode.attributedText = NSAttributedString(string: "Lorem ipsum dolor sit er elit, consectetaur cillium adipisicing pecu", attributes: defaultAttri())
        textNode.style.flexShrink = 1 // 保证超出换行
        setBorder(node: textNode)
        
        addSubnode(imgNode)
        addSubnode(buttonNode)
        addSubnode(textNode)
        
        absoluteSpec()
    }
    
    
    func absoluteSpec() {
    
        imgNode.style.layoutPosition = CGPoint(x: 0, y: 0)
        
        textNode.style.layoutPosition = CGPoint(x: 50, y: 100)
        textNode.style.preferredSize = CGSize(width: 200, height: 100)
        
        buttonNode.style.layoutPosition = CGPoint(x: 70, y: 230)
        
        // 设置frame后可以不需要layoutSpecThatFits
        //textNode.frame = CGRect(x: 50, y: 100, width: 200, height: 100)
    }
    
    fileprivate func setBorder(node: ASDisplayNode) {
        
        node.borderColor = SJColor(20, green: 130, blue: 240).cgColor
        node.borderWidth = 0.5
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASAbsoluteLayoutSpec(children: [imgNode, buttonNode, textNode])
    }
}
