//
//  ChooseLandViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "ChooseLandViewController.h"
#import "ChooseLandTableViewCell.h"
#import <Masonry/Masonry.h>

@interface ChooseLandViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;


@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)UIButton * sureBtn;//确定







@end

@implementation ChooseLandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    [self.view addSubview:self.tableView];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    
    [self.view addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(50);
        
        
    }];
    
    
    
    
  
}

-(void)getTitle:(NSString *)titleStr type:(NSString *)type{
        self.title = titleStr;
    
    
   
    
    NSDictionary * dic =@{@"farmId":_farmID,@"type":type,@"pageNo":@"1",@"pageSize":@"10"};
    
    [NYNNetTool QueryPageParams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            for (NSDictionary *dic in success[@"data"]) {
                _selectModel = [NYNXuanZeZhongZiModel mj_objectWithKeyValues:dic];
                [self.dataArray addObject:_selectModel];
            }
            
            [self.tableView reloadData];
            
            
        }else{
            
        }
    } failure:^(NSError *failure) {
        
        
        
    }];
    
    
}
-(void)sureBtnClick:(UIButton*)sender{

    if (self.selectBlock) {
        self.selectBlock(_selectModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
}





#pragma mark--UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseLandTableViewCell * landell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (landell == nil) {
        landell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ChooseLandTableViewCell class]) owner:self options:nil].firstObject;
    }
     NYNXuanZeZhongZiModel *model = self.dataArray[indexPath.row];
    landell.model = model;
    
    


    
    return landell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    ChooseLandTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.selectBtn.hidden=NO;
    
    _selectModel =self.dataArray[indexPath.row];
    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseLandTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.selectBtn.hidden=YES;
 
    
}




-(UITableView *)tableView{
    if (!_tableView) {
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-60) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.rowHeight = 90;
        
        
    }
    return _tableView;
    
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _sureBtn.layer.borderColor =[UIColor blackColor].CGColor;
        _sureBtn.layer.borderWidth = 1;
        
    }
    return _sureBtn;
    
}

@end
