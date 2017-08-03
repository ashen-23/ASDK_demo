//
//  SJClass.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/2.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit

struct SJClass {
    
    var name: String
    var persons: [SJPerson]
    
    init() {
        
        name = randomName()
        
        persons = [SJPerson]()
        let randon = Int(arc4random_uniform(30) + 2)
        for _ in 0..<randon {
            persons.append(SJPerson())
        }
    }
    
    static func create() -> [SJClass] {
        
        var classes = [SJClass]()
        
        let randon = Int(arc4random_uniform(6) + 10)
        for _ in 0..<randon {
            
            classes.append(SJClass())
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
