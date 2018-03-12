//
//  NYNJiaoShuiCiShuViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/30.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNJiaoShuiCiShuViewController.h"
#import "NYNDIYChooseHeaderView.h"
#import "NYNDIYChooseDetailTableViewCell.h"
#import "JZDatePickerView.h"

@interface NYNJiaoShuiCiShuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *listTable;

@property (nonatomic,assign) int count;

@property (nonatomic,copy) NSString *titleStr;



@property (nonatomic,strong) JZDatePickerView *pickerView;
@end

@implementation NYNJiaoShuiCiShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    if ([self.type isEqualToString:@"0"]) {
//        self.titleStr = @"浇水";
//    }else{
//        self.titleStr = @"施肥";
//
//    }
    
    self.titleStr = self.type;
    
    self.title = self.titleStr;
    
    self.count = 0;
    
    [self createlistTable];
    
    [self.view addSubview:self.pickerView];
    __weak typeof(self)weakSelf = self;
    self.pickerView.CellChooseClick = ^(NSDate *date, NSIndexPath *index) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        
        [formatter setDateFormat:@"YYYY-MM-dd"];
        
        //----------将nsdate按formatter格式转成nsstring
        
        NSString *currentTimeString = [formatter stringFromDate:date];
        
        [weakSelf.monthArr replaceObjectAtIndex:index.row withObject:currentTimeString];
        
        NSIndexPath *ss = [NSIndexPath indexPathForRow:index.row inSection:0];
        [weakSelf.listTable reloadRowsAtIndexPaths:@[ss] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    self.count = (int)self.monthArr.count;
    [self.listTable reloadData];
    
    
    UIButton *queDingButton = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - 64 - 50, SCREENWIDTH, 50)];
    [queDingButton setTitle:@"确定" forState:0];
    [queDingButton setTitleColor:[UIColor whiteColor] forState:0];
    queDingButton.titleLabel.font = JZFont(14);
    queDingButton.backgroundColor = Color90b659;
    [queDingButton addTarget:self action:@selector(queDing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queDingButton];
}

- (void)createlistTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    self.listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTable.showsVerticalScrollIndicator = NO;
    self.listTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.listTable];
    
    UIView *headerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(50))];
    headerBackView.backgroundColor = Colore3e3e3;
    
    NYNDIYChooseHeaderView *headerView = [[NYNDIYChooseHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(45))];
    headerView.titleLabel.text = [NSString stringWithFormat:@"%@次数",self.titleStr];
    __weak typeof(self)weakSelf = self;
    __weak typeof(headerView)weakHeaderView = headerView;

    headerView.ClickAction = ^(int ss, NSString *type) {
        weakSelf.count = (int)weakSelf.monthArr.count;
        
        if ([type isEqualToString:@"+"]) {
            NSString *str = [MyControl getCurrentDayTime];
            [weakSelf.monthArr addObject:str];
        }else{
            if (weakSelf.monthArr.count > 0) {
                [weakSelf.monthArr removeLastObject];
            }
        }
        weakHeaderView.countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.monthArr.count];

        [weakSelf.listTable reloadData];

        
    };
    headerView.countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.monthArr.count];
    [headerBackView addSubview:headerView];
    self.listTable.tableHeaderView = headerBackView;
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
    return self.monthArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNDIYChooseDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNDIYChooseDetailTableViewCell class]) owner:self options:nil].firstObject;
    }
    
    farmLiveTableViewCell.titleLabel.text = [NSString stringWithFormat:@"第%ld次%@日期",(long)indexPath.row + 1,self.titleStr];
    farmLiveTableViewCell.datelabel.text = self.monthArr[indexPath.row];
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(45);
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
    
    self.pickerView.index = indexPath;
    
    [self.pickerView showPickerView];
    
}

#pragma 懒加载
-(UITableView *)listTable
{
    if (!_listTable) {
        _listTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - 50) style:UITableViewStylePlain];
    }
    return _listTable;
}

-(NSMutableArray *)monthArr{
    if (!_monthArr) {
        _monthArr = [[NSMutableArray alloc]init];
    }
    return _monthArr;
}

- (JZDatePickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[JZDatePickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, JZHEIGHT(200))];
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _pickerView;
}


- (void)backToLast:(UIButton *)btn{

    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)queDing{
    
    NSMutableArray *rr = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.monthArr.count; i++) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:self.monthArr[i]];
        
        NSDictionary *dic = @{@"title":[NSString stringWithFormat:@"第%d次%@",i,[self.type isEqualToString:@"0"] ? (@"浇水"):(@"施肥")],@"executeDate":[MyControl timeToTimeCode:date]};
        
        [rr addObject:dic];
    }
    
    
    if (self.clickBack) {
        self.clickBack(self.monthArr,rr);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
