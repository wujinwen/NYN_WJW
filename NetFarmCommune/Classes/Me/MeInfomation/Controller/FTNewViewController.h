//
//  NewViewController.h
//  通讯录
//
//  Created by Apple on 2017/1/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "BaseViewController.h"
#import "Contact.h"
#import "AddressPickerView.h"
typedef void(^SelectedRoomBlock)(NSString *roomName);

@interface FTNewViewController : BaseViewController<AddressPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (nonatomic, strong) Contact *newsContact;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UITextField *detailTf;
@property (nonatomic ,strong) AddressPickerView * pickerView;


@property (nonatomic, copy) SelectedRoomBlock selectedRoomBlock;

- (void)returnRoomName:(SelectedRoomBlock)block;
@end
