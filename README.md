# IMXUIsCpt
控件类组件集合：包含UIs工具、以及UIs控件。后续会将成熟的UI组件单独开放出来。

## 1. 使用:

1. 在Podsfile顶部添加pods私有源。(主repo下面添加即可)

	> source 'https://github.com/PanZhow/IMXPodsRepo.git'
	
2. Podsfile中添加：``pod 'IMXUIsCpt', '~> 1.0.0'``

## 2. 组件列表：

1. IMXUIKitExt: UIkit扩展集合。
2. IMXStyleKit：内部含有`Color色值工具`、`Font字体工具`、`iconFont工具`等辅助类工具。
3. IMXTips：Alert提示框、Toast提示框。
4. IMXDeviceInfo：获取设备软件信息、硬件信息工具类。
5. IMXTabBarKit：TabBar自定义UI控件。（后续单独抽离）
6. IMXListView：关于列表相关的辅助类：UITableView、UICollectionView。
7. IMXSegmentKit：可切换的选项卡UI工具，属自定义控件。（后续单独抽离）
8. IMXSafeAreaKit：获取SafeArea的工具类。
9. IMXUIs：UIs工具集合，存放常用的自定义UI。

## 3. 验证和同步:

**因内部有模块使用到`IMXFuncCpt`私有库，故在此步骤中需要指明私有repo源。**

1. 验证:

	>  pod lib lint --sources='https://github.com/PanZhow/IMXPodsRepo.git,https://github.com/CocoaPods/Specs'
	
2. 同步repo：

	> pod repo push IMXRepo IMXUIsCpt.podspec --sources='https://github.com/PanZhow/IMXPodsRepo.git,https://github.com/CocoaPods/Specs'
	
	

