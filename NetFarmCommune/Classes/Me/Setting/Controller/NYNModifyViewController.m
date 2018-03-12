//
//  NYNModifyViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/5.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNModifyViewController.h"
#import "NYNModifyTableViewCell.h"

@interface NYNModifyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *modifyPassWordTable;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *holdPlaces;

@end

@implementation NYNModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"修改密码";
    self.titles = @[@"原始密码",@"新密码",@"确认密码"];
    self.holdPlaces = @[@"请填写原始密码",@"请填写新密码",@"请在次输入新密码"];
    
    [self createmodifyPassWordTable];
}


- (void)createmodifyPassWordTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.modifyPassWordTable.delegate = self;
    self.modifyPassWordTable.dataSource = self;
    self.modifyPassWordTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.modifyPassWordTable.showsVerticalScrollIndicator = NO;
    self.modifyPassWordTable.showsHorizontalScrollIndicator = NO;
    self.modifyPassWordTable.scrollEnabled = NO;
    [self.view addSubview:self.modifyPassWordTable];
    
    UIButton *quedingButton = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - 50 - 64 , SCREENWIDTH, 50)];
    quedingButton.backgroundColor = Color90b659;
    [quedingButton setTitle:@"确定" forState:0];
    [quedingButton setTitleColor:[UIColor whiteColor] forState:0];
    [quedingButton addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quedingButton];

}

- (void)makeSure{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNModifyTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNModifyTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.titLabel.text = self.titles[indexPath.row];
    farmLiveTableViewCell.textField.placeholder = self.holdPlaces[indexPath.row];
    farmLiveTableViewCell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return farmLiveTableViewCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(46);
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
//    return headerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return section == 0 ?  0.0001 : 5;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
//    return footerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.0001;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            //            NYNSettingViewController *vc = [[NYNSettingViewController alloc]init];
            //            vc.hidesBottomBarWhenPushed = YES;
            //            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(UITableView *)modifyPassWordTable{
    if (!_modifyPassWordTable) {
        _modifyPassWordTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];;
    }
    return _modifyPassWordTable;
}
@end
