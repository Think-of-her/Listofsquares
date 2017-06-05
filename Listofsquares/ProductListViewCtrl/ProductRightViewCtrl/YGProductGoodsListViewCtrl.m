//
//  YGProductGoodsListViewCtrl.m
//  MeiTuan
//
//  Created by TreeWrite on 16/6/28.
//  Copyright © 2016年 TreeWrite. All rights reserved.
//

#import "YGProductGoodsListViewCtrl.h"
#import "YGProductGoodsListCell.h"
#import "YGProductGoodsSquareCell.h"

typedef enum : NSInteger{
    Product_Category_NowAnnounced   = 0 ,//最新揭晓
    Product_Category_Popularity         ,//人气
    Product_Category_Now                ,//最新
    Product_Category_Price_Up           ,//由低到高
    Product_Category_Price_Down         ,//由高到低
}Product_Category_TypeSort;

@interface YGProductGoodsListViewCtrl () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger _priceBtnUpCount; //价格点击次数 默认0未点击 1选中价格由高到低  2选中价格由低到高
    
    NSMutableArray *_dataList;
    
    NSInteger _styleInt;    //0列表 1九宫格
    
    NSInteger _leftTypeID;  //左侧分类  默认0即全部商品
    NSInteger _topTypeID;    //头部小分类   默认10即最新揭晓
    
    
}

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIButton *announcedBtn; //即将揭晓
@property (weak, nonatomic) IBOutlet UIButton *popularityBtn;   //人气
@property (weak, nonatomic) IBOutlet UIButton *nowBtn;  //最新
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;    //价值
@property (weak, nonatomic) IBOutlet UIImageView *lineView;

@property (weak, nonatomic) IBOutlet UICollectionView *pCollectionView;

@end

@implementation YGProductGoodsListViewCtrl


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createData];
    [self createView];
    
    [self updateViewStyle:0];
    
}

- (void)createData
{
    _priceBtnUpCount = 0;
    _leftTypeID = 0;
    _topTypeID = Product_Category_NowAnnounced;
    _dataList = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:@"我们在大多数情况下" forKey:@"name"];
    [dic setObject:@"20.00" forKey:@"price"];
    for (NSInteger i = 0; i < 15; i++) {
        [_dataList addObject:dic];
    }
}

- (void)createView
{
    self.announcedBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    self.popularityBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    self.nowBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    self.priceBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    
    self.pCollectionView.delegate = self;
    self.pCollectionView.dataSource = self;
    [self.pCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YGProductGoodsListCell class]) bundle:nil]  forCellWithReuseIdentifier:@"YGProductGoodsListCell"];
    [self.pCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YGProductGoodsSquareCell class]) bundle:nil]  forCellWithReuseIdentifier:@"YGProductGoodsSquareCell"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.pCollectionView setCollectionViewLayout:layout animated:YES];
}

/**
 *  切换列表或九宫格
 *
 *  @param styleInt 0列表   1九宫格
 */
- (void)updateViewStyle:(NSInteger)styleInt
{
    
    NSArray *visibleCellIndex = [self.pCollectionView visibleCells];
    NSArray *sortedIndexPaths = [visibleCellIndex sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)[self.pCollectionView indexPathForCell:obj1];
        NSIndexPath *path2 = (NSIndexPath *)[self.pCollectionView indexPathForCell:obj2];
        if (path1.row < path2.row) {
            return NSOrderedAscending;
        }
        else
        {
            return NSOrderedDescending;
        }
    }];
    
    NSIndexPath *indexPath = nil;
    if (sortedIndexPaths.count > 0) {
        indexPath = [self.pCollectionView indexPathForCell:[sortedIndexPaths firstObject]];
    }
    
    CGSize size =[@"即将揭晓" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
    //计算控件文字的偏移量
    CGFloat x1 = size.width/4/3;
    _styleInt = styleInt;
    if (styleInt == 0)
    {
        self.view.frame = CGRectMake((70), yNavigationHeight, SCREEN_WIDTH-(70), SCREEN_HEIGHT-yNavigationHeight);
        
        self.titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 45);
        
        self.announcedBtn.frame = CGRectMake(0, 0, CGRectGetWidth(self.titleView.bounds)/4, CGRectGetHeight(self.titleView.bounds));
        
        self.popularityBtn.frame = CGRectMake(CGRectGetMaxX(self.announcedBtn.frame), 0, CGRectGetWidth(self.announcedBtn.bounds), CGRectGetHeight(self.announcedBtn.bounds));
        [self.popularityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,0 , 0.0, (NSInteger)-(x1)*2)];
        
        self.nowBtn.frame = CGRectMake(CGRectGetMaxX(self.popularityBtn.frame), 0, CGRectGetWidth(self.announcedBtn.bounds), CGRectGetHeight(self.announcedBtn.bounds));
        [self.nowBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,0 , 0.0, (NSInteger)-(x1))];
        
        self.priceBtn.frame = CGRectMake(CGRectGetMaxX(self.nowBtn.frame), 0, CGRectGetWidth(self.announcedBtn.bounds), CGRectGetHeight(self.announcedBtn.bounds));
        
        self.lineView.frame = CGRectMake((10.f), self.titleView.height-1.f, self.titleView.width, 1.f);
        
        self.pCollectionView.frame = CGRectMake(0, CGRectGetHeight(self.titleView.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-CGRectGetMaxY(self.titleView.frame));
    }
    else
    {
        self.view.frame = CGRectMake((48), yNavigationHeight, SCREEN_WIDTH-(48), SCREEN_HEIGHT-yNavigationHeight);
        
        self.titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame),45);
        
        self.announcedBtn.frame = CGRectMake(0, 0, CGRectGetWidth(self.titleView.bounds)/4, CGRectGetHeight(self.titleView.bounds));
        
        self.popularityBtn.frame = CGRectMake(CGRectGetMaxX(self.announcedBtn.frame), 0, CGRectGetWidth(self.announcedBtn.bounds), CGRectGetHeight(self.announcedBtn.bounds));
        [self.popularityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,0 , 0.0, (NSInteger)-(x1)*2)];
        
        self.nowBtn.frame = CGRectMake(CGRectGetMaxX(self.popularityBtn.frame), 0, CGRectGetWidth(self.announcedBtn.bounds), CGRectGetHeight(self.announcedBtn.bounds));
        [self.nowBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,0 , 0.0, (NSInteger)-(x1))];
        
        self.priceBtn.frame = CGRectMake(CGRectGetMaxX(self.nowBtn.frame), 0, CGRectGetWidth(self.announcedBtn.bounds), CGRectGetHeight(self.announcedBtn.bounds));
        
        self.lineView.frame = CGRectMake((10.f), self.titleView.height-0.5f, self.titleView.width, 0.5f);
        
        self.pCollectionView.frame = CGRectMake(0, CGRectGetHeight(self.titleView.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-CGRectGetMaxY(self.titleView.frame));
    }
    
    [self updateBtn];
    
    [self.pCollectionView reloadData];

    if (indexPath) {
        [self.pCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }
}

//选择分类或者即将揭晓后更新UIBUTTON(文字居左图片居右)
- (void)updateBtn
{
    [self.priceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.priceBtn.imageView.image.size.width-5, 0, self.priceBtn.imageView.image.size.width)];
    [self.priceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.priceBtn.titleLabel.bounds.size.width+5, 0, -self.priceBtn.titleLabel.bounds.size.width)];
}

/**
 *  网络请求
 *
 *  @param typeID 分类ID
 */
- (void)requestListWithType:(NSInteger)typeID
{
    _leftTypeID = typeID;
    [self.pCollectionView setContentOffset:CGPointMake(0, 0) animated:NO];
}

/**
 *  网络请求
 *
 *  @param typeID 分类ID
 *  @param sortID  小的分类ID
 */
- (void)requestListWithType:(NSInteger)typeID sortWith:(NSInteger)sortID
{
    _leftTypeID = typeID;
    _topTypeID = sortID;
    
    switch (sortID) {
        case Product_Category_NowAnnounced: //即将揭晓
        {
            [self announcedBtnTouchUpInside:self.announcedBtn];
        }
            break;
        case Product_Category_Popularity: //人气
        {
            [self popularityBtnTouchUpInside:self.popularityBtn];
        }
            break;
        case Product_Category_Now: //最新
        {
            [self nowBtnTouchUpInside:self.nowBtn];
        }
            break;
        case Product_Category_Price_Up: //由低到高
        {
            _priceBtnUpCount = 2;
            [self priceBtnTouchUpInside:self.priceBtn];
        }
            break;
        case Product_Category_Price_Down: //由高到低
        {
            _priceBtnUpCount = 1;
            [self priceBtnTouchUpInside:self.priceBtn];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark -
#pragma mark - 排序按钮响应
//最新揭晓响应
- (IBAction)announcedBtnTouchUpInside:(UIButton *)sender
{
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
    self.popularityBtn.selected = NO;
    self.popularityBtn.userInteractionEnabled = YES;
    
    self.nowBtn.selected = NO;
    self.nowBtn.userInteractionEnabled = YES;
    
    self.priceBtn.selected = NO;
    self.priceBtn.userInteractionEnabled = YES;
    _priceBtnUpCount = 0;
    
    _topTypeID = Product_Category_NowAnnounced;
    
    [self.pCollectionView setContentOffset:CGPointMake(0, 0) animated:NO];
}

//人气响应
- (IBAction)popularityBtnTouchUpInside:(UIButton *)sender
{
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
    self.announcedBtn.selected = NO;
    self.announcedBtn.userInteractionEnabled = YES;
    
    self.nowBtn.selected = NO;
    self.nowBtn.userInteractionEnabled = YES;
    
    self.priceBtn.selected = NO;
    self.priceBtn.userInteractionEnabled = YES;
    _priceBtnUpCount = 0;
    
    _topTypeID = Product_Category_Popularity;
    
    [self.pCollectionView setContentOffset:CGPointMake(0, 0) animated:NO];
}

//最新响应
- (IBAction)nowBtnTouchUpInside:(UIButton *)sender
{
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
    self.announcedBtn.selected = NO;
    self.announcedBtn.userInteractionEnabled = YES;
    
    self.popularityBtn.selected = NO;
    self.popularityBtn.userInteractionEnabled = YES;
    
    self.priceBtn.selected = NO;
    self.priceBtn.userInteractionEnabled = YES;
    _priceBtnUpCount = 0;
    
    _topTypeID = Product_Category_Now;
    
    [self.pCollectionView setContentOffset:CGPointMake(0, 0) animated:NO];
}

//价格响应
- (IBAction)priceBtnTouchUpInside:(UIButton *)sender
{
    sender.selected = YES;
    
    if (_priceBtnUpCount == 2)
    {
        //由高到低
        [sender setImage:[UIImage imageNamed:@"product_price_normal_down"] forState:UIControlStateSelected];
        _priceBtnUpCount = 1;
        
        _topTypeID = Product_Category_Price_Up;
    }
    else
    {
        //由低到高
        [sender setImage:[UIImage imageNamed:@"product_price_normal_up"] forState:UIControlStateSelected];
        _priceBtnUpCount = 2;
        
        _topTypeID = Product_Category_Price_Down;
    }
    
    [self updateBtn];
    
    self.announcedBtn.selected = NO;
    self.announcedBtn.userInteractionEnabled = YES;
    
    self.popularityBtn.selected = NO;
    self.popularityBtn.userInteractionEnabled = YES;
    
    self.nowBtn.selected = NO;
    self.nowBtn.userInteractionEnabled = YES;
    
    [self.pCollectionView setContentOffset:CGPointMake(0, 0) animated:NO];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataList.count;
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_styleInt == 0)
    {
        return [YGProductGoodsListCell heightForCurrentView];
    }
    return [YGProductGoodsSquareCell heightForCurrentView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *model = [_dataList objectAtIndex:indexPath.row];
    
    if (_styleInt == 0)
    {
        YGProductGoodsListCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGProductGoodsListCell" forIndexPath:indexPath];
        [cell updateCellViewWithData:model indexPathWith:indexPath];
        return cell;
    }
    
    YGProductGoodsSquareCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGProductGoodsSquareCell" forIndexPath:indexPath];
    [cell updateCellViewWithData:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
