
#define EmptyViewTag 999993


#import "UIViewController+EmpetViewTips.h"
#import <objc/runtime.h>


static char  * TapRecognizerBlockKey;

@implementation UIViewController (EmpetViewTips)

-(void)showEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showEmptyViewInView:targetView withMsg:msg withImageName:@"empty_loading_empty" touchHanleBlock:hanleBlock];
    });
    
}

-(void)showSearchEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showEmptyViewInView:targetView withMsg:msg withImageName:@"empty_loading_empty" touchHanleBlock:NULL];
    });
}



-(void)showErrorViewInView:(UIView *)targetView withMsg:(NSString *)msg touchHanleBlock:(TouchHanleBlock)hanleBlock{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showEmptyViewInView:targetView withMsg:msg withImageName:@"empty_loading_lost" touchHanleBlock:hanleBlock];
    });
    
}


-(void)showEmptyViewInView:(UIView *)targetView withMsg:(NSString *)msg  withImageName:(NSString *)imageName touchHanleBlock:(TouchHanleBlock)hanleBlock{
    
    
    
    UIView *emptyView = [targetView viewWithTag:EmptyViewTag];
    if (emptyView) {
        [emptyView removeFromSuperview];
    }
    
    CGFloat width = targetView.frame.size.width;
    CGFloat height = targetView.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,width,height}];
    [targetView addSubview:view];
    
    view.userInteractionEnabled = YES;
    [view setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    view.tag = EmptyViewTag;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]init];
    tapRecognizer.numberOfTapsRequired = 1;
    [tapRecognizer addTarget:self action:@selector(tapRecognizerAction:)];
    [view addGestureRecognizer:tapRecognizer];
    
    objc_setAssociatedObject(self, &TapRecognizerBlockKey, hanleBlock, OBJC_ASSOCIATION_COPY);
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    if (kiPhone4_OR_4s || kiPhone5_OR_5c_OR_5s) {
        imageView.frame = (CGRect){0,0,120,120};
    }else{
        imageView.frame = (CGRect){0,0,180,180};
    }
    
    imageView.center = CGPointMake(view.center.x, view.center.y-60);
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    UILabel *titLab = [[UILabel alloc]init];
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.numberOfLines = 0;
    titLab.textColor = UIColorFromRGB(0x919191);
    titLab.text = msg;
    titLab.font = Font_15;
    [titLab sizeToFit];
    titLab.frame = (CGRect){0,CGRectGetMaxY(imageView.frame)+10,width,titLab.frame.size.height};
    [view addSubview:titLab];
    
    
}



-(void)tapRecognizerAction:(UITapGestureRecognizer *)tap{
    
    TouchHanleBlock block = objc_getAssociatedObject(self, &TapRecognizerBlockKey);
    
    if (block==NULL) {
        return;
    }
    
    if (block)
    {
        block();
    }
    
    UIView *tapView = tap.view;
    if (tapView) {
        [tapView removeFromSuperview];
    }
    
}


-(void)hideEmptyViewInView:(UIView *)targetView{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = [targetView viewWithTag:EmptyViewTag];
        if (view)
        {
            [view removeFromSuperview];
        }
        
    });
}




@end
