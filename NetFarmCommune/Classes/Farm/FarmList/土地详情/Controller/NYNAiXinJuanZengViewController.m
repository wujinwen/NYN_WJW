//
//  NYNAiXinJuanZengViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNAiXinJuanZengViewController.h"
#import "NYNAiJuanTableViewCell.h"

@interface NYNAiXinJuanZengViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UITableView *chooseChoosePayMethod;

@end

@implementation NYNAiXinJuanZengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"爱心捐赠";
    
    self.view.backgroundColor = Color888888;
    self.chooseChoosePayMethod.backgroundColor = Colorededed;
    //模拟数据
    self.dataArr = @[@"1",@"1",@"1",@"1",@"1",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
    
    [self createchooseChoosePayMethod];
}

- (void)createchooseChoosePayMethod{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.chooseChoosePayMethod.delegate = self;
    self.chooseChoosePayMethod.dataSource = self;
    self.chooseChoosePayMethod.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chooseChoosePayMethod.showsVerticalScrollIndicator = NO;
    self.chooseChoosePayMethod.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.chooseChoosePayMethod];
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
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        NYNAiJuanTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNAiJuanTableViewCell class]) owner:self options:nil].firstObject;
        }
        
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(158);
    
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
    

}


-(UITableView *)chooseChoosePayMethod{
    if (!_chooseChoosePayMethod) {
        _chooseChoosePayMethod = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    }
    return _chooseChoosePayMethod;
}


-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}


@end
