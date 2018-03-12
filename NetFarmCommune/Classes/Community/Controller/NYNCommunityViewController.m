//
//  NYNCommunityViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/5/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNCommunityViewController.h"
#import "SGPageView.h"

#import "NYNGroupViewController.h"
#import "MessegeViewController.h"
#import "FriendViewController.h"
#import "NYNNetTool.h"
#import "SelectView.h"

#import "AddFriendVController.h"
#import "FindGrounpVController.h"
#import "CreatGroupVController.h"

@interface NYNCommunityViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;


@end

@implementation NYNCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.bakcView.hidden = NO;
    self.title = @"社区";
 
    
    
    [self setupView];
    
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"farm_icon_add_to"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
}


-(void)onClickedOKbtn{
    SelectView * selectView =[[NSBundle mainBundle]loadNibNamed:@"SelectView" owner:nil options:nil].lastObject;
    selectView.frame = CGRectMake(SCREENWIDTH-150-20, 0, 150, 100);

    selectView.yyblock = ^(NSInteger i) {
        if (i == 0) {
            AddFriendVController * addVC =[[AddFriendVController alloc]init];
            [self.navigationController pushViewController:addVC animated:YES];
        }else if (i==1){
            FindGrounpVController * findVC = [[FindGrounpVController alloc]init];
            [self.navigationController pushViewController:findVC animated:YES];
        }else if (i==2){
            CreatGroupVController * creatVC = [[CreatGroupVController alloc]init];
            [self.navigationController pushViewController:creatVC animated:YES];
            
            
        }
        
        
    };
    [self.view addSubview:selectView];
    
    
}



- (void)setupView {
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    MessegeViewController *twoVC = [[MessegeViewController alloc] init];

    NYNGroupViewController *oneVC = [[NYNGroupViewController alloc] init];
    FriendViewController *threeVC = [[FriendViewController alloc] init];
    
    NSArray *childArr = @[twoVC, threeVC, oneVC];
    /// pageContentView
    CGFloat contentViewHeight = SCREENHEIGHT - 64;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"消息", @"好友", @"群组"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44) delegate:self titleNames:titleArr];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isIndicatorScroll = NO;
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeSpecial;
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.isNeedBounces = NO;
    _pageTitleView.titleColorStateSelected = Color90b659;
    _pageTitleView.indicatorColor = Color90b659;
    _pageTitleView.titleColorStateNormal = Color686868;
    
}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


- (void)didReceiveMemoryWarning {
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

@end
