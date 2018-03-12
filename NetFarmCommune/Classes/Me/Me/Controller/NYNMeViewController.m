//
//  NYNMeViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/5/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeViewController.h"
#import "FTUserInfoTableViewCell.h"
#import "FTMyDealTableViewCell.h"
#import "FTMyFarmTableViewCell.h"
#import "FTMeFunctionTableViewCell.h"
#import "FTMeFunctionButton.h"
#import "NYNMeDetailTableViewCell.h"
#import "NYNMeDealViewController.h"

#import "NYNMyPageViewController.h"
#import "NYNSettingViewController.h"
#import "NYNKeFuViewController.h"
#import "NYNMeMyFarmViewController.h"
#import "NYNMeMyWalletViewController.h"
#import "NYNMeCollectionViewController.h"
#import "NYNMeAdressViewController.h"
#import "NYNTouZiJiHuaViewController.h"
#import "NYNMeHelpViewController.h"
#import "FTLoginViewController.h"

#import "FTNavigationViewController.h"
#import "AllDealViewController.h"

#import "ShopCartViewController.h"

@interface NYNMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *meTable;
@property (nonatomic,strong) NSArray *picArr;
@property (nonatomic,strong) NSArray *titleArr;
@end

@implementation NYNMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self configData];
    [self setMeNav];
    [self createMeTable];
    
    ADD_NTF_OBJ(@"login", @selector(didLogIn), nil);
    ADD_NTF_OBJ(@"logout", @selector(didLogIn), nil);

}

- (void)didLogIn{
    [self.meTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)configData{
    self.picArr = @[@[@"mine_icon_farm",@"mine_icon_wallet",@"mine_icon_shoppingcart",@"mine_icon_collection",@"mine_icon_address"],@[@"mine_icon_investment",@"mine_icon_service",@"mine_icon_help",@"mine_icon_setup"]];
    self.titleArr = @[@[@"我的拍卖",@"我的钱包",@"购物车",@"我的收藏",@"收货地址"],@[@"投资合作",@"客服",@"帮助说明",@"设置"]];
}

- (void)setMeNav{
    self.title = @"我的";
    
    UIButton *saoyisaoBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(15), JZHEIGHT(15))];
    [saoyisaoBt addTarget:self action:@selector(scanCode) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *saoyisaoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, saoyisaoBt.width, saoyisaoBt.height)];
    saoyisaoImageView.image = [UIImage imageNamed:@"mine_icon_qr-code"];
    saoyisaoImageView.userInteractionEnabled = NO;
    [saoyisaoBt addSubview:saoyisaoImageView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saoyisaoBt];
}

- (void)createMeTable{
    self.meTable.delegate = self;
    self.meTable.dataSource = self;
    self.meTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.meTable.showsVerticalScrollIndicator = NO;
    self.meTable.showsHorizontalScrollIndicator = NO;
    
    self.meTable.scrollEnabled = YES;
    [self.view addSubview:self.meTable];
}


#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 5;
        }
            break;
        case 3:
        {
            return 4;
        }
            break;
        default:
        {
            return 1;
        }
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FTUserInfoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTUserInfoTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        UserInfoModel *jzUserModel = userInfoModel;
        farmLiveTableViewCell.userModel = jzUserModel;
        return farmLiveTableViewCell;
    }
    
    else if (indexPath.section == 1){
        //我的订单
        FTMyDealTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTMyDealTableViewCell class]) owner:self options:nil].firstObject;
        }
        //点击全部订单
        farmLiveTableViewCell.clickDealCell = ^(NSInteger i) {
            if (i == 0) {
                NYNMeDealViewController *vc = [[NYNMeDealViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.selectedIndex = i + 1;
                vc.weigth = 40;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if (i == 1){
                NYNMeDealViewController *vc = [[NYNMeDealViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.selectedIndex = i + 1;
                vc.weigth = 40;
               [self.navigationController pushViewController:vc animated:YES];
            }
            else if (i == 2){
                NYNMeDealViewController *vc = [[NYNMeDealViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.selectedIndex = i + 1;
                vc.weigth = 40;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if (i == 3){
                NYNMeDealViewController *vc = [[NYNMeDealViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.selectedIndex = i + 1;
                vc.weigth = 40;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                AllDealViewController *vc = [[AllDealViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
//                vc.selectedIndex = 0;
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        return farmLiveTableViewCell;
    }
    
    else if (indexPath.section == 2){
        
        NYNMeDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeDetailTableViewCell class]) owner:self options:nil].firstObject;
        }
        farmLiveTableViewCell.iconImageView.image = Imaged(self.picArr[0][indexPath.row]);
        farmLiveTableViewCell.contentLabel.text = self.titleArr[0][indexPath.row];
        return farmLiveTableViewCell;
    }

    else if (indexPath.section == 3){
        
        NYNMeDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeDetailTableViewCell class]) owner:self options:nil].firstObject;
        }
        farmLiveTableViewCell.iconImageView.image = Imaged(self.picArr[1][indexPath.row]);
        farmLiveTableViewCell.contentLabel.text = self.titleArr[1][indexPath.row];
        return farmLiveTableViewCell;
    }
    else{
        UITableViewCell *colletionViewTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"colletionViewTableViewCell"];
        if (colletionViewTableViewCell == nil) {
            colletionViewTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"colletionViewTableViewCell"];
        }
        for (UIView *subView in colletionViewTableViewCell.contentView.subviews) {
            [subView removeFromSuperview];
        }
        
        return colletionViewTableViewCell;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            
            return JZHEIGHT(71);
        }
            break;
        case 1:
        {
            return JZHEIGHT(116);
        }
            break;
        case 2:
        {
            return JZHEIGHT(45);
        }
            break;
        case 3:
        {
            return JZHEIGHT(45);
            
        }
            break;
            
        default:
        {
            return 10;
        }
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ?  0.0001 : 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfoModel *userMD = userInfoModel;
    if (!userMD.isLogin) {
        FTNavigationViewController *nav = [[FTNavigationViewController alloc]initWithRootViewController:[FTLoginViewController new]];;
        
        [self presentViewController:nav animated:YES completion:^{
            JZLog(@"请先登录");
        }];
        return;
    }
    
    
    if (indexPath.section == 0) {
        //个人主页
        NYNMyPageViewController *vc = [[NYNMyPageViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1) {
        
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                //我的农场
                NYNMeMyFarmViewController *vc = [[NYNMeMyFarmViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                //我的钱包
                NYNMeMyWalletViewController *vc = [NYNMeMyWalletViewController alloc];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                //购物车
                ShopCartViewController *vc = [ShopCartViewController alloc];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                //我的收藏
                NYNMeCollectionViewController *vc = [NYNMeCollectionViewController alloc];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                //收货地址
                NYNMeAdressViewController *vc = [[NYNMeAdressViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
            {
                //投资合作
                NYNTouZiJiHuaViewController *vc = [[NYNTouZiJiHuaViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                //客服
                NYNKeFuViewController *vc = [[NYNKeFuViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                //帮助说明
                NYNMeHelpViewController *vc = [[NYNMeHelpViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                //设置
                NYNSettingViewController *vc = [[NYNSettingViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;

            default:
                break;
        }
    }


}
#pragma 懒加载
-(UITableView *)meTable
{
    if (!_meTable) {
        _meTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 -50) style:UITableViewStyleGrouped];
    }
    return _meTable;
}

#pragma action
- (void)scanCode{
    JZLog(@"点击了扫描二维码");
}
@end
