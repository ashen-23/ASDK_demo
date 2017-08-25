# ASDK_demo
AsyncDisplayKit(更名为Texture，以下简称ASDK)

介绍了常用的Node(image, button, table)等, 以及布局系统的各种布局(layoutSpec)及其相关参数,后期考虑添加复杂界面的demo和游戏的方式来适应新的布局系统.



### Overview

- 什么是 AsyncDisplayKit？

  ​	[AsyncDisplayKit](https://github.com/facebook/AsyncDisplayKit)是Facebook 开源的一个```异步界面渲染```库。

  ​

- 什么时候选用AsyncDisplayKit？

  ​	界面复杂，fps低于60.

  ​


- 如何看待ASDisplayNode？

  Node -> UIView  ==  UIView -> CALayer

  Node是对UIView的抽象，类似于：UIView是CALaye的抽象。

  ​

- 如何使用ASDK？
  - 导入

  ```swift
  // pod 导入
  pod 'AsyncDisplayKit'

  // 使用时引用
  import AsyncDisplayKit
  ```

  - 添加视图

  ```swift
  view1.addSubnode(node1)

  view2.addSubview(node1.view)

  // UIView -> ASDisplayNode
  let activity = ASDisplayNode { () -> UIView! in
      return UIActivityIndicatorView()
  }
  node1.addSubnode(activity)
  ```

  - 设置布局

  ```swift
  // AsyncDislayKit 中
  ASStackLayoutSpec(direction: .vertical, spacing: 20, justifyContent: .start, alignItems: .center, children: [mImageNode, mNetText])

  // UIView 中
  node1.frame = CGRect(x: 0, y: 180, width: 200, height: 100)

  // UIView autolayout
  node1.view.snp.makeConstraints { (make) in
      make.edges.equalTo(self.view)
  }
  ```


### 使用 

talk is cheap, show me the code

##### Node 视图使用

- ASImageNode( UIImageView)

   - 设置图片

   ```swift
   imgNode.image = UIImage(named: "img")
   ```
   - 设置url

   ```swift
   var mNetImgNode = ASNetworkImageNode()
   mNetImgNode.url = URL(string: "https://source.unsplash.com/random/500*500")

   // 可以对图片进行特殊处理
   mNetImgNode.imageModificationBlock = { image in
     // 设置尺寸
       let rect = CGRect(x: 0, y: 0, width: width, height: width)
       UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
       UIBezierPath(roundedRect: rect, cornerRadius: width / 2).addClip() // 圆角

       image.draw(in: rect)
       let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return modifiedImage
   }
   ```

- ASTextNode( UILabel)
  - 设置文本

   ```swift
   let aStyle = NSMutableParagraphStyle()
   aStyle.lineSpacing = 5 // 行间距
   aStyle.alignment = .center  // 文本对齐方式
    
   let attribute = [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: aStyle]
   textNode1.attributedText = NSAttributedString(string: displayStr, attributes: attribute)
   ```
- 超链接
     ```swift
     textNode.linkAttributeNames = "linkKey"
     let lintAttri = ["linkKey": "点我跳转",
               NSFontAttributeName: UIFont.systemFont(ofSize: 16),NSForegroundColorAttributeName: SJColor(20, green: 						130,blue: 240),NSUnderlineStyleAttributeName: 1]
     result.addAttributes(lintAttri, range: NSRange(location: 0, length: 6))
     textNode.attributedText = result
     ```

- 自己封装的SJTextNode ```#话题#``` 和 ```@```

   ```swift
   // 使用
   SJTextNode(text: "本期的话题是#话题#") // 可点击带着符号
   SJTextNode(text: "本期的话题是#话题#", displaySignal: false) // 可点击且隐藏符号
   // 自定义匹配规则
   regular = SJTextRegular(type: SJLinkStyle.custom, start: "#", end: "#")
   ```

- ASButtonNode (UIButton)
  -  使用和UIButton类似

  - 特殊属性

     ```swift
     // 内容 padding
     btnNode1.contentEdgeInsets = UIEdgeInsets.zero

     // 图右文左
     btnNode2.imageAlignment = .end

     // 图上文下
     btnNode3.laysOutHorizontally = false

     // 图下文上
     btnNode4.laysOutHorizontally = false
     btnNode4.imageAlignment = .end

     // 图文顶部对齐
     btnNode5.contentVerticalAlignment = .top
     ```

- ASTableNode (UITableView)
  - delegate，dataSource设置和UITableView类似

    ```swift
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
    }
    ```

  - 设置UITableView相关属性
    ```swift
    // 通过tableNode.view获取ASTableView(继承自UITableView)
    // tableHeader tableFooter
    tableNode.view.tableHeaderView = UIView()
    tableNode.view.tableHeaderView = node.view
    tableNode.view.tableFooterView = UIView()

    // 设置其他属性
    tableNode?.view.separatorColor = 
    tableNode?.view.visibleCells = 
    ```

- ASCollectionNode(UICollectionView)
  - Node, NodeSupplementary
  - Node size
  - 自动加载更多数据
    ```swift
    // delegat 中
    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        
        context.beginBatchFetching()
        
        let newRows = SJClass(rows: 30)
        DispatchQueue.main.async {
            self.view.makeToast("刷新一组新数据,共\(newRows.persons.count)条")
            self.insertRows(data: newRows)
            context.completeBatchFetching(true)
        }
    }
    ```


### Layout

- Inset
  - 边距, 类似于padding
- Stack
  - UIStackView, 对个元素之间对齐方式(最有用)
- Relative & center
  - 相对位置(左上, 左中, 左下, 右上等 )
- Ratio
  - 自身宽高比(适合ASImageNode, ASVideoNode)
- Overlay & background
  - 覆盖
- Absolute
  - 位置 + 尺寸



### Games

- Waiting...

