//
//  CImagePicker.h
//  BaseWebViewController
//
//  Created by peter on 2018/2/5.
//  Copyright © 2018年 Zerdoor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CImagePicker : NSObject<UIImagePickerControllerDelegate>

+(instancetype)imagePicker;

@property (nonatomic, strong) UIImagePickerController * imagePickerController;

/**
 打开相册/摄像头,
 
 @param alert 创建好UIAlertController后的回调,默认拍照和相册
 @param didChoose 已选择alert后准备加载imagePickerController的回调
 @param didFinish 结束
 @param didCancel 取消
 */
-(void)openGallery:(void(^)(UIAlertController * alertController))alert didChoose:(void(^)(void))didChoose didFinish:(void(^)(UIImage *img))didFinish didCancel:(void(^)(void))didCancel;




@end
