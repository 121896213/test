
/**RGB 转换成 UIImage*/


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ColorDirectionType){
    ColorDirection_Type_U_D,
    ColorDirection_Type_D_U,
    ColorDirection_Type_L_R,
    ColorDirection_Type_R_L,
};

@interface UIImage (Extension)


/**
 *  返回一个组合带渐变的颜色
 *
 *  @param colors       颜色数组
 *  @param gradientType 渐变的方向类型 0,//从上到下 1,//从左到右 2,//左到右 3,//右到左
 *  @param frame        frame
 *
 *  @return  返回一个组合带渐变的颜色
 */
+(UIImage * _Nonnull)imageFromColors:(NSArray * _Nonnull)colors byGradientType:(ColorDirectionType)gradientType withFrame:(CGRect)frame;


/**
 *  图片更换颜色
 *
 *  @param tintColor 颜色
 *
 */
- (UIImage * _Nonnull)imageByColor:(UIColor * _Nonnull)tintColor;

/**
 *  图片的名字 里面已经包含了图片的路径
 *
 *  @param name 图片的名字
 *
 *  @return 返回一个图片
 
+(UIImage * _Nonnull)imageInFileWithName:(NSString * _Nonnull)name;
*/

+ (UIImage * _Nonnull)imageWithColor:(UIColor * _Nonnull)color;

//==============================================================

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 *  将照片旋转到正确的方向
 */
-(UIImage *)fixOrientation:(UIImage *)aImage;

/**
 *  将图片变成圆形
 *  @param name        图片名
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
*  根据CIImage生成指定大小的UIImage
*
*  @param image CIImage
*  @param size  图片宽度
*
*  @return 生成的高清的UIImage
*/
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;


@end
