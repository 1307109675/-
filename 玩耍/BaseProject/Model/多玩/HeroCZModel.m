

#import "HeroCZModel.h"

@implementation HeroCZModel

+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName{
//    驼峰转下划线（loveYou -> love_you）
    return [propertyName underlineFromCamel];
}

@end