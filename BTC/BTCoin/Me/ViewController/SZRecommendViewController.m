//
//  SZRecommendViewController.m
//  BTCoin
//
//  Created by sumrain on 2018/6/21.
//  Copyright © 2018年 LionIT. All rights reserved.
//

#import "SZRecommendViewController.h"
#import "SZWithdrawAddressCell.h"
#import "SZRecommendRecordViewController.h"
#import "SZRecommendRewardViewController.h"
#import "SZMineRecommendViewController.h"
#import "AVCaptureSessionManager.h"

@interface SZRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  UIImageView* QRCodeImageView;
@property (nonatomic,strong)  UITableView* tableView;
@property (nonatomic,strong)  NSArray* dataArr;
@property (nonatomic,strong)  UIButton* shareBtn;
@property (nonatomic,strong)  UIImageView* imageView;
@end

@implementation SZRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:NSLocalizedString(@"推荐好友", nil)];
//    UIButton* rightBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, FIT3(120), 44)];
//    [rightBtn setImage:[UIImage imageNamed:@"recommend_share"] forState:UIControlStateNormal];
//    self.shareBtn=rightBtn;
//    [self setRightBtn:rightBtn];
    
//    UIView* headerView=[UIView new];
//    headerView.backgroundColor=UIColorFromRGB(0xFFFFFF);
//    [self.view addSubview:headerView];
//    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(NavigationStatusBarHeight);
//
//    }];
//
    
    UILabel* notictLab=[UILabel new];
    notictLab.text=NSLocalizedString(@"长按图片保存到相册", nil);
    notictLab.font=[UIFont systemFontOfSize:FIT(12.0f)];
    notictLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:notictLab];
    [notictLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationStatusBarHeight);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(notictLab.font.lineHeight);
        make.right.left.mas_equalTo(0);
    }];
    
    
    
    UIImageView* imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"recommend_background"]];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    self.imageView=imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(notictLab.mas_bottom);
        make.height.mas_equalTo(FIT3(1400));
        make.width.mas_equalTo(ScreenWidth);

    }];
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] init];
    [self.imageView addGestureRecognizer:tap];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        
        [AVCaptureSessionManager checkAuthorizationStatusForPhotoLibraryWithGrantBlock:^{
            if ([tap state] == UIGestureRecognizerStateBegan) {
                [self showLoadingMBProgressHUD];
                self.imageView.userInteractionEnabled=NO;
                UIImageWriteToSavedPhotosAlbum([self snapshotSingleView:self.imageView],self,@selector(image:didFinishSavingWithError:contextInfo:),(__bridge void*)self);
            }else if([tap state] == UIGestureRecognizerStateEnded){
                self.imageView.userInteractionEnabled=YES;
            }
        } DeniedBlock:^{
            UIAlertAction *aciton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"权限未开启" message:@"您未开启相册权限，点击确定跳转至系统设置开启" preferredStyle:UIAlertControllerStyleAlert];
            [controller addAction:aciton];
            [self presentViewController:controller animated:YES completion:nil];
        }];
     
        
    }];
    
    
    UIView* QRCodeView=[UIView new];
    [imageView addSubview:QRCodeView];
    QRCodeView.backgroundColor=[UIColor whiteColor];
    [QRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT3(516));
        make.height.mas_equalTo(FIT3(516));
        make.centerX.equalTo(imageView.mas_centerX);
        make.centerY.equalTo(imageView.mas_centerY).offset(FIT3(90));

    }];
    [ShareFunction setCircleBorder:QRCodeView];
    
    UIImageView* QRCodeImageView=[UIImageView new];
    [QRCodeImageView setImage:[self creatCIQRCodeImage:[RecommendUrl  stringByAppendingString:[UserInfo sharedUserInfo].appLoginName]]];
    [QRCodeView addSubview:QRCodeImageView];
    self.QRCodeImageView=QRCodeImageView;
    [QRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(FIT3(400));
        make.centerX.equalTo(QRCodeView.mas_centerX);
        make.centerY.equalTo(QRCodeView.mas_centerY);
        
    }];

    self.dataArr=@[@[NSLocalizedString(@"我的推荐", nil),NSLocalizedString(@"推荐奖励明细", nil),NSLocalizedString(@"推荐奖励规则", nil)]];
//    self.dataArr=@[@[NSLocalizedString(@"我的推荐", nil),NSLocalizedString(@"推荐奖励明细", nil)]];

    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationStatusBarHeight, ScreenWidth, ScreenHeight-NavigationStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerClass:[SZWithdrawAddressCell class] forCellReuseIdentifier:SZWithdrawAddressCellReuseIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=MainBackgroundColor;
    self.tableView.rowHeight=FIT3(146);
    self.tableView.estimatedRowHeight=150.0f;
    self.tableView.scrollEnabled=NO;
    self.tableView.bounces=NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(imageView.mas_bottom);
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SZWithdrawAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:SZWithdrawAddressCellReuseIdentifier forIndexPath:indexPath];
    cell.coinTypeLab.text=self.dataArr[indexPath.section][indexPath.row];
    cell.coinTypeCountLab.text=@"";

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIViewController* VC;
    if (indexPath.row == 0) {
        VC=[SZMineRecommendViewController new];
    }else if (indexPath.row ==1){
        VC=[SZRecommendRecordViewController new];
    }else{
        VC=[SZRecommendRewardViewController new];

    }
    [self.navigationController pushViewController:VC animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FIT3(48);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    static NSString *reuseId = @"sectionHeader";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (!headerView) {
        headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseId];
        UIView* subFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, headerView.height)];
        subFootView.backgroundColor=MainBackgroundColor;
        [headerView addSubview:subFootView];
    }
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIImage *)snapshotSingleView:(UIView *)view
{
    CGRect rect =  view.frame;
    UIGraphicsBeginImageContextWithOptions(rect.size,YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [self showErrorHUDWithTitle:@"保存成功"];    
}
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
