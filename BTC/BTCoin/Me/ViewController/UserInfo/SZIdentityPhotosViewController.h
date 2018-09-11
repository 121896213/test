//
//  SZIdentityPhotosViewController.h
//  BTCoin
//
//  Created by Shizi on 2018/4/27.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "CustomViewController.h"

/**身份认证第二步*/
@interface SZIdentityPhotosViewController : CustomViewController

@property (nonatomic,copy)void (^needReEditBlcok)(NSDictionary * imagesDict);//需要重新编辑信息，保存图片信息先

@property (nonatomic,copy)NSDictionary * paraDict;
@property (nonatomic,assign) IdentityType identityType;;
@end
