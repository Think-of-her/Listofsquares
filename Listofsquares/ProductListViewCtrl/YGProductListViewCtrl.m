//
//  ProductListViewCtrl.m
//  mobile
//
//  Created by xk on 14-11-18.
//  Copyright (c) 2014年 1yyg. All rights reserved.
//

#import "YGProductListViewCtrl.h"
#import "YGProductGoodsListViewCtrl.h"
#import "YGProductListCell.h"
#import "YGProductSquareCell.h"

@interface YGProductListViewCtrl () <UITableViewDelegate, UITableViewDataSource>
{
    UIButton *_rightNavBtn;
    NSInteger _rightSelected;   //0列表  1九宫格
    
    NSInteger _leftTableSelected; //左侧分类选中第几个  默认第一个
    
    YGProductGoodsListViewCtrl *_rightVC;
    
    NSMutableArray *_leftTypeArr;
}

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UIView *leftLineView;


@end

@implementation YGProductListViewCtrl

- (void)dealloc
{
    _leftTypeArr = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"所有商品";
    
    [self createData];
    
    [self updateView];
    
    [self setNavBarBarItem];
}

- (void)createData
{
    _rightSelected = 0;
    
    _leftTableSelected = 0;
    
    //读取数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"YGProductCategoryList" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    NSArray *smallArray = [arr subarrayWithRange:NSMakeRange(1, arr.count-1)];

    _leftTypeArr = [[NSMutableArray alloc] initWithCapacity:0];
    [_leftTypeArr addObjectsFromArray:arr];
    [_leftTypeArr addObjectsFromArray:smallArray];

}

- (void)updateView
{
    AdaptSetVCViewFrame(self.view)
    
    self.leftTableView.frame = CGRectMake(0, 0, (70), SCREEN_HEIGHT);
    self.leftTableView.separatorColor = [UIColor clearColor];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YGProductListCell class]) bundle:nil]  forCellReuseIdentifier:@"YGProductListCell"];
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YGProductSquareCell class]) bundle:nil]  forCellReuseIdentifier:@"YGProductSquareCell"];
    
    self.leftLineView.frame = CGRectMake(self.leftTableView.width-1, self.leftTableView.top, 0, self.leftTableView.height);
    
    _rightVC = [[YGProductGoodsListViewCtrl alloc] init];
    [self addChildViewController:_rightVC];
    [self.view addSubview:_rightVC.view];
}

- (void)setNavBarBarItem
{
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -20;
    
    _rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightNavBtn setImage:[UIImage imageNamed:@"product_right_list"] forState:UIControlStateNormal];
    [_rightNavBtn setImage:[UIImage imageNamed:@"product_right_list_highlight"] forState:UIControlStateHighlighted];
    _rightNavBtn.frame = CGRectMake(0, 0, 44, 44);
    [_rightNavBtn addTarget:self action:@selector(rightBtnTouchInside:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:_rightNavBtn]];


}

//右侧按钮响应
- (void)rightBtnTouchInside:(UIButton *)btn
{
    _rightSelected +=1;
    if (_rightSelected >= 2)
    {
        _rightSelected = 0;
    }
    
    [self updateTabelViewStyle];
    
    [_rightVC updateViewStyle:_rightSelected];
}

//右上角按钮点击更新界面
- (void)updateTabelViewStyle
{
    if (_rightSelected == 0)
    {
        //列表
        [_rightNavBtn setImage:[UIImage imageNamed:@"product_right_list"] forState:UIControlStateNormal];
        [_rightNavBtn setImage:[UIImage imageNamed:@"product_right_list_highlight"] forState:UIControlStateHighlighted];
        
        self.leftTableView.width = (70);
        self.leftLineView.left = self.leftTableView.width-0.5f;
    }
    else
    {
        //九宫格
        [_rightNavBtn setImage:[UIImage imageNamed:@"product_right_square"] forState:UIControlStateNormal];
        [_rightNavBtn setImage:[UIImage imageNamed:@"product_right_square_highlighte"] forState:UIControlStateHighlighted];
        
        self.leftTableView.width = (48);
        self.leftLineView.left = self.leftTableView.width-0.5f;
    }
    
    [self.leftTableView reloadData];
    [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_leftTableSelected inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDelegate、UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _leftTypeArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_rightSelected == 0)
    {
        return [YGProductListCell heightForCurrentView];
    }
    return [YGProductSquareCell heightForCurrentView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_rightSelected == 0)
    {
        YGProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGProductListCell"];
        [cell updateCellView:[_leftTypeArr objectAtIndex:indexPath.row]];
        return cell;
    }
    
    YGProductSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGProductSquareCell"];
    [cell updateCellView:[_leftTypeArr objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _leftTableSelected)
    {
        if (_rightSelected == 0)    //列表
        {
            YGProductListCell *listCell = (YGProductListCell *)cell;
            [listCell showCellSelected:YES];
        }
        else    //九宫格
        {
            YGProductSquareCell *listCell = (YGProductSquareCell *)cell;
            [listCell showCellSelected:YES];
        }
        cell.userInteractionEnabled = NO;
    }
    else
    {
        if (_rightSelected == 0)
        {
            YGProductListCell *listCell = (YGProductListCell *)cell;
            [listCell showCellSelected:NO];
        }
        else
        {
            YGProductSquareCell *listCell = (YGProductSquareCell *)cell;
            [listCell showCellSelected:NO];
        }
        cell.userInteractionEnabled = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableSelected == indexPath.row)
    {
        return;
    }
    _leftTableSelected = indexPath.row;
    
    [tableView reloadData];
}

@end
