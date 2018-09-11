//
//  UIImage+QRCode.h
//  BTCoin
//
//  Created by sumrain on 2018/8/31.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (QRCode)
- (UIImage *)creatCIQRCodeImage:(NSString *)message;
@end
