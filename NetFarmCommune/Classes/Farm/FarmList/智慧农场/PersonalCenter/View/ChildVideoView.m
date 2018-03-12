//
//  ChildVideoView.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/1.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "ChildVideoView.h"
#import "SDCycleScrollView.h"
#import "PersonalCenterTopView.h"
#import "SDCollectionViewCell.h"
#import "NYNWisDomModel.h"
#import "UIView+SGFrame.h"

@interface ChildVideoView () <UITableViewDataSource, UITableViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) PersonalCenterTopView *topView;
@property (nonatomic,strong) SDCycleScrollView *bannerScrollView;
@property(nonatomic,strong)NSMutableArray * picArray;

@end


@implementation ChildVideoView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initiaInterface];
    }
    return self;
    
}

-(void)initiaInterface{
    [self addSubview:self.topView];
    
    self.backgroundColor = [UIColor whiteColor];
    _iamgeArr =[[NSMutableArray alloc]init];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
}

-(void)setIamgeArr:(NSMutableArray *)iamgeArr{
    _iamgeArr =iamgeArr;
    SDCycleScrollView *bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.topView.height) delegate:self placeholderImage:PlaceImage];
    bannerScrollView.imageURLStringsGroup = [NSArray arrayWithArray:_iamgeArr];
    self.bannerScrollView = bannerScrollView;
    bannerScrollView.delegate = self;
    [self.topView addSubview:bannerScrollView];
    
    UIView *starBackView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(106), JZHEIGHT(10), JZWITH(140), JZHEIGHT(25))];
    starBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
    starBackView.layer.cornerRadius = JZWITH(12.5);
    starBackView.layer.masksToBounds = YES;
    [self.topView addSubview:starBackView];
    
    UILabel *starLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(12.5), 0, JZWITH(22), JZHEIGHT(25))];
    starLabel.text = @"星级";
    starLabel.font = JZFont(11);
    starLabel.textColor = [UIColor whiteColor];
    [starBackView addSubview:starLabel];
    for (int i = 0; i < 5; i++) {
        UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(starLabel.right + JZWITH(5) + (JZWITH(10) + JZWITH(3)) * i, JZHEIGHT(8), JZWITH(10), JZHEIGHT(10))];
        starImageView.image = (i < _lightStarCount ?  Imaged(@"farm_icon_grade1") : Imaged(@"farm_icon_grade2")) ;
        [starBackView addSubview:starImageView];
    }
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
- (PersonalCenterTopView *)topView {
    if (!_topView) {
        _topView = [PersonalCenterTopView SG_loadViewFromXib];
        _topView.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(230));
    }
    return _topView;
}
@end
