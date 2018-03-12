//
//  FTJZSegumentView.h
//  FarmerTreasure
//
//  Created by 123 on 2017/5/3.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClick)(UISegmentedControl * sender);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数

@interface FTJZSegumentView : UIView
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (nonatomic,copy) ButtonClick buttonAction;

//设置标题
@property (nonatomic,strong) NSMutableArray *titleArr;
@end
