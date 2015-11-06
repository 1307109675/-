

#import "BaseModel.h"

@interface HeroVideoModel : BaseModel

@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, strong) NSString *udb;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *uploadTime;
@property (nonatomic, strong) NSString *vid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *letvVideoUnique;
@property (nonatomic, strong) NSString *letvVideoId;
@property (nonatomic, assign) double videoLength;
@property (nonatomic, assign) double totalPage;

@end









