//
//  HomeCookbookCollectionViewCell.m
//  TableViewAndCollectionView
//
//  Created by Devin on 2017/4/7.
//  Copyright © 2017年 Devin. All rights reserved.
//

#import "HomeCookbookCollectionViewCell.h"
#import "HomeCookbookModel.h"
#import <UIImageView+WebCache.h>

@interface HomeCookbookCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation HomeCookbookCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModelData:(HomeCookbookChildrenModel *)modelData {
    _modelData = modelData;
    [self.photoImgView sd_setImageWithURL:[NSURL URLWithString:modelData.imageUrl]];
    self.titleLabel.text = modelData.name;
}

@end
