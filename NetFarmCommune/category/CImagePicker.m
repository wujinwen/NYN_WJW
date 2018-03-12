//
//  CImagePicker.m
//  BaseWebViewController
//
//  Created by peter on 2018/2/5.
//  Copyright © 2018年 Zerdoor. All rights reserved.
//

#import "CImagePicker.h"
#import <UIKit/UIKit.h>


@interface CImagePickerDelegateManager : NSObject<UIImagePickerControllerDelegate>

/**
 结束
 */
@property (nonatomic, copy) void(^didFinishPick)(UIImage *img);

/**
 取消
 */
@property (nonatomic, copy) void(^didCancelPick)(void);

@end

@implementation CImagePickerDelegateManager

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image;
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    } else {
        image = info[UIImagePickerControllerOriginalImage];
    }
    if (self.didFinishPick) {
        _didFinishPick(image);
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (self.didCancelPick) {
        _didCancelPick();
    }
}

@end

@interface CImagePicker ()

@property (nonatomic, strong) CImagePickerDelegateManager * delegateManager;

@end

@implementation CImagePicker
static CImagePicker * imagePicker;

+(instancetype)imagePicker {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imagePicker = [[CImagePicker alloc]init];
    });
    [imagePicker defaultImagePicker];
    return imagePicker;
}

-(void)dealloc {
//    DeLog(@"CImagePicker Dealloc");
}

-(CImagePickerDelegateManager *)delegateManager {
    if (!_delegateManager) {
        _delegateManager = [[CImagePickerDelegateManager alloc]init];
    }
    return _delegateManager;
}

-(UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc]init];
        _imagePickerController.delegate = (id)self.delegateManager;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}

- (void)defaultImagePicker {
    
}

- (void)openGallery:(void(^)(UIAlertController * alertController))alert didChoose:(void(^)(void))didChoose didFinish:(void (^)(UIImage *))didFinish didCancel:(void (^)(void))didCancel{
    
    self.delegateManager.didFinishPick = ^(UIImage *img) {
        if (img && didFinish) {
            didFinish(img);
        }
    };
    self.delegateManager.didCancelPick = ^{
        if (didCancel) {
            didCancel();
        }
    };
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        if (didChoose) {
            didChoose();
        }
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从手机相册选择" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (didChoose) {
            didChoose();
        }
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    if (alert) {
        alert(alertController);
    };
}

@end


