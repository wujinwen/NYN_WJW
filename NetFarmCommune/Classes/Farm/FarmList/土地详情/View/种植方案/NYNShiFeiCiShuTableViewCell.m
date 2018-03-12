//
//  NYNShiFeiCiShuTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNShiFeiCiShuTableViewCell.h"

@implementation NYNShiFeiCiShuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.count = 0;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.countTF.delegate = self;
    
//    [self.countTF addTarget:self  action:@selector(valueChanged)  forControlEvents:UIControlEventAllEditingEvents];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:textField];
    
//    [self.countTF addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingChanged];

    self.countTF.returnKeyType = UIReturnKeyDone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCount:(int)count{
    _count = count;
//    _countLabel.text = [NSString stringWithFormat:@"%d",count];
    _countTF.text = [NSString stringWithFormat:@"%d",count];
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    if (self.tfInputBlock) {
//        self.tfInputBlock([_countTF.text intValue]);
//    }
//    
//    return YES;
//}
//
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.tfInputBlock) {
        self.tfInputBlock([_countTF.text intValue]);
    }
}
//
//-(void)textFieldDidChange :(UITextField *)theTextField{
//    if (self.tfInputBlock) {
//        self.tfInputBlock([_countTF.text intValue]);
//    }}

//- (void)valueChanged{
////    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeValue" object:self.countTF];
//    if (self.tfInputBlock) {
//        self.tfInputBlock([_countTF.text intValue]);
//    }
//}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_countTF resignFirstResponder];
    return YES;
    
}

//-(void)changeValue:(NSNotification *)notification {
//    UITextField *textField = notification.object;
//    
//    self.priceLabel.text = textField.text;
//}

@end
