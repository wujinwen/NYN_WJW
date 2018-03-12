//
//  MyLiveTwoTabCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/1.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "MyLiveTwoTabCell.h"
#import "MyLiveCollectionViewCell.h"

@interface MyLiveTwoTabCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionview;
@property(nonatomic,strong)NSArray * allArr;



@end

@implementation MyLiveTwoTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
   // [self.contentView addSubview:self.collectionview];
    _allArr = [NSMutableArray array];
    
    
}




-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    NSArray * arr=dic[@"incomeGift"];
    
    if (arr.count>0) {
        
        _allArr = dic[@"incomeGift"];
    }
    
    
   //  [self.collectionview reloadData];
    
    _moneyLabel.text = dic[@"income"];
    
    
    _peopleCountLabel.text = dic[@"fansCount"];
//    //是否体现
//    if ([dic[@"withdraw"] isEqualToString:@"1"]) {
//
//    }else{
//
//    }
//
    
    
    
}
//废纸篓
- (IBAction)rubbishBtn:(UIButton *)sender {
    
    
}

#pragma mark--UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _allArr.count;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"cell";
    //在这里注册自定义的XIBcell否则会提示找不到标示符指定的cell
    UINib *nib = [UINib nibWithNibName:@"MyLiveCollectionViewCell" bundle:[NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
    MyLiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
//    MyLiveCollectionViewCell *cell = (MyLiveCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:celll forIndexPath:indexPath];
    NSString * str =_allArr[indexPath.row][@"giftImg"];

    [cell.giftImage sd_setImageWithURL:[NSURL URLWithString:str]];
    cell.giftCount.text =[NSString stringWithFormat:@"x%@",_allArr[indexPath.row][@"count"]];
    
    
    
    return cell;
    

}

//头部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * headView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"" forIndexPath:indexPath];
    headView = [[UICollectionReusableView alloc] init];
    

    return headView;
    
}




//#pragma mark --UICollectionViewDelegateFlowLayout
////定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(SCREENWIDTH/4-30, JZWITH(45));
//}



-(UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionview.backgroundColor =  [UIColor redColor];
        
        //        [flowLayout setItemSize:CGSizeMake(JZWITH(172), JZWITH(172))];//设置cell的尺寸
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];//设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置其边界
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 80, SCREENWIDTH, SCREENHEIGHT/3-SCREENWIDTH/18)collectionViewLayout:flowLayout];
        flowLayout.itemSize = CGSizeMake(SCREENWIDTH/4, ( SCREENHEIGHT/3- SCREENHEIGHT/18)/2);
        _collectionview.dataSource = self;
        _collectionview.pagingEnabled = YES ;
        _collectionview.delegate = self;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.scrollEnabled =YES;
        _collectionview.backgroundColor = [UIColor clearColor];
        [_collectionview registerClass:[MyLiveCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionview;
    
}


@end
