//
//  SJTextNodeVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private let linkKey = "linkKey"

class SJTextNodeVC: UIViewController {

    lazy var textNode = ASTextNode()
    
    var autoTextNode: SJTextNode?

    override func viewDidLoad() {
        super.viewDidLoad()

        addTouchText()
    }

    func addTouchText() {
        
        textNode.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubnode(textNode)
        configNode()
        
        autoTextNode = SJTextNode(text: displayStr)
        autoTextNode?.frame = CGRect(x: 0, y: 300, width: UIScreen.main.bounds.size.width, height: 200)
        view.addSubnode(autoTextNode!)
    }
    
    func configNode() {
        
        textNode.isUserInteractionEnabled = true
        textNode.linkAttributeNames = [linkKey]
        textNode.delegate = self
        textNode.layer.as_allowsHighlightDrawing = true // 设置为true, 选中高亮才能生效
        
        let result = NSMutableAttributedString(string: displayStr, attributes: defaultAttri())
        
        let range = (displayStr as NSString).range(of: "点我跳转")
        result.addAttributes(linkAttrs(), range: range)
        
        textNode.attributedText = result
    }
    
    func linkAttrs() -> [String: Any] {
        
        // NSUnderlineStyleAttributeName 使用swift会崩溃, 自动转换成int吧
        return [linkKey: "点我跳转",
                NSFontAttributeName: UIFont.systemFont(ofSize: 16),
                NSForegroundColorAttributeName: SJColor(20, green: 130, blue: 240),
                NSUnderlineStyleAttributeName: 1
        ]
    }

}

extension SJTextNodeVC: ASTextNodeDelegate {
    
    // 需要as_allowsHighlightDrawing 设置为true
    func textNode(_ textNode: ASTextNode, shouldHighlightLinkAttribute attribute: String, value: Any, at point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(_ textNode: ASTextNode, tappedLinkAttribute attribute: String, value: Any, at point: CGPoint, textRange: NSRange) {
        
        // 点击
        // attribute 指代的是linkAttributeNames中的linkKey
        self.view.makeToast("您点击了文本:----\(value as! String)----")
    }
}



private let displayStr = "Lorem ipsum @dolor sit er elit lamet, @consectetaur cillium #adipisicing# pecu, sed do #eiusmod tempor# incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.点我跳转 Duis aute irure dolor in reprehenderit in voluptate velit esse #cillum dolore# eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam @liber te conscient to factor tum poen legum odioque civiuda."
