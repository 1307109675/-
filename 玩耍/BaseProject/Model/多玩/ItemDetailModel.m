//
//  ItemDetailModel.m
//  BaseProject
//
//  Created by tarena on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ItemDetailModel.h"

@implementation ItemDetailModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID":@"id",@"desc":@"description"};
}
@end
@implementation ItemDetailExtattrsModel
//属性的首字母，大写转换为变为小写
+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName
{
    return [propertyName firstCharUpper];
}
@end


