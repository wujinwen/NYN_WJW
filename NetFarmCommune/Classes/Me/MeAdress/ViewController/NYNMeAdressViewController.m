//
//  NYNMeAdressViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeAdressViewController.h"
#import "NYNMeAddressTableViewCell.h"
#import "NYNAddAddressViewController.h"
#import "NYNModifyAddressViewController.h"

@interface NYNMeAdressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *walletTable;
@property (nonatomic,strong) NSMutableArray *addressArray;

@end

@implementation NYNMeAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    
    [self createTable];

    [NYNNetTool GetMyAddressWithparams:nil isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        JZLog(@"");
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            [self.addressArray removeAllObjects];

            NSArray *rr = [NSArray arrayWithArray:success[@"data"]];
            
            for (NSDictionary *dd in rr) {
                NYNMeAddressModel *model = [NYNMeAddressModel mj_objectWithKeyValues:dd];
                [self.addressArray addObject:model];
            }
            [self.walletTable reloadData];
            
        }
        
    } failure:^(NSError *failure) {
        
    }];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
    [NYNNetTool GetMyAddressWithparams:nil isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        JZLog(@"");
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            [self.addressArray removeAllObjects];
            NSArray *rr = [NSArray arrayWithArray:success[@"data"]];
            
            for (NSDictionary *dd in rr) {
                NYNMeAddressModel *model = [NYNMeAddressModel mj_objectWithKeyValues:dd];
                [self.addressArray addObject:model];
            }
            [self.walletTable reloadData];
            
        }
        
    } failure:^(NSError *failure) {
        
    }];
    
}


- (void)setNav{
    self.title = @"我的地址";
    
    UIButton *mingziButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(30), JZHEIGHT(14))];
    [mingziButton setTitle:@"添加" forState:0];
    [mingziButton setTitleColor:[UIColor whiteColor] forState:0];
    mingziButton.titleLabel.font = JZFont(14);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:mingziButton];
    self.navigationItem.rightBarButtonItem =  item;
    
    [mingziButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)createTable{
    
    [self.view addSubview:self.walletTable];
    self.walletTable.delegate = self;
    self.walletTable.dataSource = self;
    self.walletTable.showsVerticalScrollIndicator = NO;
    self.walletTable.showsHorizontalScrollIndicator = NO;
    self.walletTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.walletTable.backgroundColor = Coloreeeeee;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeAddressTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeAddressTableViewCell class]) owner:self options:nil].firstObject;
    }
    
    NYNMeAddressModel *model = self.addressArray[indexPath.row];
    farmLiveTableViewCell.model = model;
    farmLiveTableViewCell.indexPath = indexPath;
    __weak typeof(self)WeakSelf = self;
    farmLiveTableViewCell.click = ^(NSString *type, NSIndexPath *indexpath) {
        //0 默认  1 编辑  2 删除
        if ([type isEqualToString:@"0"]) {
            //根据模型来判断

        }
        if ([type isEqualToString:@"1"]) {
            NYNModifyAddressViewController *vc =[[NYNModifyAddressViewController alloc]init];
            
            vc.model = model;
            [WeakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        
        if ([type isEqualToString:@"2"]) {
            //根据模型来判断
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认删除该地址吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //TODO:
            }];
            [alert addAction:cancelAction];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
                
                [self showLoadingView:@""];
                [NYNNetTool DetelAddressWithparams:model.ID isTestLogin:YES progress:^(NSProgress *progress) {
                    
                } success:^(id success) {
                    
                    
                    
                    if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                        
                        [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                        
                        [self.addressArray removeObjectAtIndex:indexPath.row];
                        
                        [self.walletTable reloadData];
                    }else{
                        
                        [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                    }
                    [self hideLoadingView];
                    
                } failure:^(NSError *failure) {
                    [self hideLoadingView];
                }];

                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
        }
    };
    return farmLiveTableViewCell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(135);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.addressClickBlock) {
        NYNMeAddressModel *model = self.addressArray[indexPath.row];
        self.addressClickBlock(model);
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(UITableView *)walletTable{
    if (!_walletTable) {
        _walletTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    }
    return _walletTable;
}

- (void)add{
    JZLog(@"添加收货地址");
    
    NYNAddAddressViewController *vc = [[NYNAddAddressViewController alloc]init];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray *)addressArray{
    if (!_addressArray) {
        _addressArray = [[NSMutableArray alloc]init];
    }
    return _addressArray;
}
@end
