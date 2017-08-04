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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let demo = StackDemoNode()
        demo.frame = SJPagingRect
        view.addSubnode(demo)
        
        let contolNode = ControlNode(info: fetchControl()) { [weak self] index in
        
            self?.updateLayout(index: index)
        }
        
       // contolNode.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 45)
        view.addSubnode(contolNode)
        
        contolNode.view.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-30)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(100)
        }
    }

    
    func fetchControl() -> [ControlInfo] {
        
        var infos = [ControlInfo]()
        
        infos.append(ControlInfo(title: "direct", descs: ["horizontal", "vertical"]))
        
        infos.append(ControlInfo(title: "spacing"))
        
        infos.append(ControlInfo(title: "justify", descs: ["start", "center", "end", "spaceBetween", "spaceAround"]))
        
        infos.append(ControlInfo(title: "alignItems", descs: ["start", "end", "center", "stretch", "baselineFirst", "baselineLast"]))
        
        infos.append(ControlInfo(title: "reset"))
        
        return infos
    }

    func updateLayout(index: Int) {
    
        
    }
}


fileprivate class StackDemoNode: ASDisplayNode {

    lazy var items = [ASDisplayNode]()
    
    var direct: Int = 0
    var spacing: CGFloat = 10
    var justify: Int = 0
    var alignItems: Int = 0
    
    override init() {
        super.init()
        
        let aBtn = ASButtonNode()
        aBtn.setTitle("stack", with: UIFont.systemFont(ofSize: 16), with: UIColor.darkText, for: .normal)
        aBtn.borderColor = SJColor(230, green: 230, blue: 230).cgColor
        aBtn.borderWidth = 0.5
        aBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        items.append(aBtn)
        
        let aImg = ASImageNode()
        aImg.image = UIImage(named: "button_normal")
        items.append(aImg)
        
        let aText = ASTextNode()
        aText.attributedText = NSAttributedString(string: "Lorem ipsum dolor sit er elit, consectetaur cillium adipisicing pecu", attributes: defaultAttri())
        aText.style.flexShrink = 1
        items.append(aText)
        
        addSubnode(aBtn)
        addSubnode(aImg)
        addSubnode(aText)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let aDirect = ASStackLayoutDirection(rawValue: UInt(direct)) ?? ASStackLayoutDirection.horizontal
        let aJustify = ASStackLayoutJustifyContent(rawValue: UInt(justify)) ?? ASStackLayoutJustifyContent.start
        let align = ASStackLayoutAlignItems(rawValue: UInt(alignItems)) ?? ASStackLayoutAlignItems.start
        return ASStackLayoutSpec(direction: aDirect, spacing: spacing, justifyContent: aJustify, alignItems: align, children: items)
    }
    
}
