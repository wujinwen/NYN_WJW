//
//  NYNKeFuViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/5.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNKeFuViewController.h"
#import "NYNKeFuTableViewCell.h"

@interface NYNKeFuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *KeFuTable;
@property (nonatomic,strong) NSArray *contents;
@property (nonatomic,strong) NSArray *numns;

@end

@implementation NYNKeFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"设置";
    self.contents = @[@"客服电话",@"客服QQ"];
    self.numns = @[@"028-85572795",@"176140760"];

    [self createKeFuTable];
}


- (void)createKeFuTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.KeFuTable.delegate = self;
    self.KeFuTable.dataSource = self;
    self.KeFuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.KeFuTable.showsVerticalScrollIndicator = NO;
    self.KeFuTable.showsHorizontalScrollIndicator = NO;
    self.KeFuTable.scrollEnabled = NO;
    [self.view addSubview:self.KeFuTable];
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
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNKeFuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNKeFuTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.nameLabel.text = self.contents[indexPath.row];
    farmLiveTableViewCell.phoneNumLable.text = self.numns[indexPath.row];
    
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
            
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"02885572795"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

            
        }
            break;
        case 1:
        {

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
-(UITableView *)KeFuTable{
    if (!_KeFuTable) {
        _KeFuTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];;
    }
    return _KeFuTable;
}
@end
