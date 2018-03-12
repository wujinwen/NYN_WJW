//
//  NYNSettingViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/2.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNSettingViewController.h"
#import "NYNSettingTableViewCell.h"
#import "NYNModifyViewController.h"
#import "NYNAboutMeViewController.h"
#import "FTLoginViewController.h"
#import "FTNavigationViewController.h"
#import "NYNBangDingShouJiViewController.h"

//融云
#import "RCDLive.h"
#import "RCDLiveGiftMessage.h"

@interface NYNSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *setTable;
@property (nonatomic,strong) NSArray *contents;

@end

@implementation NYNSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.contents = @[@"关于我们",@"绑定手机",@"清空缓存",@"退出账号"];
//    ,@"修改密码"
    [self createsetTable];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.setTable reloadData];
    
}

- (void)createsetTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.setTable.delegate = self;
    self.setTable.dataSource = self;
    self.setTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.setTable.showsVerticalScrollIndicator = NO;
    self.setTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.setTable];
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNSettingTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNSettingTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.titLabel.text = self.contents[indexPath.row];
    if (indexPath.row == 4) {
        farmLiveTableViewCell.rowImageView.hidden = YES;
    }else if (indexPath.row ==1){
         farmLiveTableViewCell.phoneLabel.hidden = NO;
        UserInfoModel * model = userInfoModel;
        farmLiveTableViewCell.phoneLabel.text = model.phone;
        
    }
    
    return farmLiveTableViewCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(46);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            NYNAboutMeViewController *vc = [[NYNAboutMeViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            NYNBangDingShouJiViewController *vc = [[NYNBangDingShouJiViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
//        case 2:
//        {
//            NYNModifyViewController *vc = [[NYNModifyViewController alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
        case 2:
        {
            [self clearTmpPics];
        }
            break;
        case 3:
        {
            [self showTextProgressView:@"清空本地登录信息"];
            
            NSString *uid = JZFetchMyDefault(@"uuid");
            
            // 先将其转化为字典，然后用forin遍历删除即可
            NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];
            NSDictionary *dictionary = [defatluts dictionaryRepresentation];
            for(NSString *key in [dictionary allKeys]){
                //排除定位数据
                if (![key isEqualToString:SET_Location]) {
                    [defatluts removeObjectForKey:key];
                    [defatluts synchronize];
                }
                
            }
            
            
            
            JZSaveMyDefault(@"uuid", uid);
            [self hideLoadingView];
            
            POST_NTF(@"logout", nil);
//                //断开融云连接，如果你退出聊天室后还有融云的其他通讯功能操作，可以不用断开融云连接，否则断开连接后需要重新connectWithToken才能使用融云的功能
//               [[RCDLive sharedRCDLive]logoutRongCloud];
            
            FTNavigationViewController *nav = [[FTNavigationViewController alloc]initWithRootViewController:[FTLoginViewController new]];;
            
            [self presentViewController:nav animated:YES completion:^{

            }];
        }
            break;
            
        default:
            break;
    }

    
}

- (void)clearTmpPics

{
    [self showTextProgressView:@"清空缓存成功"];
    [[SDImageCache sharedImageCache] clearDisk];
    
    [[SDImageCache sharedImageCache] clearMemory];//可有可无
    [self hideLoadingView];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UITableView *)setTable{
    if (!_setTable) {
        _setTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];;
    }
    return _setTable;
}
@end
