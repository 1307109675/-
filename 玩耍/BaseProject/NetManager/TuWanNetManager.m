//
//  TuWanNetManager.m
//  BaseProject
//
//  Created by tarena on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanNetManager.h"
//http://cache.tuwan.com/app/?appid=1&classmore=indexpic&appid=1&appver=2.1
#define kTuWanPath  @"http://cache.tuwan.com/app/"
#define kAppId      @"appid": @1
#define kAppVer     @"appver": @2.1
#define kClassMore  @"classmore":@"indexpic"

//定义成宏，防止哪天服务器人员改动，突然改动所有的dtid键为tuwanID   我们只需要改变宏中的字符串就可以
#define kRemoveClassMore(dic)    [dic removeObjectForKey:@"classmore"]
#define kSetDtId(string, dic)    [dic setObject:string forKey:@"dtid"]
#define kSetClass(string, dic)   [dic setObject:string forKey:@"class"]
#define kSetMod(string, dic)     [dic setObject:string forKey:@"mod"]


@implementation TuWanNetManager
//只要公用一个解析类的请求，就可以合起来写。只需要使用枚举变量，来决定不同的请求地址即可（汽车之家）
+ (id)getTuWanInfoWithType:(InfoType)type start:(NSInteger)start completionHandle:(void (^)(TuWanModel *, NSError *))completionHandle
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{kAppVer, kAppId,@"start":@(start), kClassMore}];
    switch (type) {
        case InfoTypeTouTiao:
        
            break;
        case InfoTypeDuJia:
            kRemoveClassMore(params);
            kSetClass(@"heronews", params);
            kSetMod(@"八卦",params);
            break;
            
        case InfoTypeAnHei3:
            kSetDtId(@"83623", params);
            break;
            
        case InfoTypeMoShou:
            kSetDtId(@"31537", params);
            break;
            
        case InfoTypeFengBao:
            kSetDtId(@"31538", params);
            break;
            
        case InfoTypeLuShi: {
            kSetDtId(@"31528", params);
            break;
        }

        case InfoTypeXingJi2:
            kRemoveClassMore(params);
            kSetDtId(@"91821", params);
            break;
            
        case InfoTypeShouWang:
            kRemoveClassMore(params);
            kSetDtId(@"57067", params);
            break;
            
        case InfoTypeTuPian:
            kRemoveClassMore(params);
            [params setObject:@"pic" forKey:@"type"];
            kSetDtId(@"83623,31528,31537,31538,57067,91821", params);
            break;
            
        case InfoTypeShiPin:
            kRemoveClassMore(params);
            [params setObject:@"video" forKey:@"type"];
            kSetDtId(@"83623,31528,31537,31538,57067,91821", params);
            break;
            
        case InfoTypeGongLue:
            kRemoveClassMore(params);
            [params setObject:@"guide" forKey:@"type"];
            kSetDtId(@"83623,31528,31537,31538,57067,91821", params);
            break;
            
        case InfoTypeHuanHua:
            kRemoveClassMore(params);
            kSetClass(@"heronews", params);
            kSetMod(@"幻化", params);
            break;
            
        case InfoTypeQuWen:
            kSetDtId(@"1", params);
            kSetClass(@"heronews", params);
            kSetMod(@"趣闻", params);
            break;
            
        case InfoTypeCOS:
            kSetClass(@"cos", params);
            kSetMod(@"cos", params);
            kSetDtId(@"0", params);
            break;
            
        case InfoTypeMeiNv:
            kSetClass(@"heronews", params);
            kSetMod(@"美女", params);
            [params setObject:@"cos1" forKey:@"typechild"];
            break;
        
        default:
            NSAssert1(NO, @"%s:type类型不正确", __func__);
            break;
    }
    NSString *path = [self percentPathWithPath:kTuWanPath params:params];
    return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([TuWanModel objectWithKeyValues:responseObj], error);
    }];
}
@end
