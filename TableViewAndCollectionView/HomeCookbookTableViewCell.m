//
//  HomeCookbookTableViewCell.m
//  TableViewAndCollectionView
//
//  Created by Devin on 2017/4/6.
//  Copyright © 2017年 Devin. All rights reserved.
//

#import "HomeCookbookTableViewCell.h"
#import "HomeCookbookModel.h"
#import <UIImageView+WebCache.h>

@interface HomeCookbookTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation HomeCookbookTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.contentView.backgroundColor = selected ? UIColorFromRGBValue(0xff5c2d) : [UIColor whiteColor];
    self.nameLabel.textColor = selected ? [UIColor whiteColor] : UIColorFromRGBValue(0xbfbfbf);
    
    [self.photoImgView sd_setImageWithURL:[NSURL URLWithString: selected ? self.dataModel.imageClickUrl : self.dataModel.imageUrl]];
    
}
- (void)setDataModel:(HomeCookbookCategoryModel *)dataModel {
    _dataModel = dataModel;
    
    self.nameLabel.text = dataModel.name;
    
}

@end
