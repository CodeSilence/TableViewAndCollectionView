//
//  ViewController.m
//  TableViewAndCollectionView
//
//  Created by Devin on 2017/9/14.
//  Copyright © 2017年 Devin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Layout.h"
#import "HomeModel.h"
#import "HomeCookbookTableViewCell.h"
#import "HomeCookbookCollectionViewCell.h"
#import "HomeCookbookCollectionViewLayout.h"
#import <Masonry.h>


#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define KCollectionHeader @"KCollectionHeader"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UITableView *leftTableView;
@property(nonatomic,strong) UICollectionView *rightCollectionView;
@property(strong,nonatomic) NSArray *mainDatas;
// 记录滚动的方向,默认：YES,向下
@property(assign,nonatomic) BOOL isScrollDown;
@property(strong,nonatomic) HomeCookbookCollectionViewLayout *flowLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"食谱分类";
    [self initView];
    [self loadData];
}

- (void)initView {
    self.view.backgroundColor = UIColorFromRGBValue(0xfcfcfc);
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightCollectionView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _isScrollDown = YES;
    
    // 默认选中第一行
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    // 高度自适应
    self.leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.rightCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}

- (void)loadData {
    _mainDatas = [HomeModel shareHomewModel].homeCookbookPlistConvertModel.catalogShows;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,75, ScreenH)];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.showsHorizontalScrollIndicator = NO;
        [_leftTableView registerNib:[UINib nibWithNibName:@"HomeCookbookTableViewCell" bundle:nil] forCellReuseIdentifier:HomeCookbookTableInder];
        _leftTableView.tableFooterView = [[UIView alloc] init];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_leftTableView];
    }
    return _leftTableView;
}

- (UICollectionView *)rightCollectionView {
    if (!_rightCollectionView) {
        
        _flowLayout = [[HomeCookbookCollectionViewLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.itemSize = CGSizeMake((ScreenW - 75.5) * 0.5, (ScreenW - 75.5) * 0.5);
        _flowLayout.headerReferenceSize = CGSizeMake((ScreenW - 75.5), 30);
        _rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(75.5, 0, ScreenW - 75.5, ScreenH) collectionViewLayout:_flowLayout];
        
        _rightCollectionView.dataSource = self;
        _rightCollectionView.delegate = self;
        _rightCollectionView.showsVerticalScrollIndicator = NO;
        _rightCollectionView.backgroundColor = [UIColor whiteColor];
        [_rightCollectionView registerNib:[UINib nibWithNibName:@"HomeCookbookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:HomeCookbookCollectionInder];
        [_rightCollectionView registerClass:[UICollectionReusableView  class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:KCollectionHeader];
    }
    return _rightCollectionView;
}


#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mainDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCookbookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCookbookTableInder forIndexPath:indexPath];
    cell.dataModel = _mainDatas[indexPath.item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 点击cell，UITableView滚动到相应的row
    [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self scrollToTopOfSection:indexPath.row  animated:YES];
}

#pragma mark - 解决点击 TableView 后 CollectionView 的 Header 遮挡问题

- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
{
    // 获取CollectionView需要滚动的Section
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    // 获取Section对应CollectionView布局属性
    
    UICollectionViewLayoutAttributes *attributes = [self.rightCollectionView layoutAttributesForItemAtIndexPath:indexPath];
    
    // 设置CollectionView滚动位置
    
    [self.rightCollectionView setContentOffset:CGPointMake(0, attributes.frame.origin.y - self.rightCollectionView.contentInset.top) animated:YES];
}

- (CGRect)frameForHeaderForSection:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [self.rightCollectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect frameForFirstCell = attributes.frame;
    CGFloat headerHeight = _flowLayout.headerReferenceSize.height;
    return CGRectOffset(frameForFirstCell, 0, -headerHeight);
}


#pragma mark UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _mainDatas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    HomeCookbookCategoryModel *model = _mainDatas[section];
    return model.children.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCookbookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeCookbookCollectionInder forIndexPath:indexPath];
    HomeCookbookCategoryModel *model = _mainDatas[indexPath.section];
    cell.modelData = model.children[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:KCollectionHeader forIndexPath:indexPath];
    
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
    
    HomeCookbookCategoryModel *model = _mainDatas[indexPath.section];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGBValue(0xbfbfbf);
    [view addSubview:lineView];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = model.name;
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.textColor = UIColorFromRGBValue(0xbfbfbf);
    
    [view addSubview:titleLabel];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, view.height));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lineView.mas_centerY);
        make.left.equalTo(lineView.mas_right).mas_offset(10);
        make.width.greaterThanOrEqualTo(@10);
        make.height.mas_equalTo(13);
    }];
    
    view.backgroundColor = UIColorFromRGBValue(0xf8f8f8);
    return view;
}

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


// 获取CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static CGFloat lastOffsetY = 0;
    
    if (self.rightCollectionView == scrollView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

// 处理点击状态栏滑动
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self selectRowAtIndexPath:0];
}
@end
