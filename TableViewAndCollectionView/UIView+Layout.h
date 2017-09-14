//
//  UIView+Layout.h
//  Devin丶
//
//  Created by eelly Devin 15/9/1.
//  Copyright (c) 2015年 Devin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)
/**
 *  上
 */
@property (assign, nonatomic) CGFloat    top;
/**
 *  下
 */
@property (assign, nonatomic) CGFloat    bottom;
/**
 *  左
 */
@property (assign, nonatomic) CGFloat    left;
/**
 *  右
 */
@property (assign, nonatomic) CGFloat    right;

@property (assign, nonatomic) CGFloat    x;
@property (assign, nonatomic) CGFloat    y;
@property (assign, nonatomic) CGPoint    origin;

/**
 *  中心点X坐标
 */
@property (assign, nonatomic) CGFloat    centerX;
/**
 *  中心点Y坐标
 */
@property (assign, nonatomic) CGFloat    centerY;

/**
 *  宽
 */
@property (assign, nonatomic) CGFloat    width;
/**
 *  高
 */
@property (assign, nonatomic) CGFloat    height;
/**
 *  尺寸
 */
@property (assign, nonatomic) CGSize    size;
@end
