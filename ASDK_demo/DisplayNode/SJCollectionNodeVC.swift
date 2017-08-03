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
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 120)
        
        collectionNode = ASCollectionNode(collectionViewLayout: layout)
        
        collectionNode?.delegate = self
        collectionNode?.dataSource = self
        
        view.addSubnode(collectionNode!)
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
            
            return node
        }
    }
}
