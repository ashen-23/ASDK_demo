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
    
    var grade: [SJClass]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        grade = SJClass.create()

        configTable()        
    }

    
    func configTable() {
    
        tableNode = ASTableNode()
        
        tableNode?.frame = UIScreen.main.bounds
        
        tableNode?.delegate = self
        tableNode?.dataSource = self
        
        // add table header
        let header = SJableHeader()
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 125)
        tableNode?.view.tableHeaderView = header.view
        
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
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let person = grade?[indexPath.section].persons[indexPath.row]
        
        return {
        
            return SJTableNoe(person: person)
        }
    }
    
    // header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let aTitle = grade?[section].name
        return SJableHeaderNode(title: aTitle).view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
    }
}



// table header
class SJableHeader: ASDisplayNode {
    
    lazy var textNode = ASTextNode()
    
    lazy var icons = [ASImageNode]()
    
    override init() {
        super.init()
        
        textNode.attributedText = NSAttributedString(string: "table headerView", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.black])
        
        addSubnode(textNode)
        
        backgroundColor = UIColor.lightGray
        
        // add image node
        for _ in 0..<4 {
        
            let aImg = ASNetworkImageNode()
            aImg.style.preferredSize = CGSize(width: 30, height: 30)
            aImg.url = randomImgUrl(width: 30)
            let width = 30 * UIScreen.main.scale
            
            aImg.imageModificationBlock = { image in
                
                let rect = CGRect(x: 0, y: 0, width: width, height: width)
                UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
                
                image.draw(in: rect)
                let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                return modifiedImage
            }
            
            icons.append(aImg)
            addSubnode(aImg)
        }
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stackH = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: icons)
        
        let stackV = ASStackLayoutSpec(direction: .vertical, spacing: 20, justifyContent: .start, alignItems: .center, children: [textNode, stackH])
        
        return ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .center, sizingOption: .minimumSize, child: stackV)
    }
}


//*****************************************
