//
//  JZDatePickerView.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/28.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MakeClick)(NSDate *date);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数

typedef void(^CancleClick)(NSDate *date);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数

typedef void(^CellChooseClick)(NSDate *date,NSIndexPath* index);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数

@interface JZDatePickerView : UIView
@property (nonatomic,strong) UIDatePicker *datePickerView;
@property (nonatomic,strong) NSDate *nowDate;
@property (nonatomic,copy) MakeClick MakeClick;
@property (nonatomic,copy) MakeClick CancleClick;
@property (nonatomic,copy) CellChooseClick CellChooseClick;
@property (nonatomic,strong) NSIndexPath *index;

- (void)hidePickerView;
- (void)showPickerView;
@end
