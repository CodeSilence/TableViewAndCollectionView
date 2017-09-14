//
//  HomeCookbookCollectionViewCell.h
//  TableViewAndCollectionView
//
//  Created by Devin on 2017/4/7.
//  Copyright © 2017年 Devin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeCookbookChildrenModel;

static NSString * const HomeCookbookCollectionInder = @"HomeCookbookCollectionViewCell";

@interface HomeCookbookCollectionViewCell : UICollectionViewCell
@property(strong,nonatomic) HomeCookbookChildrenModel *modelData;
@end
