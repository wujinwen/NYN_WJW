//
//  NEPickerView.m
//  NetworkEngineer
//
//  Created by 123 on 2017/5/17.
//  Copyright © 2017年 com.NetworkEngineer. All rights reserved.
//

#import "NEPickerView.h"

@implementation NEPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(100), JZHEIGHT(50))];
        [cancelButton setTitle:@"取消" forState:0];
        [cancelButton setTitleColor:SelectedColor forState:0];
        [cancelButton addTarget:self action:@selector(makeCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 0 - JZWITH(100), 0, JZWITH(100), JZHEIGHT(50))];
        [sureButton setTitle:@"确定" forState:0];
        [sureButton setTitleColor:SelectedColor forState:0];
        [sureButton addTarget:self action:@selector(makeSure:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureButton];
        
        self.letter = [[NSMutableArray alloc]initWithArray:@[@"网络优化",@"网络安全"]];
        // 初始化pickerView
        self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, cancelButton.bottom + JZHEIGHT(10), SCREENWIDTH, self.height - cancelButton.height - JZHEIGHT(10))];
        [self addSubview:self.pickerView];
        
        //指定数据源和委托
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;

    }
    return self;
}

- (void)makeCancel:(UIButton *)sender{
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(sender);
    }
}

- (void)makeSure:(UIButton *)sender{
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(sender);
    }
}



#pragma mark UIPickerView DataSource Method 数据源方法

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.letter.count;//根据数组的元素个数返回几行数据
            break;
            
        default:
            break;
    }
    
    return result;
}

#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.letter[row];
            break;
            
        default:
            break;
    }
    
    return title;
}

#pragma mark 给pickerview设置字体大小和颜色等
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //可以通过自定义label达到自定义pickerview展示数据的方式
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor whiteColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];//调用上一个委托方法，获得要展示的title
    pickerLabel.textAlignment = 1;
    return pickerLabel;
}
//选中某行后回调的方法，获得选中结果
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.pickerView)
    {
        self.pickerViewSelect = self.letter[row];
        NSLog(@"selected == %@",self.pickerViewSelect);
    }
    else
    {
        
    }
}


-(void)setLetter:(NSMutableArray *)letter{
    _letter = letter;
    [self.pickerView reloadAllComponents];
}
@end
