//
//  UIImage+Radius.h
//  NIMEducationDemo
//
//  Created by peter on 2018/2/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Radius)

- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius;
- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius size:(CGSize)size;

@end
