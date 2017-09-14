//
//  HomeCookbookTableViewCell.h
//  TableViewAndCollectionView
//
//  Created by Devin on 2017/4/6.
//  Copyright © 2017年 Devin. All rights reserved.
//

#import <UIKit/UIKit.h>
// 16进制颜色
#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@class HomeCookbookCategoryModel;

static NSString *const HomeCookbookTableInder = @"HomeCookbookTableInder";

@interface HomeCookbookTableViewCell : UITableViewCell
@property(strong,nonatomic) HomeCookbookCategoryModel *dataModel;
@end
