//
//  GoodsSectionTVCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/4.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "GoodsSectionTVCell.h"

#import "SDCycleScrollView.h"
#import <Masonry/Masonry.h>
@interface GoodsSectionTVCell()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *bannerScrollView;

@end



@implementation GoodsSectionTVCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}

-(void)initiaInterface{
    SDCycleScrollView *bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 180) delegate:self placeholderImage:PlaceImage];
    //    bannerScrollView.imageURLStringsGroup = [NSArray arrayWithArray:_iamgeArr];
    self.bannerScrollView = bannerScrollView;
    bannerScrollView.delegate = self;
    [self.contentView addSubview:bannerScrollView];
    
    
    UIView *starBackView = [[UIView alloc]init];//WithFrame:CGRectMake(SCREENWIDTH-100, JZHEIGHT(10), JZWITH(140), JZHEIGHT(25))];
    starBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
    starBackView.layer.cornerRadius = JZWITH(12.5);
    starBackView.layer.masksToBounds = YES;
    [self.contentView  addSubview:starBackView];
    
    [starBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(JZWITH(140));
        make.bottom.mas_offset(-10);
        make.right.mas_offset(JZWITH(140));
        make.height.mas_offset(JZHEIGHT(25));
        
    }];
    
    
    UILabel *starLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(12.5), 0, JZWITH(22), JZHEIGHT(25))];
    starLabel.text = @"星级";
    starLabel.font = JZFont(11);
    starLabel.textColor = [UIColor whiteColor];
    [starBackView addSubview:starLabel];
    for (int i = 0; i < 5; i++) {
        UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(starLabel.right + JZWITH(5) + (JZWITH(10) + JZWITH(3)) * i, JZHEIGHT(8), JZWITH(10), JZHEIGHT(10))];
       // starImageView.image = (i < _lightStarCount ?  Imaged(@"farm_icon_grade1") : Imaged(@"farm_icon_grade2")) ;
         starImageView.image =  Imaged(@"farm_icon_grade1") ;
        [starBackView addSubview:starImageView];
    }
}


-(void)setPicArr:(NSArray *)picArr{
    _picArr = picArr;
    for (int i = 0; i<picArr.count; i++) {
        NSData *jsonData = [picArr[i] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        self.bannerScrollView.imageURLStringsGroup = [NSArray arrayWithArray:dic];
    }

}

-(void)setModel:(NYNMarketListModel *)model{
    _model =model;
      NSData *jsonData = [model.images dataUsingEncoding:NSUTF8StringEncoding];
      NSError *err;
     NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    self.bannerScrollView.imageURLStringsGroup = [NSArray arrayWithArray:dic];
}

//点击录播图
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    //    JZLog(@"点击了轮播图%ld",(long)index);
    //    NYNWisDomModel * model =[[NYNWisDomModel alloc]init];
    //
    //    SDCollectionViewCell *cell = self.bannerScrollView.mainView.visibleCells.firstObject;
    //    //    [UICollectionView ]
    //    //    SDCollectionViewCell *cell = []
    //    NSMutableArray *muArr = [[NSMutableArray alloc]init];
    //    //    for (int i = 0; i < self.headerDataModel.images.count; i++) {
    //    //        NSDictionary *str = self.headerDataModel.images[i];
    //    //
    //    //        [muArr addObject:str[@"imgUrl"]];
    //    //    }
    //    [HUPhotoBrowser showFromImageView:cell.imageView withURLStrings:[NSArray arrayWithArray:muArr] atIndex:index];
}
@end
