//
//  YGProductSquareCell.m
//  mobile
//
//  Created by TreeWrite on 16/6/29.
//  Copyright © 2016年 1yyg. All rights reserved.
//

#import "YGProductSquareCell.h"

@interface YGProductSquareCell ()
{
    NSDictionary *_dic;
}

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@end

@implementation YGProductSquareCell

+ (CGFloat)heightForCurrentView
{
    return (80);
}

- (void)awakeFromNib
{

    [super awakeFromNib];
    // Initialization code
    
    self.frame = CGRectMake(0, 0, (48), (80));

    self.topImageView.frame = CGRectMake((self.width-(22))/2.f, (11), (20), (20));

    self.titleLabel.font = [UIFont systemFontOfSize:12.f];
    
    self.titleLabel.text = @"商品";
    [self.titleLabel sizeToFit];
    CGSize size = self.titleLabel.size;
    self.titleLabel.frame = CGRectMake(0, self.topImageView.bottom+(5), size.width, self.height-self.topImageView.bottom-(5)*2);
    self.titleLabel.centerX = self.centerX;
    
    self.bottomLineView.frame = CGRectMake(0, self.height-0.5f, self.width, 0.5f);
    self.rightView.frame = CGRectMake(self.width-0.5f, 0, 0.5f,self.height);
}

/**
 *  更新CELL
 *
 *  @param dataDict {@“image”:@"", @"title":@"", @"highlighted":@""}
 */
- (void)updateCellView:(NSDictionary *)dataDict
{
    _dic = dataDict;
    
    self.topImageView.image = [UIImage imageNamed:([dataDict objectForKey:@"image"])];
    
    self.titleLabel.text = ([dataDict objectForKey:@"title"]);
    [self.titleLabel sizeToFit];
    
    CGFloat height = (self.height-self.topImageView.height-self.titleLabel.height)/5.f;
    self.topImageView.top = height*2;
    
    self.titleLabel.centerX = self.centerX;
    self.titleLabel.top = self.topImageView.bottom+height;
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
        self.topImageView.image = [UIImage imageNamed:([_dic objectForKey:@"highlighted"])];
        self.titleLabel.textColor = [UIColor orangeColor];
        self.rightView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        self.topImageView.image = [UIImage imageNamed:([_dic objectForKey:@"image"])];
        self.titleLabel.textColor = [UIColor grayColor];
        self.rightView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
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
