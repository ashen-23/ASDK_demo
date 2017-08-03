//
//  SJClass.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

class SJClass {
    
    var name: String
    var persons: [SJPerson]
    
    init(rows: Int = 20) {
        
        name = randomName()
        
        persons = [SJPerson]()
        let randon = Int(arc4random_uniform(UInt32(rows)) + 2)
        for _ in 0..<randon {
            persons.append(SJPerson())
        }
    }
    
    static func create(count: Int = 3, rows: Int = 20) -> [SJClass] {
        
        var classes = [SJClass]()
        
        let randon = Int(arc4random_uniform(UInt32(count)) + 2)
        for _ in 0..<randon {
            
            classes.append(SJClass(rows: rows))
        }
        
        return classes
    }
}

struct SJPerson {
    
    var name: String
    var avator: URL?
    
    init() {
        
        let randon = Int(arc4random_uniform(500) + 10)
        name = randomName(length: randon)
        avator = randomImgUrl()
    }
}
