//
//  ZZYScan.m
//  Demo
//  Copyright (c) 2015年 zzy. All rights reserved.
//

#import "SZAddressSaoCodeViewController.h"
#import "AVCaptureSessionManager.h"
@interface SZAddressSaoCodeViewController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanTop;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) AVCaptureSessionManager *session;
@property(assign, nonatomic) BOOL TorchState;

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIImageView* linesImageView;

@end


@implementation SZAddressSaoCodeViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setTitleText:NSLocalizedString(@"扫描二维码", nil)];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(showPhotoLibary)];
//    self.navigationItem.rightBarButtonItem = item;

    UIButton* rightButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-FIT3(48)-FIT3(150), NaviBarHeight+StatusBarHeight-32, 44, 44)];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [rightButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [rightButton setTitle:NSLocalizedString(@"相册", nil) forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightButton=rightButton;
    [self setRightBtn:rightButton];
    
    
    [self createRightBtn];
    [self setSubViews];
    [self addActions];
    // 添加跟屏幕刷新频率一样的定时器
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(scan)];
    self.link = link;
    
    // 获取读取读取二维码的会话
    self.session = [[AVCaptureSessionManager alloc]initWithAVCaptureQuality:AVCaptureQualityHigh AVCaptureType:AVCaptureTypeQRCode scanRect:CGRectNull successBlock:^(NSString *reuslt) {
        if (!isEmptyString(reuslt)) {
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate reader:self didScanResult:reuslt];
        }else{
            [self showResult:@"没扫到结果"];
        }
    }];
    self.session.isPlaySound = YES;
    [self.session showPreviewLayerInView:self.view];
    
}


-(void)addActions{
    @weakify(self);
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self showPhotoLibary];
    }];
    
}

-(void)setSubViews{
    
    
    UIView* saoCodeView=[UIView new];
//    saoCodeView.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:saoCodeView];
    [saoCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(233.5);
        make.left.mas_equalTo((ScreenWidth-200)/2);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
        
    }];
    
  
    UIImageView* borderImageView=[UIImageView new];
    [borderImageView setImage: [UIImage imageNamed:@"qrcode_border"]];
    [borderImageView setContentMode:UIViewContentModeScaleToFill];
    borderImageView.backgroundColor=[UIColor clearColor];
    [saoCodeView addSubview:borderImageView];
    borderImageView.clipsToBounds=YES;
    borderImageView.opaque=YES;
    [borderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);

    }];
    


    UIImageView* linesImageView=[UIImageView new];
    [linesImageView setImage: [UIImage imageNamed:@"qrcode_scanline_qrcode"]];
    [linesImageView setContentMode:UIViewContentModeScaleToFill];
    linesImageView.backgroundColor=[UIColor clearColor];
    [saoCodeView addSubview:linesImageView];
    self.linesImageView =linesImageView;
    [linesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-170);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(170);
    }];
    


    
}

// 在页面将要显示的时候添加定时器
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.session start];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

// 在页面将要消失的时候移除定时器
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.session stop];
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)createRightBtn {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(showPhotoLibary)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)showPhotoLibary {
    [AVCaptureSessionManager checkAuthorizationStatusForPhotoLibraryWithGrantBlock:^{
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
        imagePicker.delegate = self;
        if (@available(iOS 11, *)) {
            UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
        [self presentViewController:imagePicker animated:YES completion:nil];
    } DeniedBlock:^{
        UIAlertAction *aciton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"权限未开启" message:@"您未开启相册权限，点击确定跳转至系统设置开启" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:aciton];
        [self presentViewController:controller animated:YES completion:nil];
    }];
}

#pragma mark -  imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.session start];
        [self.session scanPhotoWith:[info objectForKey:@"UIImagePickerControllerOriginalImage"] successBlock:^(NSString *reuslt) {
            if (!isEmptyString(reuslt)) {
                [self.navigationController popViewControllerAnimated:YES];
                [self.delegate reader:self didScanResult:reuslt];
            }else{
                NSString *str = reuslt!= nil ? reuslt : @"没有识别到二维码";
                [self showResult:str];
            }
            
        }];
    }];
    
    if (@available(iOS 11, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.session start];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showResult:(NSString *)result {
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:result delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [view show];
}

// 扫描效果
- (void)scan{
    CGFloat y=CGRectGetMinY(self.linesImageView.frame);
    y+=1;
    [self.linesImageView setFrameY:y];
    if (y>=170) {
        y=-170;
        [self.linesImageView setFrameY:y];
    }
}
- (IBAction)changeTorchState:(id)sender {
    self.TorchState = !self.TorchState;
    NSString *str = self.TorchState ? @"关闭闪光灯" : @"打开闪光灯";
    [((UIButton *)sender) setTitle:str forState:UIControlStateNormal];
    [self.session turnTorch:self.TorchState];
}

@end
