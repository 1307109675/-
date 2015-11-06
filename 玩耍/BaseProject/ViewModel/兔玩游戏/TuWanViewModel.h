//
//  TuWanViewModel.h
//  BaseProject
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "TuWanNetManager.h"

@interface TuWanViewModel : BaseViewModel
/** 必须使用此初始化方法，需要一个类型 */
- (instancetype)initWithType:(InfoType)type;
@property (nonatomic)InfoType type;
/** 行数 */
@property (nonatomic, assign)NSInteger rowNumber;
/** 存放头部滚动栏 */
@property (nonatomic, strong)NSArray *indexPicArr;
/** 是否有头部滚动栏 */
@property (nonatomic, getter=isExistIndexPic)BOOL existIndexPic;
/** 判断某一行数据是否有图 */
- (BOOL)containImages:(NSInteger)row;
/** 返回列表中某行数据的标题 */
- (NSString *)titleForRowInList:(NSInteger)row;
/** 返回列表中某行数据的图片 */
- (NSURL *)iconURLForRowInList:(NSInteger)row;
/** 返回列表中某行数据的描述内容 */
- (NSString *)descForRowInList:(NSInteger)row;
/** 返回列表中某行数据的浏览人数 */
- (NSString *)clicksForRowInList:(NSInteger)row;
/** 滚动展示栏的图片 */
- (NSURL *)iconURLForRowInIndexPic:(NSInteger)row;
/** 滚动展示栏的文字 */
- (NSString *)titleForRowInIndexPic:(NSInteger)row;
/** 滚动展示栏的图片数量 */
@property (nonatomic, assign)NSInteger indexPicNumber;
/** 获取列表中，某行数据对应的html5链接 */
- (NSURL *)detailURLForRowInList:(NSInteger)row;
/** 获取展示栏中，某行数据对应的html5链接 */
- (NSURL *)detailURLForRowInIndexPic:(NSInteger)row;
@property (nonatomic, assign)NSInteger start;
@end
