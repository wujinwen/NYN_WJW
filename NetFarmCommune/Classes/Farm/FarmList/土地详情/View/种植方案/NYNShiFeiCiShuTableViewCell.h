//
//  NYNShiFeiCiShuTableViewCell.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TFBlock)(int count);

@interface NYNShiFeiCiShuTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *daweiLabel;
@property (weak, nonatomic) IBOutlet UITextField *countTF;

@property (nonatomic,copy) TFBlock tfInputBlock;
@property (nonatomic,assign) int count;
@end
