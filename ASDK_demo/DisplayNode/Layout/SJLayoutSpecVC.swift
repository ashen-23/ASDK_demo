//
//  SJLayoutSpecVC.swift
//  ASDK_demo
//
//  Created by Shi Jian on 2017/8/3.
//  Copyright © 2017年 Shi Jian. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import PagingMenuController

class SJLayoutSpecVC: UIViewController {
    
    lazy var items = ["inset","stack", "relative", "overlay"]
    
    var mPaging: PagingMenuController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "layout Overview"
        
        configOptions()
        
        let aLine = UIView(frame: CGRect(x: 0, y: 115, width: UIScreen.main.bounds.size.width, height: 2))
        aLine.backgroundColor = SJColor(230, green: 230, blue: 230)
        view.addSubview(aLine)
    }
    
    func configOptions() {
        
        var aMenus = [MenuItemViewCustomizable]()
        var aControlers = [UIViewController]()
        
        for item in items {
            
            aMenus.append(MenuItem(title: item))
            aControlers.append(create(identifier: item))
        }
        
        let aOption = PagingMenuOptions(itemsOptions: aMenus, pagingControllers: aControlers)
        
        mPaging = PagingMenuController(options: aOption)
        addPaging()
    }
    
    // 添加控制器
    func addPaging() {
        
        guard let aPage = mPaging else { return }
        
        addChildViewController(aPage)
        
        aPage.view.frame = SJScreenRect
        
        view.addSubview(aPage.view)
        
        aPage.didMove(toParentViewController: self)
        
        aPage.move(toPage: 0)
    }
    
    func create(identifier: String) -> UIViewController {
       return storyBoard(name: SBLayout, identifier: identifier)
    }
    
}

struct PagingMenuOptions: PagingMenuControllerCustomizable {
    
    fileprivate var mItemsOptions: [MenuItemViewCustomizable]
    fileprivate var mPagingControllers: [UIViewController]
    
    init(itemsOptions: [MenuItemViewCustomizable], pagingControllers: [UIViewController]) {
        mItemsOptions = itemsOptions
        mPagingControllers = pagingControllers
    }
    
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(itemsOptions: mItemsOptions), pagingControllers: mPagingControllers)
    }
    
    struct MenuOptions: MenuViewCustomizable {
        
        fileprivate var mItemsOptions: [MenuItemViewCustomizable]
        
        init(itemsOptions: [MenuItemViewCustomizable]) {
            mItemsOptions = itemsOptions
        }
        
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var focusMode: MenuFocusMode {
            return .underline(height: 2, color: SJColor(20, green: 130, blue: 240), horizontalPadding: 10, verticalPadding: 0)
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return mItemsOptions
        }
    }
    
}

struct MenuItem: MenuItemViewCustomizable {
    
    private var aTitle: String
    
    init(title: String) {
        
        aTitle = title
    }
    
    var displayMode: MenuItemDisplayMode {
        return .text(title: MenuItemText(text: aTitle,color:SJColor(50, green: 50, blue: 50) , selectedColor: SJColor(20, green: 130, blue: 240)))
    }
}
