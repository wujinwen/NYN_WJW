//
//  MonitorViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "MonitorViewController.h"
#import "NYNLiveListCollectionViewCell.h"
#import "NYNLiveListModel.h"
#import "MonitorLiveVC.h"



@interface MonitorViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *liveListCollectionView;
@property (nonatomic,strong) NSMutableArray *dataArr;



@end

@implementation MonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.liveListCollectionView];
    
    NSDictionary *dic = @{@"type":@"monitor",@"pageNo":@"1",@"pageSize":@"10",@"orderType":@"multiple"};
    
    [NYNNetTool PostLiveListWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNLiveListModel *model = [NYNLiveListModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            
            
            [self.liveListCollectionView reloadData];
        }else{
            
        }
        
        
        NSLog(@"");
    } failure:^(NSError *failure) {
        NSLog(@"");
    }];
    
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NYNLiveListModel *model = self.dataArr[indexPath.row];
    
    static NSString * CellIdentifier = @"cell";
    //在这里注册自定义的XIBcell否则会提示找不到标示符指定的cell
    UINib *nib = [UINib nibWithNibName:@"NYNLiveListCollectionViewCell" bundle:[NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
    NYNLiveListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:model.pimg]];
    cell.titleLabel.text = model.farmTitle;
    cell.cusetomLabel.text = model.popurlar;
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JZWITH(172), JZWITH(172));
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
        //  UserInfoModel * model = userInfoModel;
        //链接融云服务器
    
                NYNLiveListModel *model = self.dataArr[indexPath.row];
                //农场监控直播
                MonitorLiveVC * myMovieVC = [[MonitorLiveVC alloc]init];
                myMovieVC.liveId = model.ID ;
                myMovieVC.playUrl = model.rtmpPull;
                myMovieVC.contentURL =@"rtmp://rtmp.nongyinong.cn/live/3";
                myMovieVC.targetId =model.ID ;
                myMovieVC.farmString = [NSString stringWithFormat:@"监控直播>%@",model.farmTitle];
                myMovieVC.conversationType = ConversationType_CHATROOM;
                [self.navigationController pushViewController:myMovieVC animated:YES];

    
    
}
-(void)initliveChat{
   

}

-(UICollectionView *)liveListCollectionView{
    if (!_liveListCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(JZWITH(172), JZWITH(172))];//设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//设置其边界
        
        _liveListCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64-40-49-30)collectionViewLayout:flowLayout];
        _liveListCollectionView.dataSource = self;
        _liveListCollectionView.delegate = self;
        _liveListCollectionView.backgroundColor = [UIColor clearColor];
        [_liveListCollectionView registerClass:[NYNLiveListCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _liveListCollectionView;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

@end
