//
//  SJImageNodeVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/1.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJImageNodeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SJImageNodeVC"
        
        let aNode = SJImageNode()
        
        aNode.frame = SJPagingRect
        
        self.view.addSubnode(aNode)        
    }

}


class SJImageNode: ASDisplayNode {

    lazy var mImageNode = ASImageNode()
    lazy var mNetImgNode = ASNetworkImageNode()
    
    lazy var mImgText = ASTextNode()
    lazy var mNetText = ASTextNode()
    
    let imgSize = CGSize(width: 150, height: 150)
    
    override init() {
        super.init()
        
        mImageNode.style.preferredSize = imgSize // 设置大小
        mImageNode.image = UIImage(named: "yaoming")
        mImageNode.borderWidth = 0.5 // border
        mImageNode.borderColor = UIColor.blue.cgColor
        
        mNetImgNode.style.preferredSize = imgSize
        mNetImgNode.defaultImage = UIImage(named: "default") // 默认图
        mNetImgNode.url = URL(string: "https://source.unsplash.com/random/500*500")
        let width = imgSize.width * UIScreen.main.scale
        
        mNetImgNode.imageModificationBlock = { image in
            
            let rect = CGRect(x: 0, y: 0, width: width, height: width)
            UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
            UIBezierPath(roundedRect: rect, cornerRadius: width / 2).addClip() // 圆角
            
            image.draw(in: rect)
            let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return modifiedImage
        }
        
        addSubnode(mImageNode) // 必须要添加
        addSubnode(mNetImgNode)
        
        mImgText.attributedText = NSAttributedString(string: "本地图片", attributes: defaultAttri())
        mNetText.attributedText = NSAttributedString(string: "网络图片", attributes: defaultAttri())
        
        addSubnode(mImgText)
        addSubnode(mNetText)

    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        // stack
        let aStack = ASStackLayoutSpec(direction: .vertical, spacing: 20, justifyContent: .start, alignItems: .center, children: [mImageNode, mImgText,  mNetImgNode, mNetText])
        
        // 居中
        return ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .center, sizingOption: .minimumSize, child: aStack)
       // return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30), child: aStack)
    }
    
}

