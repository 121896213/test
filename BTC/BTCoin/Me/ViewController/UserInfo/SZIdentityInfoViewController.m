//
//  SZIdentityInfoViewController.m
//  BTCoin
//
//  Created by Shizi on 2018/4/26.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZIdentityInfoViewController.h"
#import "CGXPickerView.h"
#import "SZIdentityPhotosViewController.h"

@interface SZIdentityInfoViewController (){
    IdentityType _identityType;
}
@property (nonatomic,strong)UITextField * cardNameTF;//证件类型
@property (nonatomic,strong)UITextField * realNameTF;//真实姓名
@property (nonatomic,strong)UITextField * cardNumberTF;//证件号码
@property (nonatomic,strong)UIButton * selectCardTypeButton;
@property (nonatomic,strong)UIButton * nextStepButton;

@property (nonatomic,copy)NSDictionary * imagesDict;//从下个页面回调回的
@end

@implementation SZIdentityInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"身份认证", nil)];
[self setValue:@(NSTextAlignmentCenter) forKeyPath:@"_txtTitle.textAlignment"];
    [self configSubViews];
    _identityType = IdentityTypeNone;
}
//绘制界面
-(void)configSubViews
{
    UILabel * label_one = [[UILabel alloc]init];
    label_one.font = kFontSize(14);
    label_one.text = NSLocalizedString(@"证件类型", nil);
    label_one.textColor = UIColorFromRGB(0x333333);
    [self.view addSubview:label_one];
    [label_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom).offset(24);
        make.left.mas_equalTo(14);
    }];
    
    _cardNameTF = [[UITextField alloc]init];
    _cardNameTF.textColor = UIColorFromRGB(0x333333);
    _cardNameTF.font = kFontSize(14);
    _cardNameTF.placeholder = NSLocalizedString(@"请选择您所认证的证件类型", nil);
    _cardNameTF.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_cardNameTF];
    [_cardNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_one.mas_bottom).offset(23);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    _cardNameTF.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, FIT3(146))];
    _cardNameTF.leftViewMode=UITextFieldViewModeAlways;
    
 
    _selectCardTypeButton = [[UIButton alloc]init];
    [_selectCardTypeButton addTarget:self action:@selector(selectCardTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectCardTypeButton];
    [_selectCardTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7);
        make.right.mas_equalTo(-7);
        make.top.mas_equalTo(_cardNameTF.mas_top);
        make.bottom.mas_equalTo(_cardNameTF.mas_bottom);
    }];
    
    UIImageView * downSanJiaoImage = [[UIImageView alloc]initWithImage:kIMAGE_NAMED(@"meCenterArrowDown")];
    downSanJiaoImage.contentMode=UIViewContentModeScaleAspectFit;
    [_selectCardTypeButton addSubview:downSanJiaoImage];
    [downSanJiaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT3(43));
        make.right.mas_equalTo(FIT3(-43));
        make.width.mas_equalTo(FIT3(60));
        make.height.mas_equalTo(FIT3(60));
    }];
    
    UILabel * label_two = [[UILabel alloc]init];
    label_two.font = kFontSize(14);
    label_two.text = NSLocalizedString(@"真实姓名", nil);
    label_two.textColor = UIColorFromRGB(0x333333);
    [self.view addSubview:label_two];
    [label_two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_cardNameTF.mas_bottom).offset(24);
        make.left.mas_equalTo(14);
    }];
    
    _realNameTF = [[UITextField alloc]init];
    _realNameTF.textColor = UIColorFromRGB(0x333333);
    _realNameTF.font = kFontSize(14);
    _realNameTF.placeholder = NSLocalizedString(@"请填写您的真实姓名", nil);
    _realNameTF.backgroundColor=[UIColor whiteColor];
    _realNameTF.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, FIT3(146))];
    _realNameTF.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_realNameTF];
    [_realNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_two.mas_bottom).offset(23);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
    
    UILabel * label_thr = [[UILabel alloc]init];
    label_thr.font = kFontSize(14);
    label_thr.text = NSLocalizedString(@"证件号码", nil);
    label_thr.textColor = UIColorFromRGB(0x333333);
    [self.view addSubview:label_thr];
    [label_thr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_realNameTF.mas_bottom).offset(24);
        make.left.mas_equalTo(14);
    }];
    
    _cardNumberTF = [[UITextField alloc]init];
    _cardNumberTF.textColor = UIColorFromRGB(0x333333);
    _cardNumberTF.font = kFontSize(14);
    _cardNumberTF.placeholder = NSLocalizedString(@"请输入证件号码", nil);
    _cardNumberTF.backgroundColor=[UIColor whiteColor];
    _cardNumberTF.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, FIT3(146))];
    _cardNumberTF.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_cardNumberTF];
    [_cardNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_thr.mas_bottom).offset(23);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(FIT3(146));
    }];
    
 
    _nextStepButton = [[UIButton alloc]init];
    _nextStepButton.backgroundColor = UIColorFromRGB(0x497cce);
    _nextStepButton.layer.cornerRadius = 5.0f;
    [_nextStepButton setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    [_nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextStepButton.titleLabel.font = kFontSize(14);
    [_nextStepButton addTarget:self action:@selector(nextStepButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextStepButton];
    [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(FIT3(-170));
        make.left.mas_equalTo(FIT3(48));
        make.right.mas_equalTo(FIT3(-48));
        make.height.mas_equalTo(FIT3(150));
    }];
    [_nextStepButton setGradientBackGround];
    [_nextStepButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x00b500)] forState:UIControlStateSelected];
    [ShareFunction setCircleBorder:_nextStepButton];
}

-(void)selectCardTypeButtonClick:(UIButton *)button
{
    
    NSMutableArray *actionSheetItems = [@[FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"身份证", nil) ),
//                                          FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"军官证", nil)),
                                          FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"护照", nil)),
//                                          FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"台湾居民通行证", nil)),
                                         /* FSActionSheetTitleItemMake(FSActionSheetTypeNormal, NSLocalizedString(@"港澳居民通行证", nil))*/]
                                        mutableCopy];
    FSActionSheet *actionSheet = [[FSActionSheet alloc] initWithTitle:nil cancelTitle:NSLocalizedString(@"取消", nil) items:actionSheetItems];
    actionSheet.contentAlignment = FSContentAlignmentCenter;
    // 展示并绑定选择回调
    [actionSheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
        FSActionSheetItem *item = actionSheetItems[selectedIndex];
        self.cardNameTF.text =item.title;
        if (selectedIndex == 0) {
            _identityType = IdentityTypeIDCard;
        } if (selectedIndex == 1) {
            _identityType = IdentityTypePassport;
        }
    }];

}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//nextStepButtonClick
-(void)nextStepButtonClick:(UIButton *)button
{
    if ([self checkFullInput]) {
        [self goNextPage];
    }
}

-(BOOL)checkFullInput{
    if (_identityType == IdentityTypeNone) {
        [self showPromptHUDWithTitle:NSLocalizedString(@"请选择您所认证的证件类型", nil)];
        return NO;
    }
    if (self.realNameTF.text.length == 0) {
        [self showPromptHUDWithTitle:NSLocalizedString(@"请填写您的真实姓名", nil)];
        return NO;
    }
    if (self.cardNumberTF.text.length == 0) {
        [self showPromptHUDWithTitle:NSLocalizedString(@"请输入证件号码", nil)];
        return NO;
    }
    return YES;
}

-(void)goNextPage
{
    NSMutableDictionary * mDict = nil;
    if (_imagesDict) {
        mDict = [NSMutableDictionary dictionaryWithDictionary:_imagesDict];
    }else{
        mDict = [NSMutableDictionary dictionary];
    }
    [mDict setObject:_cardNumberTF.text forKey:@"identityNo"];
    [mDict setObject:@(_identityType) forKey:@"identityType"];
    [mDict setObject:_realNameTF.text forKey:@"realName"];
    [mDict setObject:@"iOS" forKey:@"ClientType"];

    SZIdentityPhotosViewController * stepTwoVC = [[SZIdentityPhotosViewController alloc]init];
    stepTwoVC.paraDict = mDict;
    stepTwoVC.identityType=_identityType;
    
    __weak typeof(self)weakSelf = self;
    stepTwoVC.needReEditBlcok = ^(NSDictionary *imagesDict) {
        weakSelf.imagesDict = imagesDict;
    };
    [self.navigationController pushViewController:stepTwoVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
