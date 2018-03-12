//
//  FTMeFunctionTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>
// 用typef宏定义来减少冗余代码
typedef void(^ButtonClick)(UIButton * sender);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数
@interface FTMeFunctionTableViewCell : UITableViewCell
//下一步就是声明属性了，注意block的声明属性修饰要用copy
@property (nonatomic,copy) ButtonClick buttonAction;
@end
