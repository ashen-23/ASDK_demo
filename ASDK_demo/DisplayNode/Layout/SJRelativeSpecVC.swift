//
//  SJRelativeSpecVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/4.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJRelativeSpecVC: UIViewController {

    lazy fileprivate var relative = RelativeNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let center = CenterSpecNode()
        center.frame = CGRect(x: 0, y: 4, width: UIScreen.main.bounds.size.width, height: 200)
        view.addSubnode(center)
        
        relative.frame = CGRect(x: 0, y: 250, width: UIScreen.main.bounds.size.width, height: 200)
        view.addSubnode(relative)
        
        let contolNode = ControlNode(info: fetchControl()) { [weak self] index in
            
            self?.updateLayout(index: index)
        }
        
        view.addSubnode(contolNode)
        
        // autoLayout
        contolNode.view.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-20)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(100)
        }
        
    }
    
    func fetchControl() -> [ControlInfo] {
        
        var infos = [ControlInfo]()
        
        infos.append(ControlInfo(title: "horizontalPos", descs: ["none", "start", "center", "end"], index: 1))
        
        infos.append(ControlInfo(title: "verticalPos", descs: ["none", "start", "center", "end"], index: 1))
        
        infos.append(ControlInfo(title: "sizingOption", descs: ["minimumWidth", "minimumHeight", "minimumSize"]))
        
        infos.append(ControlInfo(title: "reset"))
        
        return infos
    }
    
    func updateLayout(index: Int) {
        
        switch index {
        case 0:
            
            relative.horiPositon += 1
            
        case 1:
            
            relative.verPositon += 1
            
        case 2:
            
            relative.sizeOption += 10
            
        default:
            
            relative.reset()
        }
    }

}

//*************************
//MARK: - spec node
fileprivate class CenterSpecNode: ASDisplayNode {
    
    lazy var imgNode = ASImageNode()
    
    override init() {
        super.init()
        
        imgNode.image = UIImage(named: "centerSpec")
        addSubnode(imgNode)
        
        backgroundColor = SJColor(230, green: 230, blue: 230)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: imgNode)
    }
}


fileprivate class RelativeNode: ASDisplayNode {

    lazy var imgNode = ASImageNode()
    
    var horiPositon = 1 {
        didSet {
            if horiPositon > 3 { horiPositon = 0 }
            setNeedsLayout()
        }
    }
    
    var verPositon = 1 {
        didSet {
            if verPositon > 3 { verPositon = 0 }
            setNeedsLayout()
        }
    }
    
    var sizeOption = 0{
        didSet {
            setNeedsLayout()
        }
    }
    
    override init() {
        super.init()
        
        imgNode.image = UIImage(named: "centerSpec")
        imgNode.style.preferredSize = CGSize(width: 160, height: 100)
        addSubnode(imgNode)
        
        backgroundColor = SJColor(230, green: 230, blue: 230)
    }
    
    func reset() {
    
        horiPositon = 1
        verPositon = 1
        sizeOption = 0
        setNeedsLayout()
    }
    
    fileprivate func getSizeOption() -> ASRelativeLayoutSpecSizingOption {
    
        if sizeOption == 0 {
            return ASRelativeLayoutSpecSizingOption.minimumWidth
        } else if sizeOption == 1 {
            return ASRelativeLayoutSpecSizingOption.minimumHeight
        }
        
        return ASRelativeLayoutSpecSizingOption.minimumSize

    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let horizontal = ASRelativeLayoutSpecPosition(rawValue: UInt(horiPositon)) ?? ASRelativeLayoutSpecPosition.none
        let vertical = ASRelativeLayoutSpecPosition(rawValue: UInt(verPositon)) ?? ASRelativeLayoutSpecPosition.none
        return ASRelativeLayoutSpec(horizontalPosition: horizontal, verticalPosition: vertical, sizingOption: getSizeOption(), child: imgNode)
    }
}

