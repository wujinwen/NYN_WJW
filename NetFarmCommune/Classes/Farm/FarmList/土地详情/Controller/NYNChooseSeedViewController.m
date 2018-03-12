//
//  NYNChooseSeedViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChooseSeedViewController.h"
#import "NYNChooseSeedCollectionViewCell.h"
#import "NYNMaiBaiCaiView.h"
#import "NYNXuanZeZhongZiModel.h"


@interface NYNChooseSeedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
//@property (nonatomic,strong) NSMutableArray *seedArr;

@property (nonatomic,strong) NYNMaiBaiCaiView *chooseV;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *zhouqiLabel;
@property (nonatomic,assign) int nowCount;
@end

@implementation NYNChooseSeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"选择种植作物";
//    for (int i = 0; i < 16; i++) {
//        NYNXuanZeZhongZiModel *model = [NYNXuanZeZhongZiModel new];
//        model.isChoose = NO;
//        [self.seedArr addObject:model];
//    }
    
    
    
    [self configCollectionView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.collectionView.bottom + JZHEIGHT(8), SCREENWIDTH, JZHEIGHT(92))];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, JZWITH(100), JZHEIGHT(46))];
    nameLabel.text = @"大白菜";
    nameLabel.font = JZFont(15);
    nameLabel.textColor = Color383938;
    self.nameLabel = nameLabel;
    [bottomView addSubview:nameLabel];
    
    UILabel *zhouqiLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - 10 - JZWITH(150), 0, JZWITH(150), nameLabel.height)];
    zhouqiLabel.textColor = Color383938;
    zhouqiLabel.font = JZFont(13);
    zhouqiLabel.text = @"成熟周期: 180天";
    zhouqiLabel.textAlignment = 2;
    self.zhouqiLabel = zhouqiLabel;
    [bottomView addSubview:zhouqiLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(46), SCREENWIDTH, 0.5)];
    lineView.backgroundColor = Colore3e3e3;
    [bottomView addSubview:lineView];
 

    NYNMaiBaiCaiView *chooseV = [[NYNMaiBaiCaiView alloc]initWithFrame:CGRectMake(0, lineView.bottom, SCREENWIDTH, JZHEIGHT(46))];
    __weak typeof(self)WeakSelf = self;
    
    self.chooseV = chooseV;
    
    chooseV.actionBlcok = ^(int nowCount) {
        WeakSelf.chooseV.nowCount = nowCount;
        
        WeakSelf.selectModel.selectCount = nowCount;
        
        
        NSString *str1 = [NSString stringWithFormat:@" %.2f元",[WeakSelf.selectModel.price floatValue] * nowCount];
        NSString *str2 = [NSString stringWithFormat:@"（%.2f/%@元）",[WeakSelf.selectModel.price floatValue],WeakSelf.selectModel.unitName];
        NSString *sss = [NSString stringWithFormat:@"%@%@",str1,str2];
        
        WeakSelf.chooseV.moneyLB.attributedText = [MyControl CreateNSAttributedString:sss thePartOneIndex:NSMakeRange(0, str1.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:15] andPartTwoIndex:NSMakeRange(str1.length, str2.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:12]];
        
        
    };
    
    [bottomView addSubview:chooseV];
    
    
    UIButton *makeSurebutton = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(46) - 64 , SCREENWIDTH, JZHEIGHT(46))];
    makeSurebutton.backgroundColor = [UIColor colorWithHexString:@"9ecc5b"];
    [makeSurebutton setTitle:@"确定" forState:0];
    [makeSurebutton setTitleColor:[UIColor whiteColor] forState:0];
    makeSurebutton.titleLabel.font = JZFont(14);
    [makeSurebutton addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeSurebutton];
    
    
    [self reloadCellData:self.selectModel];
    
}

- (void)configCollectionView{
    // 注册collectionViewcell:WWCollectionViewCell是我自定义的cell的类型
    [self.collectionView registerClass:[NYNChooseSeedCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];

}


-(UICollectionView *)collectionView{
    if (!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
         layout.minimumInteritemSpacing = 15;// 水平方向的间距
         layout.minimumLineSpacing = 10; // 垂直方向的间距
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(458)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}



#pragma mark -- UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.seedArr.count;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NYNChooseSeedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor redColor];
//    cell.backgroundColor = [UIColor yellowColor];
//    cell.topImageView.image = [UIImage imageNamed:@"1"];
//    cell.bottomLabel.text = [NSString stringWithFormat:@"%zd.png",indexPath.row];
//    cell.contentImageView.image = PlaceImage;;
    NYNXuanZeZhongZiModel *model = self.seedArr[indexPath.row];
    if (model.isChoose == YES) {
        cell.gouXuanImageView.hidden = NO;
        cell.contentLabel.textColor = [UIColor colorWithHexString:@"f07029"];
    }else{
        cell.gouXuanImageView.hidden = YES;
        cell.contentLabel.textColor = Color383938;
    }
    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:PlaceImage];
    cell.contentLabel.text = [NSString stringWithFormat:@"%@",model.name];
    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.pImg] placeholderImage:PlaceImage];
    
    
    return cell;
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
    return CGSizeMake(60, 90);
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
    return UIEdgeInsetsMake(5, 25, 5, 25);
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    for (NYNXuanZeZhongZiModel *model in self.seedArr) {
        model.isChoose = NO;
    }
    
    NYNXuanZeZhongZiModel *selectModel = self.seedArr[indexPath.row];
    selectModel.isChoose = YES;
    
    [self reloadCellData:selectModel];
}

-(NSMutableArray *)seedArr{
    if (!_seedArr) {
        _seedArr = [[NSMutableArray alloc]init];
    }
    return _seedArr;
}

- (void)queding{
    
    if (self.seedBack) {
        self.seedBack(self.selectModel);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)reloadCellData:(NYNXuanZeZhongZiModel *)selectModel{
    self.selectModel = selectModel;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",selectModel.name];
//    self.zhouqiLabel.text = [NSString stringWithFormat:@"%@: %@天",selectModel.productExtraValues[@"attribute"][@"name"],selectModel.productExtraValues[@"value"]];
//    if (selectModel.productExtraValues.count > 0) {
        self.zhouqiLabel.text = [NSString stringWithFormat:@"种植周期: %@天",selectModel.cycleTime];
        
//    }else{
//        self.zhouqiLabel.text = @"";
//        
//    }
    
    NSString *str1 = [NSString stringWithFormat:@"%.2f元",[self.selectModel.price floatValue] * self.selectModel.selectCount];
    NSString *str2 = [NSString stringWithFormat:@"（%.2f/%@元）",[self.selectModel.price floatValue],selectModel.unitName];
    NSString *sss = [NSString stringWithFormat:@"%@%@",str1,str2];
    
    self.chooseV.moneyLB.attributedText = [MyControl CreateNSAttributedString:sss thePartOneIndex:NSMakeRange(0, str1.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:15] andPartTwoIndex:NSMakeRange(str1.length, str2.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:12]];
    
    self.chooseV.countLabel.text = [NSString stringWithFormat:@"%d",selectModel.selectCount];
    self.chooseV.nowCount = selectModel.selectCount;
    
    [self.collectionView reloadData];
    
}
@end
