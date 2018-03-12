//
//  NYNAddAddressViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "Contact.h"
#import "AddressPickerView.h"
#import "NYNMeAddressModel.h"

typedef void(^SelectedRoomBlock)(NSString *roomName);
@interface NYNAddAddressViewController : BaseViewController<AddressPickerViewDelegate>
@property (strong, nonatomic)  UITextField *nameTf;
@property (strong, nonatomic)  UITextField *phoneTf;
@property (strong, nonatomic)  UITextField *codeTf;
@property (nonatomic,strong)   UILabel *addressLabel;
@property (strong, nonatomic)  UITextView *detailTf;

@property (nonatomic,assign)  BOOL isShow;

@property (nonatomic, strong) Contact *newsContact;
@property (strong, nonatomic)  UIButton *addressButton;
@property (nonatomic ,strong) AddressPickerView * pickerView;


@property (nonatomic, copy) SelectedRoomBlock selectedRoomBlock;

@property (nonatomic,strong) NYNMeAddressModel *model;
@property (nonatomic,copy) NSString * provinceID;
@property (nonatomic,copy) NSString * cityID;

- (void)returnRoomName:(SelectedRoomBlock)block;
@end
