//
//  SZPropertyViewModel.h
//  BTCoin
//
//  Created by Shizi on 2018/5/7.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZRootViewModel.h"
#import "SZPropertyTypeListModel.h"
#import "SZPropertyCellViewModel.h"
#import "SZC2CPropertyModel.h"
#import "SZBaseListModel.h"
#import "SZWalletModel.h"
typedef enum : NSUInteger {
    SZAccountTypeBb=1,
    SZAccountTypeSc=2,
} SZAccountType;

@interface SZPropertyViewModel : SZRootViewModel
@property (nonatomic,copy) NSArray* propertyList;
@property (nonatomic,strong) SZPropertyTypeListModel* listModel;
@property (nonatomic,strong) SZBaseListModel* scListModel;
@property (nonatomic,strong) SZBaseListModel* c2cListModel;

@property (nonatomic,assign) SZWalletType walletType;
@property (nonatomic,assign) SZWalletModel* walletModel;

@property (nonatomic,assign) NSInteger currentPage;

-(void)getPropertyListWithParameters:(id)parameters;
-(NSInteger)getPropertyCellNumber;
-(CGFloat)getPropertyCellHeight;
- (SZPropertyCellViewModel *)propertyCellViewModelAtIndexPath:(NSIndexPath *)indexPath ;
@end
