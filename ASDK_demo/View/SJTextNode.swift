//
//  SJTextNode.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

enum SJLinkStyle: String {
    case atPerson = "atPerson"
    case sharp = "sharp"
    
    static func getNames() -> [String] {
    
        return [SJLinkStyle.atPerson.rawValue, SJLinkStyle.sharp.rawValue]
    }
}

class SJTextNode: ASTextNode {

    let regex1 = "#.*?#"
    let regex2 = "@.*?\\s"
    
    var text: String = ""
    
    init(text: String) {
        super.init()
        
        self.text = text
        self.layer.as_allowsHighlightDrawing = true
        self.isUserInteractionEnabled = true
        self.delegate = self
        self.linkAttributeNames = SJLinkStyle.getNames()
        
        matchRegular()
    }
    
    func matchRegular() {
        let attriStr = NSMutableAttributedString(string: text, attributes: SJTextNodeConfig.normalAttri())
        let range = NSRange(location: 0, length: self.text.characters.count)

        // atPerson
        let regular = try! NSRegularExpression(pattern: regex2, options: .caseInsensitive)
        regular.enumerateMatches(in: text, options: .reportCompletion, range: range) { [weak self] (result, flags, stop) in
            guard let aResult = result, let aSelf = self else { return }
            let title = (aSelf.text as NSString).substring(with: aResult.range)
            attriStr.addAttributes(SJTextNodeConfig.highlightAttri(style: SJLinkStyle.atPerson, title: title), range: aResult.range)
        }
    
        // sharp
        let regular2 = try! NSRegularExpression(pattern: regex1, options: .caseInsensitive)
        regular2.enumerateMatches(in: text, options: .reportCompletion, range: range) { [weak self] (result, flags, stop) in
            guard let aResult = result, let aSelf = self else { return }
            let title = (aSelf.text as NSString).substring(with: aResult.range)
            attriStr.addAttributes(SJTextNodeConfig.highlightAttri(style: SJLinkStyle.sharp, title: title), range: aResult.range)
        }
        
        self.attributedText = attriStr
    }
}

extension SJTextNode: ASTextNodeDelegate {

    func textNode(_ textNode: ASTextNode, shouldHighlightLinkAttribute attribute: String, value: Any, at point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(_ textNode: ASTextNode, tappedLinkAttribute attribute: String, value: Any, at point: CGPoint, textRange: NSRange) {
        
        guard let clickStr = value as? String, let type = SJLinkStyle(rawValue: attribute) else { return }
        
        switch type {
        case .atPerson:
            
            print(clickStr)
            
        case .sharp:
            
            print(clickStr)
        }
    }
}


struct SJTextNodeConfig {
    
    static func normalAttri() -> [String: Any] {
    
        return defaultAttri()
    }
    
    static func highlightAttri(style: SJLinkStyle, title: String) -> [String: Any] {
        
        return [style.rawValue: title,
                NSFontAttributeName: UIFont.systemFont(ofSize: 16),
                NSForegroundColorAttributeName: SJColor(20, green: 130, blue: 240),
                NSUnderlineStyleAttributeName: 1
                ]
    }
    
}
