# ASDK_demo
AsyncDisplayKit(更名为Texture，以下简称ASDK)

介绍了常用的Node(image, button, table)等, 以及布局系统的各种布局(layoutSpec)及其相关参数,后期考虑添加复杂界面的demo和游戏的方式来适应新的布局系统.



### Overview

- 什么是 AsyncDisplayKit？

  ​	

- 如何看待ASDisplayNode？

  Node -> UIView  ==  UIView -> CALayer

  ​

- 如何使用ASDK？

  - 添加视图

  ```swift
  view1.addSubnode(node1)

  view2.addSubview(node1.view)

  node1.addSubnode( ASDisplayNode { return view1 })

  ```

  - 设置布局

  ```swift
  ASStackLayoutSpec(direction: .vertical, spacing: 20, justifyContent: .start, alignItems: .center, children: [mImageNode, mNetText])
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
	regular = SJTextRegular(type: self, start: "#", end: "#")
   ```

- ASButtonNode ( == UIButton)
  -  任意自定义image 和text的位置
  -  可设置内容边距contentEdgeInsets

- ASTableNode ( == UITableView)
  - 显示tableHeaderView, viewForHeader, Node
  - 点击操作, 自动行高
  - 自动加载更多数据

- ASCollectionNode( == UICollectionView)
  - Node, NodeSupplementary
  - Node size
  - 自动加载更多数据



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

