
#import "DuoWanNetManager.h"
//很多具有共同点的东西，可以统一宏定义比如(凡是自己写的宏定义，都需要k开头，这是编码习惯)
//如果宏命令超长需要换行，只需要在换行位置添加 \ 即可， 最后一行不用加

#define kOSType    @"OSType":[@"iOS" stringByAppendingString\
:[UIDevice currentDevice].systemVersion]      //获取当前系统的版本号

#define kVersionName    @"versionName":@"2.4.0"
#define kV              @"v": @140

#define kChangeKey(key)    [dic setObject:[dic objectForKey:[enName stringByAppendingString:key]]\
forKey:[@"desc" stringByAppendingString:key]];\
[dic removeObjectForKey:[enName stringByAppendingString:key]]


//把path写到文件头部，使用宏定义形势，方便后期维护
#import "DuoWanRequestPath.h"
//把所有路径的宏定义都封装到DuoWanRequestPath.h文件中，不然太多东西放在头部，太乱
@implementation DuoWanNetManager
//免费英雄  和  全部英雄
+ (id)getHeroWithType:(HeroType)type completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{kOSType, kV}];
    switch (type) {
        case HeroTypeFree:
            [params setObject:@"free" forKey:@"type"];
            break;
        case HeroTypeAll:
            [params setObject:@"all" forKey:@"type"];
            break;
        default:
            NSAssert1(NO, @"%s:type类型不正确", __func__);
            break;
    }
    return [self GET:kHeroPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        switch (type) {
            case HeroTypeFree:
                completionHandle([FreeHeroModel objectWithKeyValues:responseObj], error);
                break;
            case HeroTypeAll:
                completionHandle([AllHeroModel objectWithKeyValues:responseObj], error);
                break;
            default:
                completionHandle(nil, error);
                break;
        }
    }];
}
//英雄皮肤
+ (id)getHeroSkinsWithHeroName:(NSString *)heroName completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"hero":heroName,kV,kOSType,kVersionName}];
    return [self GET:kHeroSkinPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroSkinModel objectArrayWithKeyValuesArray:responseObj], error);
    }];
}
//英雄配音
+ (id)getHeroSoundsWithHeroName:(NSString *)heroName completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"hero":heroName, kV,kOSType, kVersionName}];
    return [self GET:kHeroSoundPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        //Json数据就是标准数组，不需要解析
        completionHandle(responseObj, error);
    }];
}
//视频
+ (id)getHeroVideosWithPage:(NSInteger)page tag:(NSString *)enName completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kHeroVideoPath parameters:@{kVersionName, kOSType, @"action": @"l", @"p": @(page), @"src": @"letv", @"tag": enName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroVideoModel objectArrayWithKeyValuesArray:responseObj], error);
    }];
}
//出装
+ (id)getHeroCZWithHeroName:(NSString *)enName completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{kV,kOSType,@"championName":enName,@"limit":@(7)}];
    return [self GET:kHeroCZPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroCZModel objectArrayWithKeyValuesArray:responseObj], error);
    }];
}
//资料
+ (id)getHeroDetailWithHeroName:(NSString *)enName completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kHeroDetailPath parameters:@{kV, kOSType, @"heroName": enName} completionHandler:^(NSDictionary * responseObj, NSError *error) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObj];
        //解决英雄详情接口，不同英雄名称导致Q W E R B 数据key不同的问题。 解决方案是替换掉 返回值中的  Q W E R B 键
        kChangeKey(@"_Q");
        kChangeKey(@"_R");
        kChangeKey(@"_W");
        kChangeKey(@"_B");
        kChangeKey(@"_E");
        completionHandle([HeroDetailModel objectWithKeyValues:dic], error);
    }];
}

//天赋符文
+ (id)getHeroGiftAndRunWithHeroName:(NSString *)enName completionHandle:(void (^)(id, NSError *))completionHandle
{
    return [self GET:kGiftAndRunPath parameters:@{@"hero":enName,kV, kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroGiftModel objectArrayWithKeyValuesArray:responseObj], error);
    }];
            
}
//英雄改动
+ (id)getHeroInfoWithHeroName:(NSString *)enName completionHandle:(void (^)(id, NSError *))completionHandle
{
    return [self GET:kHeroInfoPath parameters:@{@"name":enName, kV, kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroChangeModel objectWithKeyValues:responseObj], error);
    }];
}
//一周数据
+ (id)getWeekDataWithHeroId:(NSInteger)championId completionHandle:(void (^)(id, NSError *))completionHandle
{
    return [self GET:kHeroWeekDataPath parameters:@{@"heroId":@(championId)} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroWeekDataModel objectWithKeyValues:responseObj], error);
    }];
}
//游戏百科列表
+ (id)getToolMenuCompletionHandle:(void (^)(id, NSError *))completionHandle
{
    return [self GET:kToolMenuPath parameters:@{@"category":@"database", kV,kOSType, kVersionName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ToolMenuModel objectArrayWithKeyValuesArray:responseObj], error);
    }];
}
//装备分类
+ (id)getZBCategoryWithCompletionHandle:(void (^)(id, NSError *))completionHandle
{
    return [self GET:kZBCategoryPath parameters:@{kV, kOSType,kVersionName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ZBCategoryModel objectArrayWithKeyValuesArray:responseObj], error);
    }];
}
+ (id)getZBItemListWithTag:(NSString *)tag completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kZBItemListPath parameters:@{@"tag": tag, kV, kOSType, kVersionName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ZBItemModel objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

+ (id)getItemDetailWithItemId:(NSInteger)itemId completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kItemDetailPath parameters:@{kV, kOSType, @"id": @(itemId)} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ItemDetailModel objectWithKeyValues:responseObj], error);
    }];
}
//天赋
+ (id)getGIftCompletionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kGiftPath parameters:@{kV, kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([GiftModel objectWithKeyValues:responseObj], error);
    }];
}
//符文
+ (id)getRunesCompletionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kRunesPath parameters:@{kV, kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([RuneModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getSumAbilityCompletionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kSumAbilityPath parameters:@{kV, kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([SumAbilityModel objectWithKeyValues:responseObj], error);
    }];
}
//最佳阵容
+ (id)getHeroBestGroupCompletionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kBestGroupPath parameters:@{kV, kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([BestGroupModel objectArrayWithKeyValuesArray:responseObj], error);
    }];
}@end
