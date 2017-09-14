## Objective-C: TableView 与 CollectionView 之间的联动Demo图
- - -
![scroll.gif](http://upload-images.jianshu.io/upload_images/1157148-5e079f6449172684.gif?imageMogr2/auto-orient/strip)

##### 实现 tableView与 CollectionView联动 主要分两种状况
- 点击 左侧 TableView.cell 让右侧 CollectionView 滚到对应位置
- 滑动 右侧 CollectionView 让左侧 TableView.cell 滚到对应位置

##### 实现
###### 1.初始化
```Objective-C
// 记录滚动的方向,默认：YES,向下
@property(assign,nonatomic) BOOL isScrollDown;
```

```Objective-C
- (void)viewDidLoad {
    [super viewDidLoad];

    // 默认选中第一行
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
```

###### 2.点击 左侧 cell 让右侧 CollectionView 滚到对应位置
```Objective-C
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // 点击cell，UITableView滚动到相应的row
    [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    // !!!重点:解决点击 TableView 后 CollectionView 的 Header 遮挡问题
    // 获取CollectionView需要滚动的Section
    NSIndexPath *collectionIndexPath = [NSIndexPath indexPathForItem:0 inSection:indexPath.row];
    // 获取Section对应CollectionView布局属性
    UICollectionViewLayoutAttributes *attributes = [self.rightCollectionView layoutAttributesForItemAtIndexPath:collectionIndexPath];
    // 设置CollectionView滚动位置
     [self.rightCollectionView setContentOffset:CGPointMake(0, attributes.frame.origin.y - self.rightCollectionView.contentInset.top) animated:YES];
}
```

###### 3.滑动 右侧 CollectionView 让左侧 tableView 滚到对应位置
```Objective-C
// 获取CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    static CGFloat lastOffsetY = 0;

    if (self.rightCollectionView == scrollView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}
```

```Objective-C
// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && collectionView.dragging) {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath {

    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if ( _isScrollDown && collectionView.dragging) {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index {
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}
```

###### 4.处理点击状态栏滚动
```Objective-C
// 处理点击状态栏滑动
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self selectRowAtIndexPath:0];
}
```

### 建议 & 支持
- - -
如有有什么问题请[联系我](http://www.jianshu.com/u/34e83a7106ae)
