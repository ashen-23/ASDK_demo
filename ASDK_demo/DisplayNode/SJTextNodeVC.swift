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

    fileprivate var textNode: SJTextDisplay?

    override func viewDidLoad() {
        super.viewDidLoad()

        textNode = SJTextDisplay(delegate: self)
        
        textNode?.frame = SJPagingRect
        view.addSubnode(textNode!)
        
    }

}

extension SJTextNodeVC: ASTextNodeDelegate {
    
    // 需要as_allowsHighlightDrawing 设置为true
    func textNode(_ textNode: ASTextNode, shouldHighlightLinkAttribute attribute: String, value: Any, at point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(_ textNode: ASTextNode, tappedLinkAttribute attribute: String, value: Any, at point: CGPoint, textRange: NSRange) {
        
        // attribute 指代的是linkAttributeNames中的linkKey
        self.view.makeToast("您点击了文本:----\(value as! String)----")
    }
}


// MARK: - 显示的text node
fileprivate class SJTextDisplay: ASDisplayNode {

    lazy var textNode = ASTextNode()
    
    var textNode1: SJTextNode?
    var textNode2: SJTextNode?
    
    var titleNodes = [ASTextNode]()

    init(delegate: ASTextNodeDelegate) {
        super.init()
        
        addTouchText()
        configNode(delegate: delegate)

        addTitles()
    }
    
    func addTouchText() {
        
        textNode.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: 180)
        self.view.addSubnode(textNode)
        textNode.style.height = ASDimensionMake(130)
        
        textNode1 = SJTextNode(text: displayStr)
        textNode1?.frame = CGRect(x: 0, y: 270, width: UIScreen.main.bounds.size.width, height: 180)
        view.addSubnode(textNode1!)
        textNode1?.style.height = ASDimensionMake(130)

        textNode2 = SJTextNode(text: displayStr, displaySignal: false)
        textNode2?.frame = CGRect(x: 0, y: 470, width: UIScreen.main.bounds.size.width, height: 180)
        view.addSubnode(textNode2!)
        textNode2?.style.height = ASDimensionMake(130)

    }
    
    func configNode(delegate: ASTextNodeDelegate) {
        
        textNode.isUserInteractionEnabled = true
        textNode.linkAttributeNames = [linkKey]
        textNode.delegate = delegate
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
    
    func addTitles() {
    
        for _ in 0..<3 {
            let aText = ASTextNode()
            titleNodes.append(aText)
            addSubnode(aText)
        }
        
        titleNodes[2].attributedText = NSAttributedString(string: "ASDK demo", attributes: defaultAttri())
        titleNodes[1].attributedText = NSAttributedString(string: "custom", attributes: defaultAttri())
        titleNodes[0].attributedText = NSAttributedString(string: "ignore symbal", attributes: defaultAttri())

    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        var children = [textNode, textNode1!, textNode2!]
        var i = 2
        titleNodes.forEach {
            children.insert($0, at: i)
            i -= 1
        }
        return ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .center, children: children)
    }
    
}

let displayStr = "Lorem ipsum @dolor sit er elit, @consectetaur cillium #adipisicing# pecu, @sed Ut enim ad #minim veniam#, 点我跳转 esse #cillum dolore#. Excepteur sint occaecat cupidatat non proident, Nam https://www.baidu.com adc"
