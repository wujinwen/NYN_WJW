//
//  OJLCollectionViewCell.m
//  OJLLabelLayout
//
//  Created by oujinlong on 16/6/12.
//  Copyright © 2016年 oujinlong. All rights reserved.
//

#import "OJLCollectionViewCell.h"

@interface OJLCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation OJLCollectionViewCell

-(void)setTitle:(NSString *)title{
    self.label.text = title;
    self.label.layer.cornerRadius = 12;
    self.label.layer.masksToBounds = YES;
    
    self.backgroundColor = [UIColor whiteColor];
}

@end
