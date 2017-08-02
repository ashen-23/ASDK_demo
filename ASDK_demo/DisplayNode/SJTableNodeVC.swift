//
//  SJTableNodeVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SJTableNodeVC: UIViewController {

    var tableNode: ASTableNode?
    
    fileprivate var grade: [SJClass]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configTable()
        
        grade = SJClass.create()
    }

    
    func configTable() {
    
        tableNode = ASTableNode()
        
        tableNode?.frame = SJScreenRect
        
        view.addSubnode(tableNode!)
    }

}



extension SJTableNodeVC: ASTableDelegate, ASTableDataSource {

    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return grade?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        
        return grade?[section].persons.count ?? 0
    }
    
}

//*****************************************
//MARK: - data struct
fileprivate struct SJClass {

    var name: String
    var persons: [SJPerson]
    
    init() {
        
        name = randomName()
        
        persons = [SJPerson]()
        let randon = Int(arc4random_uniform(30) + 1)
        for _ in 0..<randon {
            persons.append(SJPerson())
        }
    }
    
    static func create() -> [SJClass] {
    
        var classes = [SJClass]()
        
        let randon = Int(arc4random_uniform(6) + 1)
        for _ in 0..<randon {
        
            classes.append(SJClass())
        }
        
        return classes
    }
}

fileprivate struct SJPerson {

    var name: String
    var avator: URL?
    
    init() {
        
        name = randomName()
        avator = randomImgUrl()
    }
}
