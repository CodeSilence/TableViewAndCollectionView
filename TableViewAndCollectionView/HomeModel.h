//
//  HomeModel.h
//  TableViewAndCollectionView
//
//  Created by Devin on 2017/9/14.
//  Copyright © 2017年 Devin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeCookbookModel.h"

@interface HomeModel : NSObject
+ (instancetype)shareHomewModel;

- (HomeCookbookModel *)homeCookbookPlistConvertModel;
@end
