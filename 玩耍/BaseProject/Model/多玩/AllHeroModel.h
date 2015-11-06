

#import "BaseModel.h"

@class AllHeroAllModel;
@interface AllHeroModel : BaseModel

@property (nonatomic, strong) NSArray<AllHeroAllModel *> *all;

@end
@interface AllHeroAllModel : NSObject

@property (nonatomic, copy) NSString *enName;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *rating;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *tags;

@end

