//
//  SJCollectionNodeVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJCollectionNodeVC: UIViewController {

    var collectionNode: ASCollectionNode?
    
    var grade: [SJClass]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        grade = SJClass.create()

        configCollection()
    }

    func configCollection() {
    
        let layout = UICollectionViewFlowLayout()
        
        //控制item 的 Size
        //layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width / 3, height: 120)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width , height: 45)
        
        collectionNode = ASCollectionNode(collectionViewLayout: layout)
        
        collectionNode?.delegate = self
        collectionNode?.dataSource = self
        
        collectionNode?.frame = SJScreenRect
        view.addSubnode(collectionNode!)
        
        // add view header
        collectionNode?.registerSupplementaryNode(ofKind: UICollectionElementKindSectionHeader)
    }
    
}

// data source and delegate
extension SJCollectionNodeVC: ASCollectionDelegate, ASCollectionDataSource {

    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return grade?.count ?? 0
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        
        return grade?[section].persons.count ?? 0
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let person = grade?[indexPath.section].persons[indexPath.row]
        
        return {
            
            let node = SJTableNoe(person: person)
            
            //控制item 的 Size
            // node.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width / 3, height: 120)
            node.style.width = ASDimensionMake(UIScreen.main.bounds.size.width) // 如果不设置宽度, 当文本不够换行时, 会整体居中
            
            return node
        }
    }
    
    // header 
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        
        let header = grade?[indexPath.section].name
        return HeaderNode(title: header)
    }
    
}


fileprivate class HeaderNode: ASCellNode {

    lazy var textNode = ASTextNode()
    
    init(title: String?) {
        super.init()
        
        textNode.attributedText = NSAttributedString(string: title ?? "", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.black])
        
        addSubnode(textNode)
        
        backgroundColor = UIColor.lightGray
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20), child: textNode)
    }
}
