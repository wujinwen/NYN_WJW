//
//  NYNModifyAddressViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressPickerView.h"
#import "NYNMeAddressModel.h"

@interface NYNModifyAddressViewController : BaseViewController<AddressPickerViewDelegate>
@property (strong, nonatomic)  UITextField *nameTf;
@property (strong, nonatomic)  UITextField *phoneTf;
@property (strong, nonatomic)  UITextField *codeTf;
@property (nonatomic,strong)   UILabel *addressLabel;
@property (strong, nonatomic)  UITextView *detailTf;

@property (nonatomic,assign)  BOOL isShow;
@property (nonatomic ,strong) AddressPickerView * pickerView;

@property (nonatomic,strong) NYNMeAddressModel *model;

@end
