# ASDK_demo
介绍了常用的Node(image, button, table)等, 以及布局系统的各种布局(layoutSpec)及其相关参数,后期考虑添加复杂界面的demo和游戏的方式来适应新的布局系统.



### Overview

- ASImageNode( == UIImageView),
  - 包括ASImageNode 和 ASNetworkImageNode(设置url自动异步下载图像)
- ASTextNode( == UILabel)
  - 支持文本点击,
  - 扩展了自动识别 ```#话题#``` 和 ```@```
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

