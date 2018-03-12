//
//  GoodsTableVController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "GoodsTableVController.h"
#import "GoodsThreeTableViewCell.h"

@interface GoodsTableVController ()



@property(nonatomic,strong)NSArray * arr;



@end

@implementation GoodsTableVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr = @[@" 名称:",@" 种类:",@" 厂家:",@" 产地:",@" 包装:"];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _arr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        GoodsThreeTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsThreeTableViewCell"];
        if (!cell) {
            cell = [[GoodsThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodsThreeTableViewCell"];
            
        }
        
        cell.indexpath = [NSString stringWithFormat:@"%ld",(long)indexPath.row] ;
//        if (_dataArr.count>0) {
//            NYNMarketListModel *model = self.dataArr[0];
//            cell.model = model;
//        }
//
        cell.headLabel.text= _arr[indexPath.row];
    
             cell.model =_model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    return nil;
}

-(void)setModel:(NYNMarketListModel *)model{
    _model=model;
    [self.tableView reloadData];
    
    
    
}

@end
