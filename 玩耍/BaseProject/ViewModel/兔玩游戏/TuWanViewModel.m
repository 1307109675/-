//
//  TuWanViewModel.m
//  BaseProject
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanViewModel.h"

@implementation TuWanViewModel
- (instancetype)initWithType:(InfoType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}
/** 预防性编程，防止没有使用initWithType方法初始化 */
- (id)init
{
    if (self = [super init]) {
        //如果使用此方法初始化，让程序崩溃
        NSAssert1(NO, @"%s 必须使用initWithType初始化", __func__);
    }
    return self;
}
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    _start = 0;
    [self getDataFromNetCompleteHandle:completionHandle];
}
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    _start += 11;
    [self getDataFromNetCompleteHandle:completionHandle];
}
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [TuWanNetManager getTuWanInfoWithType:_type start:_start completionHandle:^(TuWanModel *model, NSError *error) {
        if (_start == 0) {
            [self.dataArr removeAllObjects];
            self.indexPicArr = nil;
        }
        [self.dataArr addObjectsFromArray:model.data.list];
        self.indexPicArr = model.data.indexpic;
        completionHandle(error);
    }];
}
/** 是否有头部滚动栏 */
- (BOOL)isExistIndexPic

{
    return self.indexPicArr != nil && self.indexPicArr.count != 0;
}
/** 行数 */
- (NSInteger)rowNumber
{
    return self.dataArr.count;
}
/** 根据行找到数据 */
- (TuWanDataIndexpicModel *)modelForArr:(NSArray *)arr arr:(NSInteger)row
{
    return arr[row];
}

/** 是否有图，根据showType  0是没有图，1是有图 */
- (BOOL)containImages:(NSInteger)row
{   //等于一的话就是有图
    return [[self modelForArr:self.dataArr arr:row].showtype isEqualToString:@"1"];
}
/** 返回列表中某行数据的标题 */
- (NSString *)titleForRowInList:(NSInteger)row
{
    return [self modelForArr:self.dataArr arr:row].title;
}
/** 返回列表中某行数据的图片 */
- (NSURL *)iconURLForRowInList:(NSInteger)row
{
    return [NSURL URLWithString:[self modelForArr:self.dataArr arr:row].litpic];
}
/** 返回列表中某行数据的描述内容 */
- (NSString *)descForRowInList:(NSInteger)row
{
    return [self modelForArr:self.dataArr arr:row].longtitle;
}
/** 返回列表中某行数据的浏览人数 */
- (NSString *)clicksForRowInList:(NSInteger)row
{
    return [[self modelForArr:self.dataArr arr:row].click stringByAppendingString:@"人浏览"];
}
/** 滚动展示栏的图片 */
- (NSURL *)iconURLForRowInIndexPic:(NSInteger)row
{
    return [NSURL URLWithString:[self modelForArr:self.indexPicArr arr:row].litpic];
}
/** 滚动展示栏的文字 */
- (NSString *)titleForRowInIndexPic:(NSInteger)row
{
    return [self modelForArr:self.indexPicArr arr:row].title;
}
/** 滚动展示栏的图片数量 */
- (NSInteger)indexPicNumber
{
    return self.indexPicArr.count;
}
/** 获取列表中，某行数据对应的html5链接 */
- (NSURL *)detailURLForRowInList:(NSInteger)row
{
    return [NSURL URLWithString:[self modelForArr:self.dataArr arr:row].html5];
}
/** 获取展示栏中，某行数据对应的html5链接 */
- (NSURL *)detailURLForRowInIndexPic:(NSInteger)row
{
    return [NSURL URLWithString:[self modelForArr:self.indexPicArr arr:row].html5];
}
@end
