//
//  NYNYCCommonCtrl.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNYCCommonCtrl.h"

@implementation NYNYCCommonCtrl
//创建UILabel
+ (UILabel *)commonLableWithFrame:(CGRect)frame
                             text:(NSString *)text
                            color:(UIColor *)color
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

//创建UITextField
+ (UITextField *)commonTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                    color:(UIColor *)color
                                     font:(UIFont *)font
                          secureTextEntry:(BOOL)secureTextEntry
                                 delegate:(id)delegate
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.textColor = color;
    textField.font = font;
    textField.secureTextEntry = secureTextEntry;
    textField.delegate = delegate;
    
    return textField;
}

//创建UITextView
+ (UITextView *)commonTextViewWithFrame:(CGRect)frame
                                   text:(NSString *)text
                                  color:(UIColor *)color
                                   font:(UIFont *)font
                          textAlignment:(NSTextAlignment)textAlignment
{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.text = text;
    textView.textColor = color;
    textView.textAlignment = textAlignment;
    
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeLink;
    
    return textView;
}

//创建UIButton
+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                              color:(UIColor *)color
                               font:(UIFont *)font
                    backgroundImage:(UIImage *)backgroundImage
                             target:(id)target
                             action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

//创建图片
+ (UIImageView*) commonImageViewWithFrame:(CGRect)frame
                                    image:(UIImage*)image
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.contentMode = UIViewContentModeScaleToFill;
    imgView.image = image;
    
    return imgView;
}

//创建背景图片
+ (UIImage*) imageWithColor:(UIColor*)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
