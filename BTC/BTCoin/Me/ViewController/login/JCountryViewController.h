//
//  JCountryViewController.h
//  BTCoin
//
//  Created by Shizi on 2018/4/20.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "CustomViewController.h"

@class JCountryModel;

@interface JCountryViewController : UIViewController

@property (nonatomic,copy) void(^CountryBlock)(JCountryModel *countryModel);
@property (nonatomic, strong) JCountryModel *currCountryModel;

@end
