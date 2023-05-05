#### 
很好处理分类和界面嵌套，多界面联动的两个组件
1、JXCategoryView（JXSegmentedView）：(腾讯新闻、今日头条、QQ音乐、网易云音乐、京东、爱奇艺、腾讯视频、淘宝、天猫、简书、微博等所有主流APP分类切换滚动视图)
2、JXPagingView：类似微博主页、简书主页、QQ联系人页面。多页面嵌套，既可以上下滑动，也可以左右滑动切换页面。支持HeaderView悬浮、支持下拉刷新、上拉加载更多

oc版本
JXCategoryView:https://github.com/pujiaxin33/JXCategoryView
JXPagingView:https://github.com/pujiaxin33/JXPagingView


swift版本
JXSegmentedView：https://github.com/pujiaxin33/JXSegmentedView
JXPagingView：https://github.com/pujiaxin33/JXPagingView

tips:
OC版本：
⚠️⚠️⚠️
将pagerView的listContainerView和categoryView.listContainer进行关联，这样列表就可以和categoryView联动了。
self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;

Swift版本：
⚠️⚠️⚠️
给JXPagingListContainerView添加extension，表示遵从JXSegmentedViewListContainer的协议
extension JXPagingListContainerView: JXSegmentedViewListContainer {}

⚠️⚠️⚠️
将pagingView的listContainerView和segmentedView.listContainer进行关联，这样列表就可以和categoryView联动了。
segmentedView.listContainer = pagingView.listContainerView

tips:
⚠️⚠️⚠️
阿拉伯语适配请通过修改数据源的顺序来适配，内部已经强制做了限制：collectionView.semanticContentAttribute = .forceLeftToRight
