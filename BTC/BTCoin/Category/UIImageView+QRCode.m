//
//  UIImage+QRCode.m
//  BTCoin
//
//  Created by sumrain on 2018/8/31.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "UIImageView+QRCode.h"
#import <CoreImage/CoreImage.h>

@implementation UIImageView (QRCode)

- (UIImage *)creatCIQRCodeImage:(NSString *)message
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3. 给过滤器添加数据
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5. 显示二维码
    UIImage * retImage = [UIImage creatNonInterpolatedUIImageFormCIImage:outputImage withSize:200.0];
    return retImage;
}


@end
