//
//  JZDatePickerView.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/28.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "JZDatePickerView.h"

@implementation JZDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(100), JZHEIGHT(50))];
        [cancelButton setTitle:@"取消" forState:0];
        [cancelButton setTitleColor:Color90b659 forState:0];
        [cancelButton addTarget:self action:@selector(makeCancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 0 - JZWITH(100), 0, JZWITH(100), JZHEIGHT(50))];
        [sureButton setTitle:@"确定" forState:0];
        [sureButton setTitleColor:Color90b659 forState:0];
        [sureButton addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureButton];
        
//        self.letter = [[NSMutableArray alloc]initWithArray:@[@"网络优化",@"网络安全"]];
        // 初始化pickerView
        self.datePickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, cancelButton.bottom + JZHEIGHT(10), SCREENWIDTH, self.height - cancelButton.height - JZHEIGHT(10))];
        self.datePickerView.datePickerMode = UIDatePickerModeDate;
        self.datePickerView.locale = [[NSLocale
                                       alloc]initWithLocaleIdentifier:@"zh_Hans_CN"];
         NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:8*60*60]; //中国的当前时间
        [self.datePickerView setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [self.datePickerView setMinimumDate:[NSDate date]];
        [self.datePickerView addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:self.datePickerView];
        
        //指定数据源和委托
//        self.datePickerView.delegate = self;
//        self.datePickerView.dataSource = self;
    }
    return self;
}


- (void)makeCancel{
    [self hidePickerView];
}

- (void)makeSure{
    self.nowDate = self.datePickerView.date;
    JZLog(@"%@",self.nowDate);
    [self hidePickerView];
    
    if (self.MakeClick) {
        self.MakeClick(self.nowDate);
    }
    
    if (self.CellChooseClick) {
        self.CellChooseClick(self.nowDate, self.index);
    }
}

- (void)chooseDate:(UIDatePicker *)pickerView{
    self.nowDate = self.datePickerView.date;
    JZLog(@"%@",self.nowDate);
}

- (void)hidePickerView{
    [UIView animateWithDuration:.5 animations:^{
        self.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, JZHEIGHT(350));
    }];
}

- (void)showPickerView{
    [UIView animateWithDuration:.5 animations:^{
        self.frame = CGRectMake(0, SCREENHEIGHT - JZHEIGHT(350), SCREENWIDTH, JZHEIGHT(350));
        
    }];
}
@end
