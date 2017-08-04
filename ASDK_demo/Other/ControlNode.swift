//
//  ControlNode.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/4.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ControlNode: ASDisplayNode {
    
    fileprivate var buttons = [Control]()
    
    init(info:[ControlInfo], callback: @escaping ((Int)->Void)) {
        super.init()
        
        isUserInteractionEnabled = true
        
        for i in 0..<info.count {
            
            let abtn = Control(info: info[i], tag: i, callback: callback)
            
            buttons.append(abtn)
            addSubnode(abtn)
        }
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .baselineLast, children: buttons)
        
        return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: stack)
    }
    
    class Control: ASDisplayNode {
        
        lazy var button = ASButtonNode()
        lazy var textNode = ASTextNode()
        
        fileprivate var callback: ((Int)->Void)?
        fileprivate var selects = [String]()
        fileprivate var currentIndex = 0
        
        init(info: ControlInfo, tag: Int, callback: ((Int)->Void)?) {
            
            super.init()
            
            self.callback = callback
            
            button.borderColor = SJColor(230, green: 230, blue: 230).cgColor
            button.borderWidth = 0.5
            button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            button.addTarget(self, action: #selector(Control.doControlClick(sender:)), forControlEvents: .touchUpInside)
            button.setTitle(info.title, with: UIFont.systemFont(ofSize: 16), with: UIColor.darkText, for: .normal)
            button.setTitle(info.title, with: UIFont.systemFont(ofSize: 16), with: UIColor.darkGray, for: .highlighted)
            
            button.view.tag = tag
            
            addSubnode(button)
            
            self.currentIndex = info.defaultIdx
            self.selects = info.descs
            textNode.attributedText = NSAttributedString(string: selects[currentIndex], attributes: defaultAttri())
            textNode.style.flexShrink = 1
            textNode.maximumNumberOfLines = 2
            textNode.style.maxWidth = ASDimensionMake(75)
            addSubnode(textNode)
        }
        
        func doControlClick(sender: ASButtonNode) {
            
            callback?(sender.view.tag)
            
            currentIndex += 1
            if currentIndex >= selects.count {
                
                currentIndex = 0
            }
            textNode.attributedText = NSAttributedString(string: selects[currentIndex], attributes: defaultAttri())
        }
        
        override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
            
            return ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .center, alignItems: .center, children: [textNode, button])
            
        }
    }
}

struct ControlInfo {
    
    var title: String
    var descs: [String]
    
    var defaultIdx = 0
    
    init(title: String, descs: [String], index: Int) {
        
        self.title = title
        self.descs = descs
        self.defaultIdx = index
    }
    
    init(title: String, descs: [String]) {
        
        self.title = title
        self.descs = descs
    }
    
    init(title: String) {
        self.title = title
        self.descs = [""]
    }
    
    static func creat(titles: [String]) -> [ControlInfo] {
        
        var info = [ControlInfo]()
        titles.forEach{info.append(ControlInfo(title: $0))}
        return info
    }
}
