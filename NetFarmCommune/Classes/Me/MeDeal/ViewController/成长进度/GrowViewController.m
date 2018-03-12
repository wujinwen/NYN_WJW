//
//  GrowViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/31.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "GrowViewController.h"
#import "RootsTableViewCell.h"

@interface GrowViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGSize _cellSize;
}

@property(nonatomic,strong)UITableView * tableview;

@property(nonatomic,strong)NSMutableArray * rootArray;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation GrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _rootArray = [[NSMutableArray alloc]init];
    _cellSize = CGSizeMake((SCREENWIDTH-80)/3, (SCREENWIDTH-80)/3);
    
    self.title=@"成长进度";
    
    [NYNNetTool SourceWithparams:_orderID isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if (success[@"data"] ==nil) {
            return ;
            
        }
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
         
      
//            _rootArray=success[@"data"][@"infos"];
            
//            _rootsVc.dataArray = _rootArray;
            
            
        }else{
             [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
          [self hideLoadingView];
    } failure:^(NSError *failure) {
         [self hideLoadingView];
    }];
}



#pragma mark-UITableViewDelegate,UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rootArray.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //NYNSuYuanTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    RootsTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"RootsTableViewCell"];
    if (!cell) {
        cell = [[RootsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RootsTableViewCell"];
        
    }
    if (_rootArray.count>0) {
        cell.farmLabel.text=_rootArray[indexPath.row][@"farmName"];
        cell.timeLabel.text = [MyControl timeWithTimeIntervalString:_rootArray[indexPath.row][@"createDate"]] ;
        [cell.headImageView sd_setImageWithURL:_rootArray[indexPath.row][@"imgUrl"] placeholderImage:[UIImage imageNamed:@"占位图"]];
        
        
        cell.peopleLabel.text = [NSString stringWithFormat:@"执行人:%@",_rootArray[indexPath.row][@"managerName"]];
        
        NSData *jsonData = [_rootArray[indexPath.row][@"imgs"] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        cell.size = _cellSize;
        cell.picArr = dic;
       _data = [dic mutableCopy];
        
    }
    

  
        
    return cell;
    
        

    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int rowheight = 110;
    
    NSArray * arr = self.data;
    if (arr.count < 1) {
        return rowheight;
    }else if (arr.count <= 3) {
        return rowheight + _cellSize.height;
    }else if (arr.count <= 6) {
        return rowheight + _cellSize.height*2+15;
    }else {
        return rowheight + _cellSize.height*3+15*2;
    }
}


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.tableFooterView = [[UIView alloc]init];
        
    }
    return _tableview;
    
}

@end
