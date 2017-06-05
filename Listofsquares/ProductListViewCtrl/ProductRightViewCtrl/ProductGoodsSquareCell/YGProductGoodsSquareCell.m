//
//  YGProductGoodsSquareCell.m
//  mobile
//
//  Created by TreeWrite on 16/6/29.
//  Copyright © 2016年 1yyg. All rights reserved.
//

#import "YGProductGoodsSquareCell.h"

@interface YGProductGoodsSquareCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *progressBottomView;    //进度底部View
@property (weak, nonatomic) IBOutlet UIView *progressTopView;   //进度顶部View
@property (weak, nonatomic) IBOutlet UIButton *yunBtn;   //立即一元云购
@property (weak, nonatomic) IBOutlet UIImageView *cartImageView;    //购物车图标
@property (weak, nonatomic) IBOutlet UIButton *addShopingCartBtn;   //添加购物车按钮
@property (weak, nonatomic) IBOutlet UIImageView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIImageView *rightLineView;
@property (strong, nonatomic) UIView *clearView;//遮盖到图片和名称的上面view
//用于添加购物车动画
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@end

@implementation YGProductGoodsSquareCell

+ (CGSize)heightForCurrentView
{
    return CGSizeMake((SCREEN_WIDTH-(48))/2.0f, (200));
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    
    self.nameLabel.font = [UIFont systemFontOfSize:12.f];
    self.priceLabel.font = [UIFont systemFontOfSize:11.f];
    self.yunBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];

    self.frame = CGRectMake(0, 0, (SCREEN_WIDTH-(48))/2.0f, (200));
    
    self.topImageView.frame = CGRectMake((self.width-(90))/2, (10), (90), (90));
        
    self.nameLabel.frame = CGRectMake((10), self.topImageView.bottom+(8), self.width-(10)*2, (20));
    
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CGRectGetMaxY(self.nameLabel.frame))];
    [self addSubview:self.clearView];
    self.clearView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickViewJumpControlEvent)];
    self.userInteractionEnabled = YES;
    self.clearView.userInteractionEnabled = YES;
    [self.clearView addGestureRecognizer:tap];
    
    self.priceLabel.frame = CGRectMake(self.nameLabel.left, self.nameLabel.bottom+(10), self.nameLabel.width, (15));
    
    self.progressBottomView.frame = CGRectMake(self.nameLabel.left, self.priceLabel.bottom+(10), self.nameLabel.width, (5));
    self.progressBottomView.layer.masksToBounds = YES;
    self.progressBottomView.layer.cornerRadius = self.progressBottomView.height/2;
    
    self.progressTopView.frame = CGRectMake(0, 0, self.progressBottomView.width/2, self.progressBottomView.height);
    self.progressTopView.layer.masksToBounds = YES;
    self.progressTopView.layer.cornerRadius = self.progressBottomView.height/2;
    
    self.progressBottomView.backgroundColor = [UIColor grayColor];
    self.progressTopView.backgroundColor = [UIColor orangeColor];
    
    self.yunBtn.frame = CGRectMake((8), self.progressBottomView.bottom+(8), self.width-(25), self.height-self.progressBottomView.bottom-(8)-(8));
    self.yunBtn.width = self.width-self.yunBtn.height-(21);
    
    self.cartImageView.frame = CGRectMake(self.yunBtn.right+(6), self.yunBtn.top, (35.f), (35.f));
    
    self.bottomLineView.frame = CGRectMake(0, self.height-1.f, self.width, 1.f);
    self.rightLineView.frame = CGRectMake(self.width-1.f, 0, 1.f, self.height);
    
    self.addShopingCartBtn.size = self.cartImageView.size;

}

/**
 *  更新cell控件
 *
 *  @param dataDict 传入的参数
 */
- (void)updateCellViewWithData:(NSDictionary *)dataDict
{
    self.topImageView.image = [UIImage imageNamed:@""];

    NSString *nameString = [dataDict objectForKey:@"name"];
    
    self.nameLabel.text = nameString;
    [self.nameLabel sizeToFit];
    self.nameLabel.width = self.width-(20.f);
    
    self.priceLabel.text = [NSString stringWithFormat:@"价值 : ￥%@", [dataDict objectForKey:@"price"]];
    [self.priceLabel sizeToFit];
    self.priceLabel.width = self.nameLabel.width;

    CGFloat heightSize = (self.height-self.topImageView.bottom-self.nameLabel.height-self.priceLabel.height-self.progressBottomView.height-self.cartImageView.height)/5.f;
    
    self.nameLabel.top = self.topImageView.bottom+heightSize;
    self.priceLabel.top = self.nameLabel.bottom+heightSize;
    self.progressBottomView.top = self.priceLabel.bottom+heightSize;
    
    self.cartImageView.top = self.progressBottomView.bottom+heightSize;
    self.cartImageView.right = self.width-(10.f);
    self.addShopingCartBtn.center = self.cartImageView.center;
    
    self.yunBtn.size = CGSizeMake(self.width-self.nameLabel.left-self.cartImageView.width-(20.f), self.cartImageView.height-(5.f));
    self.yunBtn.left = self.nameLabel.left;
    self.yunBtn.centerY = self.cartImageView.centerY;
    self.yunBtn.layer.cornerRadius = CGRectGetHeight(self.yunBtn.frame)/2.f;
    self.yunBtn.layer.allowsEdgeAntialiasing = YES;
    self.yunBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.yunBtn.layer.borderWidth = (1.f);
    self.yunBtn.layer.masksToBounds = YES;

    
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

/**
 *  立即一元云购点击
 *
 */
- (IBAction)buyImmediatelyTouchUpInside:(id)sender
{

}

- (IBAction)buyImmediatelyTouchCancel:(id)sender
{
}

- (IBAction)buyImmediatelyTouchDown:(id)sender
{
}

- (IBAction)buyImmediatelyTouchDragExit:(id)sender
{
}


/**
 *  添加购物车点击
 */
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
/**
 *  点击图片名称跳转控制器事件
 */
- (void)clickViewJumpControlEvent
{

}
@end
