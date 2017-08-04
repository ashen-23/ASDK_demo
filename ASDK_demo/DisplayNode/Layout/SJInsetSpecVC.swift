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
        
        var button = ASButtonNode()
        
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
            
            button.view.tag = tag
            
            addSubnode(button)
            
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


