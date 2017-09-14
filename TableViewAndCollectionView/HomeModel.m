//
//  HomeModel.m
//  TableViewAndCollectionView
//
//  Created by Devin on 2017/9/14.
//  Copyright © 2017年 Devin. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+ (instancetype)shareHomewModel {
    static HomeModel *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[HomeModel alloc] init];
    });
    return model;
}

- (HomeCookbookModel *)homeCookbookPlistConvertModel {
    HomeCookbookModel *model =  [[HomeCookbookModel alloc] initWithDictionary:[self plistConvertDict:@"CookbookDatas"] error:nil];
    
    return model;
}


- (NSDictionary *)plistConvertDict:(NSString *)plistName {
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    return dict;
}

@end
