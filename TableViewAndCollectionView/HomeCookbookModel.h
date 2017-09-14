//
//  HomeCookbookModel.h
//  TableViewAndCollectionView
//
//  Created by Devin on 2017/4/6.
//  Copyright © 2017年 Devin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol HomeCookbookCategoryModel <NSObject>

@end
@protocol HomeCookbookChildrenModel <NSObject>

@end

@interface HomeCookbookChildrenModel : JSONModel
@property(copy,nonatomic) NSString *imageUrl;
@property(copy,nonatomic) NSString *name;

@end

@interface HomeCookbookCategoryModel : JSONModel
@property(copy,nonatomic) NSString *imageClickUrl;
@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSString *imageUrl;
@property(strong,nonatomic) NSArray<HomeCookbookChildrenModel> *children;
@end

@interface HomeCookbookModel : JSONModel
@property(strong,nonatomic) NSArray<HomeCookbookCategoryModel> *catalogShows;
@end
