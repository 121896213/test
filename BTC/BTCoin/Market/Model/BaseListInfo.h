//
//  BaseListInfo.h
//  TestMiaoXianSheng
//
//  Created by tracy on 14-6-8.
//  Copyright (c) 2014年 kedll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseListInfo : NSObject
{

    
    
    NSString *_idString;
    
    NSString *_imageurlString;
    
    NSString *_titleString;
    
    NSString *_contentString;

    NSString *_sizeString;
    
    NSString *_dlnumsString;
    
    NSString *_timeString;
    
    NSString *_dlpathString;
    
    NSString *_xmlString;
    
    NSString *_urlString;
    
    NSString *_sidString;

    NSString *_longitudeString;   //经度
    
    NSString *_latitudeString;    //纬度
    
    NSString *_ggtypeidString;
    NSString *_ggidString;
    NSString *_ggsidString;
    NSString *_ggtypeString;
    NSString *_ggtitleString;
    NSString *_ggurlString;
    
    NSString *_weekString;
    
    NSString *_dateString;
    
    NSString *_priceString;

    NSString *_juliString;
    

    NSString *_numsString;
    
    NSString *_servicephoneString;  //服务

    NSString *_businessphoneString;  //商业
    
    
    NSString *_zkinfoString;  //折扣信息

    NSString *_shopdetailsString;  //商店详情信息
    
    NSString *_plnumsString;
    
    NSString *_areaString;  //面积


    NSString *_houseTypeString;  //房屋类型
    
    NSString *_foundtimeString;  //活动时间
    
    
    NSString *_metroString;  //路程

    NSString *_aroundsubwayString;  //周围的地铁
    
    NSString *_webString;  //网站
    
    
    NSString *_typeString;  //类型

    
    NSString *_activityTitleString;  //活动标题

    BOOL iszk;  //是否有相关活动

    BOOL isselected;
    
    
    NSString *_classTypeString;
    
    NSString *_nameString;
    NSString *_sexString;
    
    NSString *_phoneString;
    
    NSString *_addressString;
    
    NSString *_baddressString;
    
    NSString *_isyuyueString;
    
    NSString *_bimageurlString;

    NSString *_posString;  //位置

    NSString *_pinYin;
    
    NSString *_loucengString;   //楼层

    NSString *_zxString;   //装修
    
    NSString *_orientationString;  //房子位置
    
    NSString *_hxString;   //户型
    
    NSString *_czString;   //出租方式
    
    NSString *_zbString;   //周边配套
    
    NSString *_jtString;   //交通配套
    
    
    NSString *_borkensidString;  //所属经纪人sid
    

    NSString *_isscString;  //是否收藏
    
    NSString *_zhString;     //组合贷款
    
    NSString *_rangeString;   //直径
    
    NSString *_startString;   //

    NSString *_endString;
    
    NSString *_shiString;  //室
    
    NSString *_tingString;

    NSString *_chuString;

    NSString *_weiString;

    NSString *_maxNumsString;

    NSString *_danweiString;
    
    NSString *_baodanString;
    NSString *_xiaodanString;


    BOOL _ismore;

    BOOL _isnew;

    
    NSMutableArray *_subArray;

}


@property(copy,nonatomic) NSString *idString;
@property(copy,nonatomic) NSString *imageurlString;
@property(copy,nonatomic) NSString *titleString;
@property(copy,nonatomic) NSString *contentString;
@property(copy,nonatomic) NSString *sizeString;
@property(copy,nonatomic) NSString *dlnumsString;
@property(copy,nonatomic) NSString *timeString;
@property(copy,nonatomic) NSString *dlpathString;
@property(copy,nonatomic) NSString *xmlString;
@property(copy,nonatomic) NSString *urlString;
@property(copy,nonatomic) NSString *longitudeString;
@property(copy,nonatomic) NSString *latitudeString;
@property(copy,nonatomic) NSString *sidString;
@property(copy,nonatomic) NSString *ggidString;
@property(copy,nonatomic) NSString *ggsidString;
@property(copy,nonatomic) NSString *ggtypeString;
@property(copy,nonatomic) NSString *ggtitleString;
@property(copy,nonatomic) NSString *ggtypeidString;
@property(copy,nonatomic) NSString *ggurlString;
@property(copy,nonatomic) NSString *weekString;
@property(copy,nonatomic) NSString *dateString;
@property(copy,nonatomic) NSString *priceString;
@property(copy,nonatomic) NSString *juliString;
@property(copy,nonatomic) NSString *addressString;
@property(copy,nonatomic) NSString *baddressString;

@property(copy,nonatomic) NSString *numsString;
@property(copy,nonatomic) NSString *servicephoneString;
@property(copy,nonatomic) NSString *businessphoneString;
@property(copy,nonatomic) NSString *zkinfoString;
@property(copy,nonatomic) NSString *shopdetailsString;
@property(copy,nonatomic) NSString *plnumsString;

@property(copy,nonatomic) NSString *areaString;
@property(copy,nonatomic) NSString *houseTypeString;
@property(copy,nonatomic) NSString *foundtimeString;
@property(copy,nonatomic) NSString *metroString;
@property(copy,nonatomic) NSString *aroundsubwayString;
@property(copy,nonatomic) NSString *webString;
@property(copy,nonatomic) NSString *typeString;
@property(copy,nonatomic) NSString *activityTitleString;
@property(copy,nonatomic) NSString *classTypeString;
@property(copy,nonatomic) NSString *isyuyueString;
@property(assign,nonatomic) BOOL ismore;
@property(copy,nonatomic) NSString *nameString;
@property(copy,nonatomic) NSString *sexString;
@property(copy,nonatomic) NSString *phoneString;

@property(copy,nonatomic) NSString *bimageurlString;
@property(copy,nonatomic) NSString *posString;

@property(nonatomic, copy) NSString *pinYin;

@property(nonatomic, copy) NSString *loucengString;

@property(nonatomic, copy) NSString *zxString;

@property(nonatomic, copy) NSString *orientationString;

@property(nonatomic, copy) NSString *hxString;
@property(nonatomic, copy) NSString *czString;
@property(nonatomic, copy) NSString *zbString;
@property(nonatomic, copy) NSString *jtString;
@property(nonatomic, copy) NSString *borkensidString;
@property(nonatomic, copy) NSString *isscString;

@property(nonatomic, copy) NSString *zhString;

@property(nonatomic, copy) NSString *rangeString;
@property(nonatomic, copy) NSString *startString;
@property(nonatomic, copy) NSString *endString;
@property(nonatomic, copy) NSString *shiString;
@property(nonatomic, copy) NSString *tingString;
@property(nonatomic, copy) NSString *chuString;
@property(nonatomic, copy) NSString *weiString;
@property(nonatomic, copy) NSString *maxNumsString;
@property(nonatomic, copy) NSString *danweiString;

@property(nonatomic, copy) NSString *baodanString;
@property(nonatomic, copy) NSString *xiaodanString;
@property(nonatomic, copy) NSString *zdfString;
@property(nonatomic, copy) NSString *codeString;
@property(nonatomic, copy) NSString *marketString;



@property(strong,nonatomic) NSMutableArray *subArray;


@property(assign,nonatomic) BOOL isnew;

@property(assign,nonatomic) BOOL iszk;

@property(assign,nonatomic) BOOL isselected;


@end
