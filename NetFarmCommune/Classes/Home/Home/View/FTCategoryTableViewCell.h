//
//  FTCategoryTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTHomeButton.h"

typedef void(^ButtonClick)(FTHomeButton * sender);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数
@interface FTCategoryTableViewCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *picArr;
@property (nonatomic,strong) NSMutableArray *textArr;

//@property (nonatomic,strong) UIPageControl *pageController;
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,copy) ButtonClick buttonAction;

@property (nonatomic,strong) NSMutableArray *bannerDataArr;

@property(nonatomic,strong)FTHomeButton *btOne ;

-(void)getDataListArr:(NSMutableArray*)picArr textArray:(NSMutableArray *)textArray;


@end
