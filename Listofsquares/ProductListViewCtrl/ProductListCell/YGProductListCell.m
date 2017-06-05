//
//  YGProductListCell.m
//  mobile
//
//  Created by TreeWrite on 16/6/29.
//  Copyright © 2016年 1yyg. All rights reserved.
//

#import "YGProductListCell.h"

@interface YGProductListCell ()

@property (weak, nonatomic) IBOutlet UIView *leftLineView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@end

@implementation YGProductListCell

+ (CGFloat)heightForCurrentView
{
    return 45;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
        
    self.frame = CGRectMake(self.left, self.top, (70), 45);
    self.nameLabel.frame = self.bounds;
    self.nameLabel.font = [UIFont systemFontOfSize:12.f];

    self.leftLineView.frame = CGRectMake(0,(self.height-14)/2, 2,14);
    self.leftLineView.hidden = YES;
    self.rightView.frame = CGRectMake(self.width-0.5f, 0, 0.5f,self.height);
    self.bottomLineView.frame = CGRectMake(0, 45-0.5f, self.width, 0.5f);
}

/**
 *  更新CELL
 *
 *  @param dataDict {@“image”:@"", @"title":@"", @"highlighted":@""}
 */
- (void)updateCellView:(NSDictionary *)dataDict
{
    self.nameLabel.text = ([dataDict objectForKey:@"title"]);
}

/**
 *  cell是否选中
 *
 *  @param isSelected isSelected
 */
- (void)showCellSelected:(BOOL)isSelected
{
    if (isSelected)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textColor = [UIColor orangeColor];
        self.leftLineView.backgroundColor = [UIColor orangeColor];
        self.leftLineView.hidden = NO;
        self.rightView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        self.nameLabel.textColor = [UIColor grayColor];
        self.leftLineView.hidden = YES;
        self.rightView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        self.bottomLineView.hidden = YES;
        self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    }else {
        self.bottomLineView.hidden = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    
}


@end
