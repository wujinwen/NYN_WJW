//
//  StopSpeakView.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "StopSpeakView.h"
#import "StopSpeakTVCell.h"
#import <Masonry/Masonry.h>

@interface StopSpeakView()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * dataArray;




@end


@implementation StopSpeakView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}

-(void)initiaInterface{

    UIColor * color = [UIColor blackColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.7];
//    [self getData];
    _dataArray = [NSMutableArray array];
    
   [self addSubview:self.tableView];
    
}

#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StopSpeakTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([StopSpeakTVCell class]) owner:self options:nil].firstObject;
        
    }
    
    
    return cell;
    
}

-(void)getData{
    //禁言列表
    NSDictionary * ns = @{@"chatroomId":_liveID};
    [NYNNetTool GetGaglistInfoWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
      
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//           [self.tableView reloadData];
            
            
            
        }else if ([NSString stringWithFormat:@"%@",success[@"401"]]){
        }
    } failure:^(NSError *failure){
        
        
    }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    headLabel.center = CGPointMake(SCREENWIDTH/2, 20);
    headLabel.textColor = [UIColor whiteColor];
    headLabel.font=[UIFont systemFontOfSize:15];
    headLabel.text=@"禁言列表";
    [view addSubview:headLabel];
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"home_icon_delete_2.png"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.width.height.mas_offset(25);
        make.top.mas_offset(5);
    }];
    
    
    
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
    
}
//删除按钮
-(void)deleteBtnClick:(UIButton*)sender{
    self.hidden = YES;
    
    
    
}

- (void)getDataWith:(NSString *)liveID {
    _liveID = liveID;
    [self getData];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,300)];
        _tableView.delegate=self;
        _tableView.dataSource  =self;
        _tableView.tableFooterView = [[UIView alloc]init];
        UIColor * color =   [UIColor blackColor];
        _tableView.rowHeight=60;
        
        _tableView.backgroundColor=[color colorWithAlphaComponent:0.7];
        
    }
    return _tableView;
    
    
}

@end
