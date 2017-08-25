//
//  SJStackSpecVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/3.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJStackSpecVC: UIViewController {

    lazy fileprivate var demoNode = StackDemoNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        demoNode.frame = CGRect(x: 0, y: 4, width: UIScreen.main.bounds.size.width, height: 350)
        
        view.addSubnode(demoNode)
        
        let contolNode = ControlNode(info: fetchControl()) { [weak self] index in
        
            self?.updateLayout(index: index)
        }
        
       // contolNode.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 45)
        view.addSubnode(contolNode)
        
        // autoLayout
        contolNode.view.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-30)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(100)
        }
    }

    
    func fetchControl() -> [ControlInfo] {
        
        var infos = [ControlInfo]()
        
        infos.append(ControlInfo(title: "direct", descs: ["vertical", "horizontal"]))
        
        infos.append(ControlInfo(title: "spacing"))
        
        infos.append(ControlInfo(title: "justify", descs: ["start", "center", "end", "spaceBetween", "spaceAround"]))
        
        infos.append(ControlInfo(title: "alignItems", descs: ["start", "end", "center", "stretch", "baselineFirst", "baselineLast"]))
        
        infos.append(ControlInfo(title: "reset"))
        
        return infos
    }

    func updateLayout(index: Int) {
    
        switch index {
        case 0:
            
           demoNode.direct += 1
            
        case 1:
            
            demoNode.spacing += 10
            
        case 2:
            
            demoNode.justify += 1
            
        case 3:
            
            demoNode.alignItems += 1
            
        default:
            
            demoNode.reset()
        }
    }
}


fileprivate class StackDemoNode: ASDisplayNode {

    lazy var items = [ASDisplayNode]()
    
    var spacing: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var direct: Int = 0 {
        didSet {
            if direct > 1 { direct = 0 }
            setNeedsLayout()
        }
    }
    var justify: Int = 0 {
        didSet {
            if justify > 4 { justify = 0 }
            setNeedsLayout()
        }
    }
    var alignItems: Int = 0 {
        didSet {
            if alignItems > 5 { alignItems = 0 }
            setNeedsLayout()
        }
    }
    
    override init() {
        super.init()
        
        backgroundColor = SJColor(230, green: 230, blue: 230)
        clipsToBounds = true
        
        let aBtn = ASButtonNode()
        aBtn.setTitle("stack", with: UIFont.systemFont(ofSize: 16), with: UIColor.darkText, for: .normal)
        setBorder(node: aBtn)
        aBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        items.append(aBtn)
        
        let aImg = ASImageNode()
        aImg.image = UIImage(named: "button_normal")
        aImg.clipsToBounds = true
        setBorder(node: aImg)
        items.append(aImg)
        
        let aText = ASTextNode()
        aText.attributedText = NSAttributedString(string: "Lorem ipsum dolor sit er elit, consectetaur cillium adipisicing pecu", attributes: defaultAttri())
        aText.style.flexShrink = 1 // 保证超出换行
        setBorder(node: aText)
        items.append(aText)
        
        addSubnode(aBtn)
        addSubnode(aImg)
        addSubnode(aText)
    }
    
    fileprivate func setBorder(node: ASDisplayNode) {
    
        node.borderColor = SJColor(20, green: 130, blue: 240).cgColor
        node.borderWidth = 0.5
    }
    
    func reset() {
    
        direct = 0
        spacing = 10
        justify = 0
        alignItems = 0
        
        setNeedsLayout()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let aDirect = ASStackLayoutDirection(rawValue: UInt(direct)) ?? ASStackLayoutDirection.vertical
        let aJustify = ASStackLayoutJustifyContent(rawValue: UInt(justify)) ?? ASStackLayoutJustifyContent.start
        let align = ASStackLayoutAlignItems(rawValue: UInt(alignItems)) ?? ASStackLayoutAlignItems.start
        return ASStackLayoutSpec(direction: aDirect, spacing: spacing, justifyContent: aJustify, alignItems: align, children: items)
    }
    
}
