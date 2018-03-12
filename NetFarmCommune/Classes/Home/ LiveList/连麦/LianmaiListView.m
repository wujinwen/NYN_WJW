//
//  LianmaiListView.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "LianmaiListView.h"
#import "YJSegmentedControl.h"
#import "StopSpeakTVCell.h"
#import <Masonry/Masonry.h>

#import "NYNInfoView.h"

@interface LianmaiListView()<UITableViewDelegate,UITableViewDataSource>
{
}

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSString * liveID;
@property(nonatomic,strong)NSArray * allArray;

@property(nonatomic,strong)NYNInfoView * infoView;

@property(nonatomic,assign)BOOL isOnline;//在线观众还是连麦申请


@end

@implementation LianmaiListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self inintiaInterface];
        UIColor * color = [UIColor blackColor];
        self.backgroundColor = [color colorWithAlphaComponent:0.7];
        
        
    }
    return self;
    
}
-(void)inintiaInterface{
    _allArray = [[NSArray alloc]init];
    NSArray * navArr = [NSArray arrayWithObjects:@"在线观众",@"连麦申请", nil];
    YJSegmentedControl * segment3 = [YJSegmentedControl segmentedControlFrame:CGRectMake(0,0, SCREENWIDTH-60, 44) titleDataSource:navArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor whiteColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor whiteColor] buttonDownColor:[UIColor whiteColor] Delegate:self];
    UIColor * color =Color90b659;
    segment3.backgroundColor = [color colorWithAlphaComponent:0];
    [self addSubview:segment3];
    
//    [segment3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_offset(0);
//        make.height.mas_offset(300);
//
//    }];
    
    UIButton * deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:[UIImage imageNamed:@"home_icon_delete_2.png"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_offset(0);
        make.width.height.mas_offset(40);
        
    }];
    
    
    
    
    [self addSubview:self.tableView];
    
}

-(void)deleteBtnClick:(UIButton*)sender{
    self.hidden=YES;
    
    
}
#pragma mark -- 遵守代理 实现代理方法
- (void)segumentSelectionChange:(NSInteger)selection{
    //_isOnline yes为连麦申请，NO为在线观众

    if (selection == 0) {
        
        [self getOnlineData];

    }else if (selection == 1){
        _isOnline = YES;
        [self requestListData];
        
        
    }
    
}
//在线观众
-(void)getOnlineData{
    _isOnline = NO;

    NSDictionary * ns = @{@"chatroomId":_liveID,@"count":@"200",@"order":@"1"};
    [NYNNetTool GetChatRoomInfoWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
       
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
           
            self.allArray = [success[@"data"]mutableCopy];
            [self.tableView reloadData];
    
        }else if ([NSString stringWithFormat:@"%@",success[@"401"]]){
            
        }
    } failure:^(NSError *failure){
        
        
    }];
}

//连麦申请
-(void)requestListData{
    _isOnline = YES;
    NSDictionary * dic = @{@"token":userInfoModel.token};
    [NYNNetTool RequestLianmaiWithparams:dic  isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            self.allArray = [success[@"data"]mutableCopy];
            [self.tableView reloadData];
            
        }else if ([NSString stringWithFormat:@"%@",success[@"401"]]){
            
        }
    } failure:^(NSError *failure){
        
        
    }];
}


//
- (void)getDataWith:(NSString *)liveID{
    _liveID = liveID;
    [self getOnlineData];

}

#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StopSpeakTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([StopSpeakTVCell class]) owner:self options:nil].firstObject;
        
    }
    cell.headImage.layer.cornerRadius = 57/2;
    cell.headImage.clipsToBounds = YES;
    
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:self.allArray[indexPath.row][@"avatar"]] placeholderImage:[UIImage imageNamed:@"占位图"]];
    cell.nameLabel.text =self.allArray[indexPath.row][@"name"];
    
    //判断在线观众
//    if (_isOnline == NO) {
//        cell.jinyanButton.hidden = YES;
//        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:self.allArray[indexPath.row][@"fromUserAvatar"]] placeholderImage:[UIImage imageNamed:@"占位图"]];
//        cell.nameLabel.text =self.allArray[indexPath.row][@"fromUserName"];
//    }else{
//         cell.jinyanButton.hidden = NO;
//        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:self.allArray[indexPath.row][@"avatar"]] placeholderImage:[UIImage imageNamed:@"占位图"]];
//        cell.nameLabel.text =self.allArray[indexPath.row][@"name"];
//    }
    return cell;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   NSArray * arr =   [[NSBundle mainBundle] loadNibNamed:@"NYNInfoView" owner:self options:nil];
   _infoView = [arr lastObject];
    
//    _infoView = [[NYNInfoView alloc]init];
    _infoView.userArray = self.allArray[indexPath.row];
    _infoView.liveID =_liveID;
    [self addSubview:_infoView];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
    
    
    
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREENWIDTH,300-44)];
        _tableView.delegate=self;
        _tableView.dataSource  =self;
        _tableView.tableFooterView = [[UIView alloc]init];
        UIColor * color =   [UIColor blackColor];
        _tableView.rowHeight=60;
        _tableView.backgroundColor=[color colorWithAlphaComponent:0.5];
        
    }
    return _tableView;
    
    
}

@end
