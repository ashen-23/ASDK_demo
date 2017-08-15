//
//  SJButtonNodeVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJButtonNodeVC: UIViewController {

    lazy fileprivate var buttonNode = SJButtonNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonNode.frame = SJPagingRect
        
        view.addSubnode(buttonNode)
        
    }
}


fileprivate class SJButtonNode: ASDisplayNode {
    
    var buttons = [ASButtonNode]()

    override init() {
        
        super.init()
        
        configBtn()
    }
    
    func configBtn() {
        
        for i in 0..<6 {
        
            buttons.append(ASButtonNode())
            buttons[i].setImage(UIImage(named: "button_normal"), for: .normal)
            buttons[i].setImage(UIImage(named: "button"), for: .highlighted)
            buttons[i].setTitle("视频按钮", with: UIFont.systemFont(ofSize: 16), with: UIColor.black, for: .normal)
            buttons[i].setTitle("按下按钮", with: UIFont.systemFont(ofSize: 16), with: UIColor.gray, for: .highlighted)
            buttons[i].addTarget(self, action: #selector(SJButtonNode.doBtnClick), forControlEvents: .touchUpInside)
            
            // 设置border属性
            buttons[i].borderWidth = 0.5
            buttons[i].borderColor = SJColor(210, green: 210, blue: 210).cgColor
            buttons[i].cornerRadius = 5
            
            buttons[i].contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)

            addSubnode(buttons[i])
        }
        
        custom()
    }
    
    func custom() {
        
        buttons[1].contentEdgeInsets = UIEdgeInsets.zero // 图左字右
        buttons[2].imageAlignment = .end // 图右字左

        buttons[3].laysOutHorizontally = false // 图上字下
        
        // 图下字上
        buttons[4].laysOutHorizontally = false
        buttons[4].imageAlignment = .end
        
        buttons[5].contentVerticalAlignment = .top // 图字上对齐
    }
    
    func doBtnClick() {
    
        view.makeToast("点击按钮")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASStackLayoutSpec(direction: .vertical, spacing: 20, justifyContent: .center, alignItems: .center, children: buttons)

    }
}
