//
//  YGProductGoodsListCell.m
//  mobile
//
//  Created by TreeWrite on 16/6/29.
//  Copyright © 2016年 1yyg. All rights reserved.
//

#import "YGProductGoodsListCell.h"

@interface YGProductGoodsListCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *progressBottomView;    //进度底部View
@property (weak, nonatomic) IBOutlet UIView *progressTopView;   //进度顶部View
@property (weak, nonatomic) IBOutlet UIImageView *cartImageView;    //购物车图标
@property (weak, nonatomic) IBOutlet UIButton *addShopingCartBtn;   //添加购物车按钮
@property (weak, nonatomic) IBOutlet UIImageView *bottomLineView;

@end

@implementation YGProductGoodsListCell

+ (CGSize)heightForCurrentView
{
    return CGSizeMake(SCREEN_WIDTH-(70), (100));
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH-(70), (100));
    
    self.nameLabel.font = [UIFont systemFontOfSize:12.f];
    self.priceLabel.font = [UIFont systemFontOfSize:12.f];
    
    self.leftImageView.frame = CGRectMake((10), (10), (80), (80));
    
    self.nameLabel.frame = CGRectMake(self.leftImageView.right+(12), self.leftImageView.top, self.width-self.leftImageView.right-(22), (self.nameLabel.height));
    self.nameLabel.numberOfLines = 2;
    
    self.priceLabel.frame = CGRectMake(self.nameLabel.left, self.nameLabel.bottom+(5), self.nameLabel.width, (self.priceLabel.height));
    self.priceLabel.numberOfLines = 1;
    
    self.progressBottomView.size = CGSizeMake(self.width-(20.f)-self.leftImageView.right, (5));
    self.progressBottomView.left = self.leftImageView.right+(10.f);
    self.progressBottomView.layer.masksToBounds = YES;
    self.progressBottomView.layer.cornerRadius = self.progressBottomView.height/2;
    
    self.progressTopView.frame = CGRectMake(0, 0, self.progressBottomView.width/2, self.progressBottomView.height);
    self.progressTopView.layer.masksToBounds = YES;
    self.progressTopView.layer.cornerRadius = self.progressBottomView.height/2;
    
    self.progressBottomView.backgroundColor = [UIColor grayColor];
    self.progressTopView.backgroundColor = [UIColor orangeColor];
    
    self.cartImageView.frame  = CGRectMake(self.width-(43), self.priceLabel.top, (35), (35));
    
    self.addShopingCartBtn.size = CGSizeMake(self.cartImageView.width+(10.f)*2, self.cartImageView.height+(10.f)*2);
    
    self.bottomLineView.frame = CGRectMake(self.leftImageView.left, self.height-1.f, self.width-self.leftImageView.left, 1.f);
    
    UIView *selectedBGView = [[UIView alloc] initWithFrame:self.bounds];
    selectedBGView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.1];
    self.selectedBackgroundView = selectedBGView;
    [self bringSubviewToFront:selectedBGView];
}

/**
 *  更新cell控件
 *
 *  @param dataDict 传入的参数
 */
- (void)updateCellViewWithData:(NSDictionary *)dataDict indexPathWith:(NSIndexPath *)indexPath
{
    
    
    self.leftImageView.image = [UIImage imageNamed:@""];
    
    NSString *nameString = [dataDict objectForKey:@"name"];
    
    self.nameLabel.text = nameString;
    [self.nameLabel sizeToFit];

    self.priceLabel.text = [NSString stringWithFormat:@"价值 : ￥%@", [dataDict objectForKey:@"price"]];
    [self.priceLabel sizeToFit];
    
    self.nameLabel.top = self.leftImageView.top;
    self.nameLabel.width = self.width-self.leftImageView.right-(22);
    
    self.cartImageView.bottom = self.leftImageView.bottom;
    self.cartImageView.right = self.width-(10);
    
    self.addShopingCartBtn.center = self.cartImageView.center;

    self.progressBottomView.width = self.width-self.leftImageView.right-(30.f)-self.cartImageView.width;
    self.progressBottomView.centerY = self.cartImageView.centerY;
    
    CGFloat heightSize = (self.progressBottomView.top-self.nameLabel.bottom-self.priceLabel.height)/2.f;
    
    self.priceLabel.top = self.nameLabel.bottom+heightSize;
    
    CGRect progressFrame = self.progressTopView.frame;
    CGFloat sd = arc4random_uniform(100);
    if ( sd > 0)
    {
        progressFrame.size.width = sd/100*CGRectGetWidth(self.progressBottomView.frame);
    }
    else
    {
        progressFrame.size.width = 0.f;
    }
    
    self.progressTopView.frame = progressFrame;
}

- (IBAction)addCartTouchCancel:(id)sender
{
    self.cartImageView.image = [UIImage imageNamed:@"search_shopping_cart"];
}

- (IBAction)addCartTouchUpInside:(id)sender
{
    self.cartImageView.image = [UIImage imageNamed:@"search_shopping_cart"];

}

- (IBAction)addCartTouchDown:(id)sender
{
    self.cartImageView.image = [UIImage imageNamed:@"search_shopping_cart_selected"];
}

- (IBAction)addCartTouchDragExit:(id)sender
{
    self.cartImageView.image = [UIImage imageNamed:@"search_shopping_cart"];
}

@end
