//
//  SJNodeVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/1.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import SnapKit

class SJOverviewVC: UIViewController {

    lazy var tableView = ASTableNode()
    
    // "image", "text", "button", "table", "collection"
    lazy var titles = ["Node", "layout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Overview"
        configTable()
    }

    func configTable() {
    
        tableView.view.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubnode(tableView)
        
        // 需要设置tableView属性, 使用tableView.view
        tableView.frame = UIScreen.main.bounds
    }

}

extension SJOverviewVC: ASTableDelegate, ASTableDataSource {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        // 不能在block中获取数据
        let aTitle = titles[indexPath.row]
        
        return {
        
            return SJNodeCell(title: aTitle)
        }
        
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
        var aVC: UIViewController
        
        switch indexPath.row {
        case 0:
            
             aVC = SJNodeViewVC()
        case 1:

            aVC = SJLayoutSpecVC()
            
        default:
            
            aVC = UIViewController()
        }
        
        aVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(aVC, animated: true)
    }
    
}


//***************************************************
// MARK: - cell
class SJNodeCell: ASCellNode {
    
    lazy var textNode = ASTextNode()
    
    init(title: String) {
        
        super.init()
        
        textNode.attributedText = NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)])
        
        addSubnode(textNode)
        
        selectionStyle = .none
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15, left: 25, bottom: 15, right: 25), child: textNode)
    }
    
}


private let SBNode = "Display"
let SBLayout = "LayoutSpec"
