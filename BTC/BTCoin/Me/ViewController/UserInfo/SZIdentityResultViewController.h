//
//  SZIdentityResultViewController.h
//  BTCoin
//
//  Created by Shizi on 2018/4/27.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "CustomViewController.h"

typedef NS_ENUM(NSInteger,SZIdentityResult) {
    SZIdentityResultSuccess =0,
    SZIdentityResultWaiting =1
};
/**身份验证结果页*/
@interface SZIdentityResultViewController : CustomViewController

@property (nonatomic,assign)SZIdentityResult result;

@end
