//
//  SZEditHeadImageViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/7/30.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZEditHeadImageViewController.h"

@interface SZEditHeadImageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonnull,nonatomic,strong) UIImageView* imageView;
@end

@implementation SZEditHeadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTitleText:NSLocalizedString(@"头像修改", nil)];

    
    UIImageView*  imageView=[[UIImageView alloc]init];
    [imageView setImage:[UIImage imageNamed:@"user_header"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationStatusBarHeight);
        make.left.mas_equalTo(FIT(0));
        make.width.height.mas_equalTo(FIT(414));
    }];
    self.imageView=imageView;
    
    UIButton *picturesBtn=[UIButton new];
    [picturesBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(18)]];
    [picturesBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [picturesBtn setTitle:NSLocalizedString(@"从相册选一张", nil) forState:UIControlStateNormal];
    [picturesBtn setTitleColor:MainThemeColor forState:UIControlStateNormal];
    [picturesBtn setBackgroundColor:[UIColor whiteColor]];
    [picturesBtn setCircleBorderWidth:FIT(1) bordColor:picturesBtn.backgroundColor radius:FIT(3)];
    [self.view addSubview:picturesBtn];
    [picturesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.top.equalTo(imageView.mas_bottom).offset(FIT(22));
        make.height.mas_equalTo(FIT(50));
        make.width.mas_equalTo(ScreenWidth-FIT(16)*2);
    
    }];
    
    
    
    
    UIButton *takePictureBtn=[UIButton new];
    [takePictureBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(18)]];
    [takePictureBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [takePictureBtn setTitle:NSLocalizedString(@"拍一张照片", nil) forState:UIControlStateNormal];
    [takePictureBtn setTitleColor:MainThemeColor forState:UIControlStateNormal];
    [takePictureBtn setBackgroundColor:[UIColor whiteColor]];
    [takePictureBtn setCircleBorderWidth:FIT(1) bordColor:picturesBtn.backgroundColor radius:FIT(3)];
    [self.view addSubview:takePictureBtn];
    [takePictureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.top.equalTo(picturesBtn.mas_bottom).offset(FIT(15));
        make.height.mas_equalTo(FIT(50));
        make.width.mas_equalTo(ScreenWidth-FIT(16)*2);
        
    }];
    
    

    
    UIButton *saveBtn=[UIButton new];
    [saveBtn.titleLabel setFont:[UIFont systemFontOfSize:FIT(18)]];
    [saveBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [saveBtn setTitle:NSLocalizedString(@"保存", nil) forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.top.equalTo(takePictureBtn.mas_bottom).offset(FIT(31));
        make.height.mas_equalTo(FIT(50));
        make.width.mas_equalTo(ScreenWidth-FIT(16)*2);
        
    }];
    [saveBtn setGradientBackGround];
    
    
    [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
    }];
    
    
    [[takePictureBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self getImageWithType:UIImagePickerControllerSourceTypeCamera];

    }];
    
    [[picturesBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self getImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)makeChoice{
    
    NSMutableArray *actionSheetItems = [@[FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"拍照", nil) ),
                                          FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"从相册选择", nil))]
                                        mutableCopy];
    FSActionSheet *actionSheet = [[FSActionSheet alloc] initWithTitle:nil cancelTitle:NSLocalizedString(@"取消", nil) items:actionSheetItems];
    actionSheet.contentAlignment = FSContentAlignmentCenter;
    // 展示并绑定选择回调
    [actionSheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
        if (selectedIndex == 0) {
            [self getImageWithType:UIImagePickerControllerSourceTypeCamera];
        }else{
            [self getImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    }];
    
}


-(void)getImageWithType:(UIImagePickerControllerSourceType)sourceType{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        picker.allowsEditing = YES;
        if (@available(iOS 11, *)) {
            UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self.imageView setImage:image];
    if (@available(iOS 11, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
@end
