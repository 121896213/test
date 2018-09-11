

/**
 *  公共函数方法 全类通用
 */
#import "ShareFunction.h"
#import "LoginViewController.h"
@implementation ShareFunction


#pragma mark 指定宽度字体，计算出字符串的高度
+ (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10.0f];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
}


#pragma mark 计算出字体的长度已经高度。这里不包括行距
+(CGSize)calculationOfTheText:(NSString *)string withFont:(CGFloat)font withMaxSize:(CGSize)maxSize{
    
    CGSize newSize = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return CGSizeMake(ceilf(newSize.width), ceilf(newSize.height));
}
#pragma mark 计算富文本的行距。包括了行高
+(CGSize)calculationOfTheText:(NSMutableAttributedString *)attributedString withFont:(CGFloat)font withLineFloat:(CGFloat)lineFloat withMaxSize:(CGSize)maxSize{
    // 设置字体
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineFloat];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, attributedString.length)];
    // 自动获取attributedString所占CGSize 注意：获取前必须设置所有字体大小
    CGSize  attributedStringSize = [attributedString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    CGSize newSize = CGSizeMake(ceilf(attributedStringSize.width), ceilf(attributedStringSize.height));
    return newSize;
}

/**
 获取NSAttributedString  高度
 */
+(CGSize)calculationOfTheText:(NSAttributedString *)attributedString withMaxSize:(CGSize)maxSize{
    // 自动获取attributedString所占CGSize 注意：获取前必须设置所有字体大小
    CGSize  attributedStringSize = [attributedString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    CGSize newSize = CGSizeMake(ceilf(attributedStringSize.width), ceilf(attributedStringSize.height));
    return newSize;
}


#pragma mark 设置导航条的颜色,已经隐藏导航条下面的线了
+(void)setNavigationBarColor:(UIColor *)color withTargetViewController:(id)target{
    
    UIViewController *viewController = (UIViewController *)target;
    //导航条的颜色 以及隐藏导航条的颜色
    viewController.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [viewController.navigationController.navigationBar setBackgroundImage:theImage forBarMetrics:UIBarMetricsDefault];
}
#pragma mark scrollView顶部视图下拉放大
/**
 *  scrollView顶部视图下拉放大
 *
 *  @param imageView  需要放大的图片
 *  @param headerView 图片所在headerView 如果没有则传图片自己本身
 *  @param height     图片的高度
 *  @param offsetY    设置偏移多少开始形变  例如是：offset_y = 64 说明就是y向下偏移64像素开始放大
 *  @param scrollView 对应的scrollView
 */
+(void)setHeaderViewDropDownEnlargeImageView:(UIImageView *)imageView withHeaderView:(UIView *)headerView withImageViewHeight:(CGFloat)height withOffsetY:(CGFloat)offsetY withScrollView:(UIScrollView *)scrollView{
    CGFloat yOffset = scrollView.contentOffset.y;
    //向上偏移量变正  向下偏移量变负
    /**
     *  设置偏移多少开始形变  例如是：offset_y = 64 说明就是y向下偏移64像素开始放大
     宏：k_headerViewHeight 就是header的高度
     */
    CGFloat offset_y = offsetY;
    CGFloat imageHeight = height;
    
    if (yOffset < -offset_y) {
        CGFloat factor = ABS(yOffset)+imageHeight-offset_y;
        CGRect f = CGRectMake(- ([[UIScreen mainScreen] bounds].size.width*factor/imageHeight-[[UIScreen mainScreen] bounds].size.width)/2,-ABS(yOffset)+offset_y, [[UIScreen mainScreen] bounds].size.width*factor/imageHeight, factor);
        imageView.frame = f;
    }else {
        CGRect f = headerView.frame;
        f.origin.y = 0;
        headerView.frame = f;
        imageView.frame = CGRectMake(0, f.origin.y, [[UIScreen mainScreen] bounds].size.width, imageHeight);
    }
}


#pragma mark 传入当前控制器 获取同一个nav里面的控制器
+(UIViewController *)getTargetViewController:(NSString *)viewControllerName withInTheCurrentController:(UIViewController *)viewController{
    NSArray *viewControllers = viewController.navigationController.viewControllers;
    id object;
    for (int i=0; i!=viewControllers.count; i++) {
        UIViewController *viewController = viewControllers[i];
        NSString *vcName = [NSString stringWithUTF8String:object_getClassName(viewController)];
        if ([vcName isEqualToString:viewControllerName]) {
            object = viewController;
        }
    }
    return (UIViewController *)object;
}

#pragma mark 传入时间戳1296057600和输出格式 yyyy-MM-dd HH:mm:ss
+ (NSString *)dateWithTimeIntervalSince1970:(NSTimeInterval)seconds dateStringWithFormat:(NSString *)format {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *dateFormatte = [[NSDateFormatter alloc] init];
    [dateFormatte setDateFormat:format];
    return [dateFormatte stringFromDate:date];
}

+ (NSString *)dateWithTimeIntervalSince1970_mater_yyyy_MM_dd:(NSString *)seconds{
        
    return [ShareFunction dateWithTimeIntervalSince1970:[seconds integerValue] dateStringWithFormat:@"yyyy-MM-dd"];
}


#pragma mark 小到大
+(NSMutableArray *)sortOfSmallToBig:(NSArray *)array{
    
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:array];
    for (int i = 0; i < muArray.count; i++) {
        for (int j = 0; j < muArray.count - i - 1;j++) {
            if ([muArray[j+1]floatValue] < [muArray[j] floatValue]) {
                float temp = [muArray[j] floatValue];
                muArray[j] = muArray[j + 1];
                muArray[j + 1] = [NSString stringWithFormat:@"%f",temp];
            }
        }
    }
    return muArray;
}


+(NSArray *)returnMinandMaxWithArrayA:(NSArray *)arrA withArrayB:(NSArray *)arrB{

    
    
    NSMutableArray *muArrayA = [ShareFunction sortOfSmallToBig:arrA];
    NSMutableArray *muArrayB = [ShareFunction sortOfSmallToBig:arrB];

    float minA = [[muArrayA firstObject] floatValue];
    float maxA = [[muArrayA lastObject] floatValue];

    float minB = [[muArrayB firstObject] floatValue];
    float maxB = [[muArrayB lastObject] floatValue];
    
    float min = 0.0;
    float max = 0.0;
    if (minA>minB) {
        min = minB;
    }else{
        min = minA;
    }
    
    if (maxA>maxB) {
        max = maxA;
    }else{
        max = maxB;
    }
    
    CGFloat tempFloat = ABS(max-min) * 0.2;
    if (max==min) {
        min = -1.0;
        max = 1.0;
    }else{
        max = max + tempFloat;
        min = min - tempFloat;
    }
    
    return @[[NSString stringWithFormat:@"%f",((min))],[NSString stringWithFormat:@"%f",(max)]];
}

+(NSArray *)returnStockDelChartLineViewLeftLabelTextWithDataArray:(NSArray *)array{

    NSMutableArray *muArray = [NSMutableArray array];
    CGFloat tempFloat = ABS([[array firstObject] floatValue] - [[array lastObject] floatValue])/4.0;
    
    for (int i=0; i!=5; i++) {
        CGFloat floatStr = [[array lastObject] floatValue] - (i * tempFloat);
        [muArray addObject:[NSString stringWithFormat:@"%.2f%%",floatStr]];
    }
    return muArray;
}


/**
 返回一个圆形的图片
 
 @param image  图片
 @param border 尺寸大小
 
 @return  返回一个圆形的图片
 */
+ (UIImage *)returnCircularImageWithImage:(UIImage *)image borderFloat:(CGFloat)border{
    
    
    //这里不用管实现的方法，只要你设置一张你想使用的边框图片就可以了
    //    UIImage *borderImg = [self createImageWithColor:[UIColor colorWithRed:53 green:53 blue:68 alpha:0.32]];
    
    //头像图片
    
    //设置头像白色边框 像素6px
    CGSize size = CGSizeMake(image.size.width + border, image.size.height + border);
    
    //创建图片上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    //绘制边框的圆
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    
    //剪切可视范围
    CGContextClip(context);
    
    //绘制边框图片
    //    [borderImg drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //设置头像
    CGFloat iconX = border/2;
    CGFloat iconY = border/2;
    CGFloat iconW = image.size.width;
    CGFloat iconH = image.size.height;
    
    //绘制圆形头像范围
    CGContextAddEllipseInRect(context, CGRectMake(iconX, iconY, iconW, iconH));
    //剪切可视范围
    CGContextClip(context);
    //绘制头像
    [image drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    //取出整个头像上下文的图片
    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return iconImage;
}


+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }

    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];

    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;

    return result;
}



+ (NSString *)informationForMattheTime:(NSString *)targetTime{
    
    NSString *timeStr = @"";
    //获取本地时间戳
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowDateTime = [nowDate timeIntervalSince1970];
    NSString *nowDateStr = [NSString stringWithFormat:@"%.0f",nowDateTime];
    
    //目标时间戳
    long timeInterval = fabs([nowDateStr floatValue] - [targetTime floatValue]);
    
    //获取当天的最晚的时间戳
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[targetTime integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString * dateString = [dateFormatter stringFromDate:date];
    NSString *lastDateString = [NSString stringWithFormat:@"%@ 23:59:59",dateString];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *lastdate =[dateFormat dateFromString:lastDateString];
    //当天23：59：59的时间戳
    NSString *lastTimeStr = [NSString stringWithFormat:@"%.0f",[lastdate timeIntervalSince1970]];
    
    long maxtimeInterval = fabs([nowDateStr floatValue] - [lastTimeStr floatValue]);
    
    if (timeInterval<=(4*60)) {
        timeStr = @"刚刚";
    }else if (timeInterval>(4*60)&&timeInterval<=(10*60)){
        
        CGFloat num =  ceilf(timeInterval/60);
        timeStr = [NSString stringWithFormat:@"%.f分钟",num];
        
    }else if (timeInterval>(10*60)&&timeInterval<=maxtimeInterval){
        
        NSDateFormatter *lastdateFormatter = [[NSDateFormatter alloc] init];
        lastdateFormatter.dateFormat = @"HH:mm";
        timeStr = [lastdateFormatter stringFromDate:date];
    }else{//非当天
        
        NSDate * thisdate = [NSDate dateWithTimeIntervalSince1970:[targetTime integerValue]];
        NSDateFormatter *thisdateFormatter = [[NSDateFormatter alloc] init];
        thisdateFormatter.dateFormat = @"MM-dd  HH:mm";
        timeStr = [thisdateFormatter stringFromDate:thisdate];
    }
    
    return timeStr;
}


/**获取当前时间戳*/
+ (NSString *)getNowTimestamp{
    
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowDateTime = [nowDate timeIntervalSince1970];
    NSString *nowDateStr = [NSString stringWithFormat:@"%.0f",nowDateTime];
    return nowDateStr;
}






+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

//划线
+(void)drawLineInFrame:(CGRect)frame
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 204 / 255.0, 204 / 255.0, 204 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, frame.origin.x, frame.origin.y);  //起点坐标
    CGContextAddLineToPoint(context, frame.size.width, frame.origin.y+frame.size.height);   //终点坐标
    
    CGContextStrokePath(context);
}


+(void)setCircleBorder:(UIView*)view{
    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    maskLayer.frame = view.bounds;
//    maskLayer.path = maskPath.CGPath;
//    view.layer.mask = maskLayer;
    
    view.layer.borderWidth = 0.5;
    view.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
}


@end
