//
//  MYHomeTableViewCell.h
//  YuJia
//
//  Created by wylt_ios_1 on 2017/5/12.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIView *cardView;

- (void)addOtherCell;
@end
