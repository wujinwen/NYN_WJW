//
//  NYNZuDiZhongZhiTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNZuDiZhongZhiTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *whoTF;
@property (weak, nonatomic) IBOutlet UITextField *forWhoTF;
@property (weak, nonatomic) IBOutlet UITextField *ZhiWuTF;
@property (weak, nonatomic) IBOutlet UILabel *iConTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *doLabel;

@end
