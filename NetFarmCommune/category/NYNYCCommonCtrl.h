//
//  NYNYCCommonCtrl.h
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNYCCommonCtrl : NSObject
//创建UILabel
+ (UILabel *)commonLableWithFrame:(CGRect)frame
                             text:(NSString *)text
                            color:(UIColor *)color
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment;

//创建UITextField
+ (UITextField *)commonTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                    color:(UIColor *)color
                                     font:(UIFont *)font
                          secureTextEntry:(BOOL)secureTextEntry
                                 delegate:(id)delegate;

//创建UITextView
+ (UITextView *)commonTextViewWithFrame:(CGRect)frame
                                   text:(NSString *)text
                                  color:(UIColor *)color
                                   font:(UIFont *)font
                          textAlignment:(NSTextAlignment)textAlignment;

//创建UIButton
+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                              color:(UIColor *)color
                               font:(UIFont *)font
                    backgroundImage:(UIImage *)backgroundImage
                             target:(id)target
                             action:(SEL)action;

//创建图片
+ (UIImageView*) commonImageViewWithFrame:(CGRect)frame
                                    image:(UIImage*)image;

//创建背景图片
+ (UIImage*) imageWithColor:(UIColor*)color;@end
