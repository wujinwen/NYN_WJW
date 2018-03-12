//
//  NYNHelpViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/5.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNHelpViewController.h"
#import "NYNHelpTableViewCell.h"

@interface NYNHelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *HelpTable;
@property (nonatomic,strong) NSArray *contents;
@property (nonatomic,strong) NSArray *numns;

@end

@implementation NYNHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"帮助说明";
    self.contents = @[@"1、农场如何加入平台？",@"2、哪里下载农场管理端？",@"3、平台收费？",@"4、怎么出售蔬菜？"];
    
    self.numns = @[@"答：这里是对该问题进行回答、说明，这里是对该问题进 行回答、说明，这里是对该问题进行回答、说明，这里是 对该问题进行回答、说明",@"答：这里是对该问题进行回答、说明，这里是对该问题进 行回答、说明，这里是对该问题进行回答、说明，这里是 对该问题进行回答、说明",@"答：这里是对该问题进行回答、说明，这里是对该问题进 行回答、说明，这里是对该问题进行回答、说明，这里是 对该问题进行回答、说明",@"答：这里是对该问题进行回答、说明，这里是对该问题进 行回答、说明，这里是对该问题进行回答、说明，这里是 对该问题进行回答、说明"];
    
    [self createHelpTable];
}


- (void)createHelpTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.HelpTable.delegate = self;
    self.HelpTable.dataSource = self;
    self.HelpTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.HelpTable.showsVerticalScrollIndicator = NO;
    self.HelpTable.showsHorizontalScrollIndicator = NO;
    self.HelpTable.scrollEnabled = NO;
    [self.view addSubview:self.HelpTable];
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
    NYNHelpTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNHelpTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.questionLabel.text = self.contents[indexPath.row];
//    farmLiveTableViewCell.phoneNumLable.text = self.numns[indexPath.row];
    
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
-(UITableView *)HelpTable{
    if (!_HelpTable) {
        _HelpTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];;
    }
    return _HelpTable;
}
@end
