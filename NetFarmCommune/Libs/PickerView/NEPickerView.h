//
//  NEPickerView.h
//  NetworkEngineer
//
//  Created by 123 on 2017/5/17.
//  Copyright © 2017年 com.NetworkEngineer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MakeClick)(UIButton * sender);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数

@interface NEPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong)UIPickerView * pickerView;//自定义pickerview
@property (nonatomic,strong)NSMutableArray * letter;//保存要展示的字母
@property (nonatomic,copy) NSString *pickerViewSelect;

@property (nonatomic,copy) MakeClick buttonAction;

@end
