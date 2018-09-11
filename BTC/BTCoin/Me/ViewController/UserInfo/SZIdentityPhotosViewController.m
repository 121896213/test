//
//  SZIdentityPhotosViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/4/27.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZIdentityPhotosViewController.h"
#import "UserService.h"
#import "UIImageView+WebCache.h"
//typedef NS_ENUM(NSInteger,IdentityType) {
//    IdentityTypeNone = -1,
//    IdentityTypeIDCard = 0,//身份证
//    IdentityTypePolice = 1,//军官
//    IdentityTypePassport =2,//护照
//    IdentityTypeTaiWan =3,//台湾
//    IdentityTypeHongKong =4//港澳
//    // (0:身份证,1:军官证,2:护照,3:台湾居民通行证,4:港澳居民通行证)
//};
#define  IdentityPromptDictionary  @{@(IdentityTypeIDCard):@{@"front":@"idCard_photo_front",@"back":@"idCard_photo_back",@"handle":@"idCard_photo_handle"},@(IdentityTypePolice):@{@"front":@"idCard_photo_front",@"back":@"idCard_photo_back",@"handle":@"idCard_photo_handle"},@(IdentityTypePassport):@{@"front":@"passport_photo_front",@"back":@"passport_photo_back",@"handle":@"passport_photo_handle"},@(IdentityTypeTaiWan):@{@"front":@"idCard_photo_front",@"back":@"idCard_photo_back",@"handle":@"idCard_photo_handle"},@(IdentityTypeHongKong):@{@"front":@"idCard_photo_front",@"back":@"idCard_photo_back",@"handle":@"idCard_photo_handle"}}

@interface SZIdentityPhotosViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)UILabel * topLabel;
@property (nonatomic,strong)UIButton * frontButton;
@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)UIButton * peopleButton;
@property (nonatomic,strong)UIImageView * frontImageView;
@property (nonatomic,strong)UIImageView * backImageView;
@property (nonatomic,strong)UIImageView * peopleImageView;
@property (nonatomic,strong)UIButton * finishBtn;

@property (nonatomic,copy)NSString * frontUrl;
@property (nonatomic,copy)NSString * backUrl;
@property (nonatomic,copy)NSString * peopleUrl;
@property (nonatomic,assign)NSInteger clickButtonIndex;


@end

@implementation SZIdentityPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _clickButtonIndex = -1;
    [self setTitleText:NSLocalizedString(@"身份认证", nil)];
[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    
    [self configSubViews];
    _frontUrl = [_paraDict objectForKey:@"identityUrlOn"];
    _backUrl = [_paraDict objectForKey:@"identityUrlOff"];
    _peopleUrl = [_paraDict objectForKey:@"identityHoldUrl"];
   
    _frontUrl.length  == 0 ? :[_frontImageView sd_setImageWithURL:[NSURL URLWithString:_frontUrl]];
    _backUrl.length   == 0 ? :[_backImageView sd_setImageWithURL:[NSURL URLWithString:_backUrl]];
    _peopleUrl.length == 0 ? :[_peopleImageView sd_setImageWithURL:[NSURL URLWithString:_peopleUrl]];
    

    
}
-(void)MarchBackLeft{
    NSMutableDictionary * mDict = [NSMutableDictionary dictionary];
    _frontUrl.length == 0 ? :[mDict setValue:_frontUrl forKey:@"identityUrlOn"];
    _backUrl.length == 0 ? :[mDict setValue:_backUrl forKey:@"identityUrlOff"];
    _peopleUrl.length == 0 ? :[mDict setValue:_peopleUrl forKey:@"identityHoldUrl"];
    if (self.needReEditBlcok) {
        self.needReEditBlcok(mDict);
    }
    [super MarchBackLeft];
}
//绘制界面
-(void)configSubViews
{
    
    
    _topLabel = [[UILabel alloc]init];
    _topLabel.font = kFontSize(14);
    _topLabel.text = NSLocalizedString(@"本人证件照片认证", nil);
    _topLabel.textAlignment = NSTextAlignmentLeft;
    _topLabel.textColor = UIColorFromRGB(0x333333);
    [self.view addSubview:_topLabel];
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24+NavigationStatusBarHeight);
        make.size.mas_equalTo(CGSizeMake(FIT3(545), _topLabel.font.lineHeight));
        make.left.mas_equalTo(FIT3(55));
    }];
    
    _frontImageView = [[UIImageView alloc]init];
    _frontImageView.layer.borderWidth = 1.0f;
    _frontImageView.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
    [_frontImageView setImage:[UIImage imageNamed:IdentityPromptDictionary[@(_identityType)][@"front"]]];
    _frontImageView.contentMode=UIViewContentModeScaleAspectFill;
    [ShareFunction setCircleBorder:_frontImageView];
    [self.view  addSubview:_frontImageView];
    [_frontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topLabel.mas_bottom).offset(17);
        make.size.mas_equalTo(CGSizeMake((ScreenWidth-FIT3(55)*3)/2, FIT3(347)));
        make.left.mas_equalTo(FIT3(55));
    }];
    
    UIView* fontBtnView=[UIView new];
    fontBtnView.alpha=0.5;
    fontBtnView.backgroundColor=[UIColor blackColor];
    [ShareFunction setCircleBorder:fontBtnView];
    [self.view  addSubview:fontBtnView];
    [fontBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topLabel.mas_bottom).offset(17);
        make.width.equalTo(_frontImageView.mas_width);
        make.height.equalTo(_frontImageView.mas_height);
        make.left.mas_equalTo(FIT3(55));
    }];
    
    _frontButton=[UIButton new];
    [_frontButton setBackgroundImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
    [_frontButton addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];

    [fontBtnView addSubview:_frontButton];
    [_frontButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(fontBtnView);
        make.size.mas_equalTo(CGSizeMake(FIT3(129), FIT3(129)));
    }];
    
    UILabel* frontLab=[UILabel new];
    frontLab.text=NSLocalizedString(@"点击上传证件正面照", nil);
    frontLab.font=[UIFont systemFontOfSize:12.0f];
    frontLab.textAlignment=NSTextAlignmentCenter;
    [self.view  addSubview:frontLab];
    [frontLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_frontImageView.mas_width);
        make.left.equalTo(fontBtnView.mas_left);
        make.top.equalTo(_frontImageView.mas_bottom).offset(FIT3(32));
        make.height.mas_equalTo(frontLab.font.lineHeight);
    }];
    
    
    
    _backImageView = [[UIImageView alloc]init];
    _backImageView.layer.borderWidth = 1.0f;
    _backImageView.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
    [_backImageView setImage:[UIImage imageNamed:IdentityPromptDictionary[@(_identityType)][@"back"]]];
    _backImageView.contentMode=UIViewContentModeScaleAspectFill;
    [ShareFunction setCircleBorder:_backImageView];

    [self.view  addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_frontImageView.mas_top);
        make.width.equalTo(_frontImageView.mas_width);
        make.height.equalTo(_frontImageView.mas_height);
        make.left.equalTo(_frontImageView.mas_right).offset(FIT3(55));
    }];
    
    UIView* backBtnView=[UIView new];
    backBtnView.alpha=0.5;
    backBtnView.backgroundColor=[UIColor blackColor];
    [ShareFunction setCircleBorder:backBtnView];

    [self.view  addSubview:backBtnView];
    [backBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backImageView.mas_top);
        make.width.equalTo(_frontImageView.mas_width);
        make.height.equalTo(_frontImageView.mas_height);
        make.left.equalTo(_backImageView.mas_left);
    }];
    
    _backButton=[UIButton new];
    [_backButton setBackgroundImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];

    [backBtnView addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(backBtnView);
        make.size.mas_equalTo(CGSizeMake(FIT3(129), FIT3(129)));
    }];
    
    UILabel* backLab=[UILabel new];
    backLab.text= _identityType== 2?NSLocalizedString(@"点击上传证件内页照", nil):NSLocalizedString(@"点击上传证件反面照", nil);
    backLab.font=[UIFont systemFontOfSize:12.0f];
    backLab.textAlignment=NSTextAlignmentCenter;

    [self.view  addSubview:backLab];
    [backLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_backImageView.mas_width);
        make.left.equalTo(backBtnView.mas_left);
        make.top.equalTo(_backImageView.mas_bottom).offset(FIT3(32));
        make.height.mas_equalTo(backLab.font.lineHeight);
    }];
    
    
    
    _peopleImageView = [[UIImageView alloc]init];
    _peopleImageView.layer.borderWidth = 1.0f;
    _peopleImageView.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
    [_peopleImageView setImage:[UIImage imageNamed:IdentityPromptDictionary[@(_identityType)][@"handle"]]];
    _peopleImageView.contentMode=UIViewContentModeScaleAspectFill;
    [ShareFunction setCircleBorder:_peopleImageView];

    [self.view  addSubview:_peopleImageView];
    [_peopleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(frontLab.mas_bottom).offset(10);
        make.width.equalTo(_frontImageView.mas_width);
        make.height.equalTo(_frontImageView.mas_height);
        make.left.mas_equalTo(FIT3(55));
    }];
    
    UIView* handleBtnView=[UIView new];
    handleBtnView.alpha=0.5;
    handleBtnView.backgroundColor=[UIColor blackColor];
    [ShareFunction setCircleBorder:handleBtnView];
    [self.view  addSubview:handleBtnView];
    [handleBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_peopleImageView.mas_top);
        make.width.equalTo(_frontImageView.mas_width);
        make.height.equalTo(_frontImageView.mas_height);
        make.left.mas_equalTo(FIT3(55));
    }];
    
    _peopleButton=[UIButton new];
    [_peopleButton setBackgroundImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
    [_peopleButton addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];

    [handleBtnView addSubview:_peopleButton];
    [_peopleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(handleBtnView);
        make.size.mas_equalTo(CGSizeMake(FIT3(129), FIT3(129)));
    }];
    
    UILabel* handelLab=[UILabel new];
    handelLab.text=NSLocalizedString(@"点击上传手持证件正面照", nil);
    handelLab.font=[UIFont systemFontOfSize:12.0f];
    handelLab.textAlignment=NSTextAlignmentCenter;
    [self.view  addSubview:handelLab];
    [handelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_peopleImageView.mas_width);
        make.left.equalTo(handleBtnView.mas_left);
        make.top.equalTo(_peopleImageView.mas_bottom).offset(FIT3(32));
        make.height.mas_equalTo(handelLab.font.lineHeight);
    }];
    
    
    
    UILabel* noticeLabel = [[UILabel alloc]init];
    noticeLabel.layer.borderWidth = 1.0f;
    noticeLabel.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
    noticeLabel.numberOfLines=0;
    noticeLabel.font=[UIFont systemFontOfSize:10.0f];
    noticeLabel.textColor=UIColorFromRGB(0xACACAC);
    noticeLabel.text=@"1.请按照要求上传您的证件照片\n2.仅支持jpg、bmp、png格式\n3.大小限制为10MB以内\n4.确保身份证件信息没被遮挡\n5.避免证件信息与头部重叠\n6.确保身份证件内容完整清晰可见";
    [ShareFunction setCircleBorder:_backImageView];
    NSArray* strings=@[@"jpg、",@"bmp、",@"png",@"1MB"];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString: noticeLabel.text];
    NSRange range;
    for (NSString* string in strings) {
        if([noticeLabel.text rangeOfString:string].location !=NSNotFound){
            range = [noticeLabel.text rangeOfString:string];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:MainThemeColor range:NSMakeRange(range.location, range.length)];
        }
    }
    //添加到UILabel中显示
    noticeLabel.attributedText = AttributedStr;
    
    [self.view  addSubview:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_peopleImageView.mas_top);
        make.width.equalTo(_frontImageView.mas_width);
        make.height.equalTo(_frontImageView.mas_height);
        make.left.equalTo(_peopleImageView.mas_right).offset(FIT3(55));
    }];
    
    
    _finishBtn = [[UIButton alloc]init];
    _finishBtn.backgroundColor = UIColorFromRGB(0x497cce);
    _finishBtn.layer.cornerRadius = 5.0f;
    [_finishBtn setTitle:NSLocalizedString(@"提交认证", nil) forState:UIControlStateNormal];
    [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_finishBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];

    [_finishBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:_finishBtn];
    
    [_finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(FIT3(-170));
        make.left.mas_equalTo(FIT3(48));
        make.right.mas_equalTo(FIT3(-48));
        make.height.mas_equalTo(FIT3(150));
    }];
    [_finishBtn setGradientBackGround];
    [_finishBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x00b500)] forState:UIControlStateSelected];
    [ShareFunction setCircleBorder:_finishBtn];
  
}

//完成
-(void)finishBtnClick:(UIButton *)button{
    if (!_frontUrl || !_backUrl || !_peopleUrl) {
        [self showPromptHUDWithTitle:NSLocalizedString(@"请先上传图片", nil)];
        return;
    }
    [self showLoadingMBProgressHUD];
    [self setButtonsIsEnable:NO];

    NSString * urlStr = [NSString stringWithFormat:@"%@/user/validateKycTemp.do",BaseHttpUrl];
    NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithDictionary:_paraDict];
    [mDict setValue:_frontUrl forKey:@"identityUrlOn"];
    [mDict setValue:_backUrl forKey:@"identityUrlOff"];
    [mDict setValue:_peopleUrl forKey:@"identityHoldUrl"];

    [self showLoadingMBProgressHUD];
    __weak typeof(self) weakSelf = self;
    [BaseService post:urlStr dictionay:mDict timeout:SERVICETIMEOUT success:^(id responseObject) {
        [weakSelf hideMBProgressHUD];
        BaseModel * base = [BaseModel modelWithJson:responseObject];
        if (!base.errorMessage) {
            [self showErrorHUDWithTitle:base.msg];
            KUserSingleton.idAuthStatus = 1;
            [[SZSundriesCenter instance] delayExecutionInMainThread:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }else{
            [self showErrorHUDWithTitle:base.errorMessage];
        }
    } fail:^(NSError *error) {
        [weakSelf hideMBProgressHUD];
        [weakSelf setButtonsIsEnable:NO];

    }];
}

#pragma mark -- 点击按钮、选择拍照/相册、上传照片
-(void)buttonCLick:(UIButton *)button
{
    if (button == _frontButton) {
        _clickButtonIndex = 1;
    }else if (button == _backButton){
        _clickButtonIndex = 2;
    }else if (button == _peopleButton){
        _clickButtonIndex = 3;
    }
    [self makeChoice];
}

//
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
    [self upload:image];
    
    if (@available(iOS 11, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];

}
- (void)extracted:(UIImage *)image {
    
    
  
    [[UserService sharedUserService]uploadIDImage:image success:^(id responseObject) {
        [self hideMBProgressHUD];
        [self setButtonsIsEnable:YES];
        if (SuccessCode == [responseObject[@"code"] integerValue]) {
            NSString * url =  responseObject[@"resultUrl"];
            switch (_clickButtonIndex) {
                case 1:{
                    _frontUrl = url;
                    _frontImageView.image = image;
                }
                    break;
                case 2:{
                    _backUrl = url;
                    _backImageView.image = image;
                }
                    break;
                case 3:{
                    _peopleUrl = url;
                    _peopleImageView.image = image;
                }
                    break;
                default:
                    break;
            }
        }
    }fail:^(NSError *error) {
        [self showErrorHUDWithTitle:error.localizedDescription];
        [self setButtonsIsEnable:YES];
    }];
}

//上传
-(void)upload:(UIImage*)image{
    

    [self showLoadingMBProgressHUD];
    [self setButtonsIsEnable:NO];
    [self extracted:image];
}

//设置按钮是否可用
-(void)setButtonsIsEnable:(BOOL)isEnable{
    _frontButton.enabled = _backButton.enabled = _peopleButton.enabled = isEnable;
}

-(UIButton *)createTapViewWithTitle:(NSString *)tittle
{
    UIButton * view = [[UIButton alloc]init];
    view.backgroundColor = UIColorFromRGBWithAlpha(0x497cce, 0.5);
    view.layer.cornerRadius = 45;
    
    UIImageView * topImage = [[UIImageView alloc]init];
    topImage.image = kIMAGE_NAMED(@"addImage");
    [view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerX.mas_equalTo(view);
    }];
    
    UILabel * titleLab = [[UILabel alloc]init];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = kFontSize(9);
    titleLab.numberOfLines = 2;
    titleLab.text = tittle;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.adjustsFontSizeToFitWidth = YES;
    [view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topImage.mas_bottom).offset(9);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);

    }];
    [view addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
