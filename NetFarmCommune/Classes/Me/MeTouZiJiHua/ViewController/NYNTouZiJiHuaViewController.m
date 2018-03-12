//
//  NYNTouZiJiHuaViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNTouZiJiHuaViewController.h"
#import "NYNTouZiChengHuTableViewCell.h"
#import "NYNXiangXiShuoMingTableViewCell.h"

@interface NYNTouZiJiHuaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *touziTable;
@end

@implementation NYNTouZiJiHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"投资机会";
    
    self.touziTable.delegate = self;
    self.touziTable.dataSource = self;
    self.touziTable.showsVerticalScrollIndicator = NO;
    self.touziTable.showsHorizontalScrollIndicator = YES;
    self.touziTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.touziTable];
    
    UIButton *tijiaoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - 64 - 46, SCREENWIDTH, 46)];
    tijiaoButton.backgroundColor = Color90b659;
    [tijiaoButton setTitle:@"提交" forState:0];
    [tijiaoButton setTitleColor:[UIColor whiteColor] forState:0];
    tijiaoButton.titleLabel.font = JZFont(14);
    [self.view addSubview:tijiaoButton];
    
    [tijiaoButton addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NYNTouZiChengHuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNTouZiChengHuTableViewCell class]) owner:self options:nil].firstObject;
        }
        if (indexPath.row == 0) {
            farmLiveTableViewCell.titleLB.text = @"您的称呼";
        }else{
            farmLiveTableViewCell.titleLB.text = @"联系方式";
        }
        return farmLiveTableViewCell;
    }else{
        NYNXiangXiShuoMingTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXiangXiShuoMingTableViewCell class]) owner:self options:nil].firstObject;
        }
        farmLiveTableViewCell.textV.placehoder = @"输入您的信息以及想法或建议";
        return farmLiveTableViewCell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return JZHEIGHT(46);
    }else{
        return 151;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return v;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(11))];
        return v;
    }else{
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(33))];
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, SCREENWIDTH - JZWITH(20), JZHEIGHT(33))];
        lb.text = @"如果您对我们的产品有合作意向，请联系我们吧！";
        lb.font = JZFont(12);
        lb.textColor = Color888888;
        [v addSubview:lb];
        return v;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     if (section == 0) {
         return JZHEIGHT(11);
     }else{
         return JZHEIGHT(33);
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)touziTable{
    if (!_touziTable) {
        _touziTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - 46) style:UITableViewStyleGrouped];
    }
    return  _touziTable;
}

- (void)tijiao{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
