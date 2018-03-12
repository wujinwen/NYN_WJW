//
//  NYNChooseBiaoShiPaiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChooseBiaoShiPaiViewController.h"
#import "NYNXuanBiaoShiPaiCollectionViewCell.h"
#import "NYNBiaoShiPaiModel.h"

@interface NYNChooseBiaoShiPaiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation NYNChooseBiaoShiPaiViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"选择标识牌";
    
    self.pageNo = 1;
    self.pageSize = 10;
    
    self.view.backgroundColor = RGB238;
    
    [self configCollectionView];
    self.collectionView.backgroundColor = RGB238;
    
;
    
//    [self showLoadingView:@""];
    
//    ;
    
    [self refreshData];
}

- (void)endRefresh{
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView.mj_header endRefreshing];
}

- (void)configCollectionView{
    
    // 注册collectionViewcell:WWCollectionViewCell是我自定义的cell的类型
    UINib *nib = [UINib nibWithNibName:@"NYNXuanBiaoShiPaiCollectionViewCell" bundle:[NSBundle mainBundle]];
//    [self.collectionView registerClass:nib forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"NYNXuanBiaoShiPaiCollectionViewCell"];
    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
    
}

- (void)refreshData{
    self.pageNo = 1;
    self.pageSize = 10;
    
    //@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize]
    NSDictionary *dic = @{@"farmId":self.farmID,@"type":self.type};
    
    [self showLoadingView:@""];
    
    [NYNNetTool GetBiaoShiWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            [self.dataArr removeAllObjects];
            for (NSDictionary *dic in success[@"data"]) {
                NYNBiaoShiPaiModel *model = [NYNBiaoShiPaiModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
        [self.collectionView reloadData];

        [self endRefresh];
        //        NYNBiaoShiPaiModel
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
        [self endRefresh];
        
        
    }];


}

- (void)moreData{
    self.pageNo = 1 + self.pageNo;
    self.pageSize = 10;
    NSDictionary *dic = @{@"farmId":self.farmID,@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize],@"type":self.type};
    
    [self showLoadingView:@""];
    
    [NYNNetTool GetBiaoShiWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            for (NSDictionary *dic in success[@"data"]) {
                NYNBiaoShiPaiModel *model = [NYNBiaoShiPaiModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self.collectionView reloadData];
        
        [self hideLoadingView];
        
        [self endRefresh];
        //        NYNBiaoShiPaiModel
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
        [self endRefresh];
        
        
    }];

}

-(UICollectionView *)collectionView{
    if (!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumInteritemSpacing = 5;// 水平方向的间距
        layout.minimumLineSpacing = 10; // 垂直方向的间距
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NYNXuanBiaoShiPaiCollectionViewCell *farmLiveTableViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NYNXuanBiaoShiPaiCollectionViewCell" forIndexPath:indexPath];
    
    NYNBiaoShiPaiModel *model = self.dataArr[indexPath.row];
    //后台返的是json数组，我也不晓得为啥，转json取第一张图
    NSData *jsonData = [model.images dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    
    
    [farmLiveTableViewCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:dic[0]] placeholderImage:PlaceImage];
    farmLiveTableViewCell.cellname.text = model.name;
    farmLiveTableViewCell.cellPeiceLabel.text = [NSString stringWithFormat:@"%@",model.price];
    
    return farmLiveTableViewCell;
}

/** 总共多少组*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/** 头部/底部*/
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"footer"   forIndexPath:indexPath];
//    view.backgroundColor = [UIColor redColor];
//    return view;
//
////    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
////        // 头部
////        UIView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"header"   forIndexPath:indexPath];
////        view.headerLabel.text = [NSString stringWithFormat:@"头部 - %zd",indexPath.section];
////        return view;
////
////    }else {
////        // 底部
////        WWCollectionFooterReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"footer"   forIndexPath:indexPath];
////        view.footerLabel.text = [NSString stringWithFormat:@"底部 - %zd",indexPath.section];
////        return view;
////    }
//}

#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JZWITH(112), JZHEIGHT(146));
}

///** 头部的尺寸*/
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//
//    return CGSizeMake(self.view.bounds.size.width, 10);
//}
//
///** 顶部的尺寸*/
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//
//
//    return CGSizeMake(self.view.bounds.size.width, 10);
//}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(JZWITH(10), JZWITH(10), JZWITH(10), JZWITH(10));
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
    NYNBiaoShiPaiModel *model = self.dataArr[indexPath.row];
    if (self.chooseBlock) {
        self.chooseBlock(model);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
//    NYNXuanZeZhongZiModel *model = self.chooseSeedDataArr[indexPath.row];
//    model.isChoose = !model.isChoose;
//    [self.collectionView reloadData];
    
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return  _dataArr;
}
@end
