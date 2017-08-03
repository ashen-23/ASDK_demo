//
//  SJTableNode.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJTableNoe: ASCellNode {
    
    lazy var imgNode = ASNetworkImageNode()
    lazy var textNode = ASTextNode()
    
    var person: SJPerson?
    
    init(person: SJPerson?) {
        super.init()
        
        self.person = person
        
        initUI()
    }
    
    override func didLoad() {
        super.didLoad()
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(SJTableNoe.doTapAvator))
        imgNode.view.addGestureRecognizer(aTap)
    }
    
    func initUI() {
        
        selectionStyle = .none
        
        imgNode.style.preferredSize = CGSize(width: 50, height: 50)
        imgNode.defaultImage = UIImage(named: "default") // 默认图
        imgNode.isUserInteractionEnabled = true
        imgNode.url = person?.avator
        let width = 50 * UIScreen.main.scale
        
        imgNode.imageModificationBlock = { image in
            
            let rect = CGRect(x: 0, y: 0, width: width, height: width)
            UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
            UIBezierPath(roundedRect: rect, cornerRadius: width / 2).addClip() // 圆角
            
            image.draw(in: rect)
            let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return modifiedImage
        }
        
        addSubnode(imgNode) // 必须要添加
        
        textNode.attributedText = NSAttributedString(string: person?.name ?? "", attributes: defaultAttri())
        
        textNode.style.flexShrink = 1 // 保证能换行
        addSubnode(textNode)
    }
    
    func doTapAvator() {
        
        self.view.makeToast((person?.name ?? "") + "is selected")
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 20, justifyContent: .start, alignItems: .center, children: [imgNode, textNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20), child: stack)
    }
}

// view header
class SJTableHeaderNode: ASDisplayNode {
    
    lazy var textNode = ASTextNode()
    
    init(title: String?) {
        super.init()
        
        textNode.attributedText = NSAttributedString(string: title ?? "", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.black])
        
        addSubnode(textNode)
        
        backgroundColor = UIColor.lightGray
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20), child: textNode)
    }
}
