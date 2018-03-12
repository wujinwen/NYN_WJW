//
//  FTJZSegumentView.m
//  FarmerTreasure
//
//  Created by 123 on 2017/5/3.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTJZSegumentView.h"

@implementation FTJZSegumentView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit{
//    int num = (int)self.segmentedControl.numberOfSegments;
    [self.segmentedControl setTitle:@"省心方案" forSegmentAtIndex:0];
    [self.segmentedControl setTitle:@"自定义方案" forSegmentAtIndex:1];
    [self.segmentedControl setBackgroundImage:PlaceImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    self.segmentedControl.tintColor = Color9ecc5b;
    self.segmentedControl.selectedSegmentIndex = 0;
    //设置普通状态下(未选中)状态下的文字颜色和字体
    [self.segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName: Color383938} forState:UIControlStateNormal];
    //设置选中状态下的文字颜色和字体
    [self.segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    //添加监听
    [self.segmentedControl addTarget:self action:@selector(sementedControlClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segmentedControl];
    self.segmentedControl.center = self.center;
    
    self.segmentedControl.userInteractionEnabled = YES;
    self.userInteractionEnabled= YES;
}


-(UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"省心方案",@"自定义方案"]];
    }
    return _segmentedControl;
}

//监听方法
- (void)sementedControlClick:(UISegmentedControl *)segmentedControl{
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(segmentedControl);
    }
}

-(NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [[NSMutableArray alloc]init];
    }
    return _titleArr;
}


@end
