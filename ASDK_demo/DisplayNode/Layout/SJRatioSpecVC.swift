//
//  SJRatioSpecVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/4.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJRatioSpecVC: UIViewController {

    lazy fileprivate var ratioNode = RatioNode()
    override func viewDidLoad() {
        super.viewDidLoad()

        ratioNode.frame = CGRect(x: 0, y: 4, width: UIScreen.main.bounds.size.width, height: 350)
        view.addSubnode(ratioNode)
        
        // 控制UI
        let contolNode = ControlNode(info: fetchControl()) { [weak self] index in
            
            self?.updateLayout(index: index)
        }
        
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
        
        infos.append(ControlInfo(title: "ratio", descs: ["h/w = 0.5", "h/w = 1", "h/w = 1.5"]))
        
        infos.append(ControlInfo(title: "reset"))
        
        return infos
    }
    
    func updateLayout(index: Int) {
        
        switch index {
        case 0:
            
            ratioNode.ratio += 1

        default:
            
            ratioNode.reset()
        }
    }

}

fileprivate class RatioNode: ASDisplayNode {

    let imgNode = ASNetworkImageNode()
    
    var ratio: CGFloat = 0 {
        didSet {
            if ratio > 2 { ratio = 0 }
            setNeedsLayout()
        }
    }
    
    override init() {
        super.init()
        
        imgNode.url = randomImgUrl()
        imgNode.clipsToBounds = true
        
        addSubnode(imgNode)
        
        backgroundColor = SJColor(230, green: 230, blue: 230)
    }
    
    func reset() {
        
        ratio = 0
        setNeedsLayout()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
     
        let ratioSpec = ASRatioLayoutSpec(ratio: 0.5 * (ratio + 1), child: imgNode)
        
        return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: ratioSpec)
    }
}
