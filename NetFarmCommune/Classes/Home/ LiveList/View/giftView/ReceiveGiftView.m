//
//  ReceiveGiftView.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "ReceiveGiftView.h"
#import "GiftTableViewCell.h"
#import "NYNLiveInfoModel.h"


@interface ReceiveGiftView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * allArray;



@end

@implementation ReceiveGiftView




-(instancetype)initWithFrame:(CGRect)frame liveId:(NSString*)liveId{
    self= [super initWithFrame:frame];
    if (self) {
        [self initiaInterface];
        _allArray = [NSMutableArray array];
        
            [self addSubview:self.tableView];
        
        NSDictionary * dic = @{@"liveId":liveId,@"pageNo":@"1",@"pageSize":@"10"};

        [NYNNetTool GetGiftListWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                
          for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
           NYNLiveInfoModel *model = [NYNLiveInfoModel mj_objectWithKeyValues:dic];
            [self.allArray addObject:model];
          }
                [self.tableView reloadData];
                
                
            }else{
                
            }
        } failure:^(NSError *failure) {
            
        }];
    }
    return self;
    
}





-(void)initiaInterface{
    self.backgroundColor = [UIColor blackColor];
    

    
}

#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_allArray.count>0) {
        return _allArray.count;
        
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GiftTableViewCell *giftCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (giftCell == nil) {
        giftCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GiftTableViewCell class]) owner:self options:nil].firstObject;
    }

    giftCell.infoModel = _allArray[indexPath.row];
    
    return giftCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    UILabel * gift = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    gift.center = CGPointMake(SCREENWIDTH/2, 25);
    gift.textColor = [UIColor blackColor];
    gift.text=@"我收到的礼物";
    gift.font = [UIFont systemFontOfSize:15];
    
    
    
    [headView addSubview:gift];
    
    UIButton * backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame = CGRectMake(SCREENWIDTH-50, 10, 30, 30);
    [backbtn setImage:[UIImage imageNamed:@"fork-@2x.png"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backBtn:)forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backbtn];
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
    
}

//返回
-(void)backBtn:(UIButton*)sender{
    if (self.backClick) {
        self.backClick(sender);
        
        
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,200)];
        _tableView.delegate=self;
        _tableView.dataSource  =self;
        _tableView.tableFooterView = [[UIView alloc]init];
  UIColor * color =   [UIColor blackColor];
        _tableView.backgroundColor=[color colorWithAlphaComponent:0.7];
        
    }
    return _tableView;
    
    
}

@end
