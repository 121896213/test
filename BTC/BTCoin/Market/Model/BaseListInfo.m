//
//  BaseListInfo.m
//  TestMiaoXianSheng
//
//  Created by tracy on 14-6-8.
//  Copyright (c) 2014年 kedll. All rights reserved.
//

#import "BaseListInfo.h"
#import <zlib.h>

@implementation BaseListInfo

@synthesize idString=_idString;
@synthesize imageurlString=_imageurlString;
@synthesize titleString=_titleString;
@synthesize contentString=_contentString;
@synthesize sizeString=_sizeString;
@synthesize dlnumsString=_dlnumsString;
@synthesize timeString=_timeString;
@synthesize dlpathString=_dlpathString;
@synthesize xmlString=_xmlString;
@synthesize urlString=_urlString;
@synthesize longitudeString=_longitudeString;
@synthesize latitudeString=_latitudeString;
@synthesize sidString=_sidString;
@synthesize ggidString=_ggidString;
@synthesize ggtitleString=_ggtitleString;
@synthesize ggsidString=_ggsidString;
@synthesize ggtypeString=_ggtypeString;
@synthesize ggtypeidString=_ggtypeidString;
@synthesize ggurlString=_ggurlString;
@synthesize weekString=_weekString;
@synthesize dateString=_dateString;
@synthesize priceString=_priceString;
@synthesize juliString=_juliString;
@synthesize addressString=_addressString;
@synthesize baddressString=_baddressString;
@synthesize numsString=_numsString;
@synthesize servicephoneString=_servicephoneString;
@synthesize businessphoneString=_businessphoneString;
@synthesize zkinfoString=_zkinfoString;
@synthesize shopdetailsString=_shopdetailsString;
@synthesize plnumsString=_plnumsString;
@synthesize areaString=_areaString;
@synthesize houseTypeString=_houseTypeString;
@synthesize foundtimeString=_foundtimeString;
@synthesize metroString=_metroString;
@synthesize aroundsubwayString=_aroundsubwayString;
@synthesize webString=_webString;
@synthesize typeString=_typeString;
@synthesize activityTitleString=_activityTitleString;
@synthesize iszk;
@synthesize isselected;
@synthesize classTypeString=_classTypeString;
@synthesize isyuyueString=_isyuyueString;
@synthesize ismore=_ismore;
@synthesize nameString=_nameString;
@synthesize sexString=_sexString;
@synthesize phoneString=_phoneString;
@synthesize bimageurlString=_bimageurlString;
@synthesize posString=_posString;
@synthesize pinYin=_pinYin;
@synthesize loucengString=_loucengString;
@synthesize zxString=_zxString;
@synthesize orientationString=_orientationString;
@synthesize hxString=_hxString;
@synthesize czString=_czString;
@synthesize zbString=_zbString;
@synthesize jtString=_jtString;
@synthesize borkensidString=_borkensidString;
@synthesize isscString=_isscString;
@synthesize zhString=_zhString;
@synthesize rangeString=_rangeString;
@synthesize startString=_startString;
@synthesize endString=_endString;
@synthesize shiString=_shiString;
@synthesize tingString=_tingString;
@synthesize chuString=_chuString;
@synthesize weiString=_weiString;
@synthesize maxNumsString=_maxNumsString;
@synthesize danweiString=_danweiString;
@synthesize subArray=_subArray;
@synthesize isnew=_isnew;
@synthesize baodanString=_baodanString;
@synthesize xiaodanString=_xiaodanString;


- (id)init
{
    if (self=[super init])
    {
        
        _idString=@"";
        _imageurlString=nil;
        _titleString=@"";
        _contentString=@"";
        
        _sizeString=nil;
        _dlnumsString=nil;
        
        _timeString=@"";
        
        _dlpathString=nil;
        
        _xmlString=nil;
        
        _urlString=nil;
        
        _longitudeString=nil;
        
        _latitudeString=nil;
        
        _sidString=nil;
        
        _numsString=@"";
        
        _priceString=@"";
        
        _areaString=@"";
        
        _houseTypeString=@"";
        
        _foundtimeString=@"";
        
        _metroString=@"";
        
        _nameString=@"";
        
        _aroundsubwayString=@"";
        
        _webString=@"";
        
        _typeString=@"";
        
        _activityTitleString=@"";
        
        _subArray=[[NSMutableArray alloc] init];

      


        
    }
    
    return self;
}







- (void)dealloc
{
   
    
    
    
    
    
    
}



@end
