//
//  MarketParseSocketData.m
//  99Gold
//
//  Created by Robin on 12/23/16.
//  Copyright © 2016 xia zhonglin . All rights reserved.
//

#import "MarketParseSocketData.h"
#import "ICBCDataItems.h"
#import "ICBCHQDataItems.h"
#import "DCInterface.h"
#import "MarketDataUtil.h"
#import "NSDate+Util.h"

@implementation MarketParseSocketData {
    NSLock * interestLock;
}

DEFINE_SINGLETON_FOR_CLASS(MarketParseSocketData)

- (instancetype)init {
    if (self = [super init]) {
        interestLock = [[NSLock alloc] init];
    }
    
    return self;
}

- (void)parseCLIENTTYPE_TYPELIST:(NSData *)data Block:(void(^)(TYPELIST_RES * resHead, NSArray * array))block {
    
    if (data == nil && block) {
        block(nil,nil);
    }
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    BYTE *startByte=(BYTE *)[data bytes];
    CMDHEAD *phead=(CMDHEAD *)(startByte);
    
    TYPELIST_RES *resHead=(TYPELIST_RES *)(phead+1);
    char* p = (char*)(resHead+1);
    
    if(resHead->m_nAttr&LISTATTR_STATIC)
    {
        for (int i=0; i<resHead->m_nNum; i++)
        {
            SEC_DYNA *s_dyna;
            SEC_STATIC *s_static;
            WORD *word;
            
            s_static=(SEC_STATIC*)(p+i*(sizeof(WORD)+sizeof(SEC_STATIC)+sizeof(SEC_DYNA))+sizeof(WORD));
            s_dyna=(SEC_DYNA*)(p+i*(sizeof(WORD)+sizeof(SEC_STATIC)+sizeof(SEC_DYNA))+sizeof(WORD)+sizeof(SEC_STATIC));
            word=(WORD*)(p+i*(sizeof(WORD)+sizeof(SEC_STATIC)+sizeof(SEC_DYNA)));
            
            
            NSString *code=[NSString stringWithUTF8String:s_static->m_strLabel];
            NSString *name=[NSString stringWithUTF8String:s_static->m_strUtf8Name];
            
            //自定义字符串 长度+内容 取得时候去掉长度
            if (code.length>0)
            {
                
                code=[code substringFromIndex:1];
                
            }
            if (name.length>0)
            {
                name=[name substringFromIndex:1];
                
            }
            
            StkDynaData *info=[[StkDynaData alloc] init];
            info.code=code;
            info.name=name;
            info->tradingUnit=s_static->m_nPriceDigit;
            
            
            info->newPrice=s_dyna->m_dwNew/pow(10,s_static->m_nPriceDigit);
            info->dynaTime=s_dyna->m_time;
            info->market=*word;
            info->preClosePrice = s_static->m_dwLastClose/pow(10,s_static->m_nPriceDigit);
            if (s_static->m_cType==FUTURE || s_static->m_cType==FTR_IDX || s_static->m_cType==COMM)
            {
                
                
                info->preClosePrice=((SInt64)(s_static->m_mTotalIssued))/pow(10,s_static->m_nPriceDigit);
            }
            else
            {
                info->preClosePrice=s_static->m_dwLastClose/pow(10,s_static->m_nPriceDigit);
            }
            
            if (s_static->m_mTotalIssued==0)
            {
                info->preClosePrice=s_static->m_dwLastClose/pow(10,s_static->m_nPriceDigit);
            }
            [array addObject:info];
        }
    }
    
    if (block) {
        block(resHead,array);
    }
}

#pragma mark - 成交明细
+ (NSMutableArray *)parseCLIENTTYPE_CJMX:(NSData *)data tradingUnit:(int)tradingUnit {
    if (data == nil) {
        return nil;
    }
    
    BYTE *startByte=(BYTE *)[data bytes];
    CMDHEAD *phead=(CMDHEAD *)(startByte);
    CJMX_RES *resHead=(CJMX_RES *)(phead+1);
    char* p = (char*)(resHead+1);
    
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:20];
    for (int i=0; i<resHead->m_nNum; i++)
    {
        CJMX* pZs;
        pZs=(CJMX*)(p+i*sizeof(CJMX));
        
        ICBCHQDataItems *items=[[ICBCHQDataItems alloc] init];
        NSString* time=[NSDate changeTimeStyle:pZs->m_time];
        if (pZs->m_dwPrice&0x80000000)
        {
            items.isBuy=1;
        }
        else
        {
            items.isBuy=0;
        }
        
        items.nameStr=time;
        items.buyPrice=[MarketDataUtil priceDecimalBitNum:tradingUnit price:(pZs->m_dwPrice&0x7FFFFFFF)/pow(10,tradingUnit)];
        items.buyVolume=[NSString stringWithFormat:@"%lld",(SInt64)pZs->m_mVolume];
        [array addObject:items];
    }
    
    return array;
}

/*动态数据**/
#pragma mark - 动态数据
- (void)parseCLIENTTYPE_INTEREST:(NSData *)data block:(void(^)(NSArray *  tradeTimeIndexArray, NSArray * stkDynaDataArray,NSArray * wdDataArray))block {
    
    [interestLock lock];
    if (data == nil) {
        if (block) {
            block(nil,nil,nil);
        }
        return ;
    }
    
    try {
        BYTE *startByte=(BYTE *)[data bytes];
        int len = sizeof(BYTE);
        CMDHEAD *phead=(CMDHEAD *)(startByte);
        INTEREST_RES *resHead=(INTEREST_RES *)(phead+1);
        
        NSMutableArray * tradeTimeIndexArray = [NSMutableArray arrayWithCapacity:resHead->m_nNum];
        NSMutableArray * stkArray = [NSMutableArray arrayWithCapacity:resHead->m_nNum];
        NSMutableArray * wdArray=[NSMutableArray arrayWithCapacity:resHead->m_nNum];
        
        char* p = (char*)(resHead+1);
        
        if(resHead->m_nAttr&LISTATTR_STATIC)
        {
            for (int i=0; i<resHead->m_nNum; i++)
            {
                //ASEC_INDEX_DYNA
                SEC_DYNA *s_dyna;
                SEC_STATIC *s_static;
                
                s_static=(SEC_STATIC*)(p+i*(len+sizeof(SEC_STATIC)+sizeof(SEC_DYNA))+len);
                
                s_dyna=(SEC_DYNA*)(p+i*(len+sizeof(SEC_STATIC)+sizeof(SEC_DYNA))+len+sizeof(SEC_STATIC));
                
                [tradeTimeIndexArray addObject:@(s_static->m_nTradeTime)];
                
                NSString *code=[NSString stringWithUTF8String:s_static->m_strLabel];
                NSString *name=[NSString stringWithUTF8String:s_static->m_strUtf8Name];
                
                //自定义字符串 长度+内容 取得时候去掉长度
                if (code.length>0)
                {
                    code=[code substringFromIndex:1];
                }
                
                if (name.length>0)
                {
                    name=[name substringFromIndex:1];
                }
                
                StkDynaData *info=[[StkDynaData alloc] init];
                info.code=code;
                info.name=name;
                info->tradingUnit=s_static->m_nPriceDigit;
                
                info->preClosePrice=s_static->m_dwLastClose/pow(10,s_static->m_nPriceDigit);
                info->newPrice=s_dyna->m_dwNew/pow(10,s_static->m_nPriceDigit);
                info->dynaTime=s_dyna->m_time;
                info->highPrice=s_dyna->m_dwHigh/pow(10,s_static->m_nPriceDigit);
                info->lowPrice=s_dyna->m_dwLow/pow(10,s_static->m_nPriceDigit);
                info->volume=s_dyna->m_mVolume;
                info->amount=s_dyna->m_mAmount;
                info->openPrice=s_dyna->m_dwOpen/pow(10,s_static->m_nPriceDigit);
                info->m_mFloatIssued=s_static->m_mFloatIssued;
                info->dynaTime=s_dyna->m_time;
                info->openInterest = s_dyna->m_dwOpenInterest;
                info->lastOpenInterest = s_static->m_mFloatIssued.GetValue();
                info->m_mInnerVol = s_dyna->m_mInnerVol;
                info->m_mTotalIssued = s_static->m_mTotalIssued.GetValue();
                info->m_mNowVol = s_dyna->m_mNowVol.GetValue();
                info->preSettlementPrice = ((INT64)s_static->m_mTotalIssued)/pow(10,s_static->m_nPriceDigit);
                [stkArray addObject:info];
                
                NSMutableArray * array = [NSMutableArray arrayWithCapacity:10];
                //五档数据
                for (int j=4; j>=0; j--)
                {
                    ICBCHQDataItems *item=[[ICBCHQDataItems alloc] init];
                    
                    item.buyPrice=[MarketDataUtil priceDecimalBitNum:s_static->m_nPriceDigit price:(double)s_dyna->m_dwSellPrice[j]/pow(10,s_static->m_nPriceDigit)];
                    item.buyVolume=[NSString stringWithFormat:@"%d",s_dyna->m_dwSellVol[j]];
                    
                    [array addObject:item];
                    
                }
                
                for (int j=0; j<5; j++)
                {
                    ICBCHQDataItems *item =[[ICBCHQDataItems alloc] init];
                    
                    item.buyPrice=[MarketDataUtil priceDecimalBitNum:s_static->m_nPriceDigit price:(double)s_dyna->m_dwBuyPrice[j]/pow(10,s_static->m_nPriceDigit)];
                    item.buyVolume=[NSString stringWithFormat:@"%d",s_dyna->m_dwBuyVol[j]];
                    [array addObject:item];
                }
                
                [wdArray addObject:array];
                
                if (block) {
                    block(tradeTimeIndexArray,stkArray,wdArray);
                }
            }
        }
    } catch (NSException * exception) {
        NSLog(@"%s, %@",__func__,[exception debugDescription]);
    }
    
    [interestLock unlock];
}

/*走势**/
#pragma mark - 走势
+ (void)parseCLIENTTYPE_ZS:(NSData *)data stkDynaData:(StkDynaData *)baseInfo block:(void(^)(NSArray * zsArray))block {
    if (data == nil) {
        if (block) {
            block(nil);
        }
        return ;
    }
    
    try {
        float _frontNewPrice = 0.0; //上一个最新价
        SInt64 _frontZVolume = 0;  //最后一条的增量
        SInt64 _frontZAmount = 0;  //最后一条的增量
        int _frontZPrice = 0;//上一个价格
        
        BYTE *startByte=(BYTE *)[data bytes];
        CMDHEAD *phead=(CMDHEAD *)(startByte);
        ZS_RES* resHead = (ZS_RES*)(phead+1);
        
        char* p = (char*)(resHead+1);
        NSMutableArray * zsMutableArray = [NSMutableArray arrayWithCapacity:resHead->m_nNum];
        
        for (int i=0; i<resHead->m_nNum; i++) {
            MIN_ZS* pZs;
            pZs=(MIN_ZS*)(p+i*sizeof(MIN_ZS));
            
            StkKLineData *data=[[StkKLineData alloc] init];
            [zsMutableArray addObject:data];
            data->ktime=resHead->m_time;
            data->openPrice=baseInfo->openPrice;
            data->highPrice=0;
            data->lowPrice=0;
            data->closePrice=pZs->m_dwPrice/pow(10,baseInfo->tradingUnit);
            data->openInterest=0;
            
            if (i == 0)
            {
                data->volume=pZs->m_mVolume;
                _frontZVolume=data->volume;
                
                //对价格为0 特殊处理
                if (data->closePrice==0)
                {
                    data->closePrice = baseInfo->preClosePrice;
                }
                
                _frontNewPrice=data->closePrice;
            } else if (i>0 && i<resHead->m_nNum)
            {
                if (0 == pZs->m_mVolume) {
                    data->volume = 0;
                } else {
                    data->volume=(SInt32)pZs->m_mVolume - _frontZVolume;
                    _frontZVolume=pZs->m_mVolume;
                }
                
                //对价格为0 特殊处理
                if (data->closePrice==0)
                {
                    data->closePrice=_frontNewPrice;
                }
                
                _frontNewPrice=data->closePrice;
            }
            
            if (i==0)
            {
                data->amount=pZs->m_mAmount;
                _frontZAmount=data->amount;
            }
            else if (i>0 && i<resHead->m_nNum)
            {
                data->amount = (SInt64)pZs->m_mAmount - _frontZAmount;
                _frontZAmount = (SInt64)pZs->m_mAmount;
            }
            
            //成交量颜色
            if (i==0)
            {
                _frontZPrice=pZs->m_dwPrice;
                
            }
            else if (i>0 && i<resHead->m_nNum)
            {
                int cz=pZs->m_dwPrice-_frontZPrice;
                if (cz<0)
                {
                    data->flag=2;
                }
                else if (cz>0)
                {
                    data->flag=1;
                }
                else
                {
                    data->flag=0;
                }
                
                _frontZPrice=pZs->m_dwPrice;
            }
        }
        
        if (block) {
            block(zsMutableArray);
        }
    } catch (NSException * exception) {
        NSLog(@"%s, %@",__func__,[exception debugDescription]);
    }
}

/*K线**/
+ (NSMutableArray *)parseCLIENTTYPE_KLINE:(NSData *)data stkDynaData:(StkDynaData *)baseInfo {
    if (data == nil) {
        return nil;
    }
    
    BYTE *startByte=(BYTE *)[data bytes];
    CMDHEAD *phead=(CMDHEAD *)(startByte);
    KLINE_RES* resHead = (KLINE_RES*)(phead+1);
    
    NSMutableArray * kMutableArray = [NSMutableArray arrayWithCapacity:resHead->m_nNum];
    
    char* p = (char*)(resHead+1);
    
    for (int i=0; i<resHead->m_nNum; i++)
    {
        KLINE* pData;
        
        pData=(KLINE*)(p+i*sizeof(KLINE));
        
        StkKLineData * kData = [[StkKLineData alloc] init];
        kData->ktime=pData->m_time;
        kData->openPrice=pData->m_dwOpen/pow(10,baseInfo->tradingUnit);
        kData->closePrice=pData->m_dwClose/pow(10,baseInfo->tradingUnit);
        kData->highPrice=pData->m_dwHigh/pow(10,baseInfo->tradingUnit);
        kData->lowPrice=pData->m_dwLow/pow(10,baseInfo->tradingUnit);
        kData->volume=pData->m_mVolume;
        kData->amount=pData->m_mAmount;
        kData->openInterest =pData->m_dwOpenInterest;//持仓量
        kData->settlePrice =pData->m_dwSettlePrice;//结算价
        kData->tradingUnit=baseInfo->tradingUnit;
        
        [kMutableArray addObject:kData];
    }
    
    return kMutableArray;
}

@end
