//
//  TuWanListCell.m
//  BaseProject
//
//  Created by tarena on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanListCell.h"

@implementation TuWanListCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (UIImageView *)iconIV
{
    if (!_iconIV) {
        _iconIV = [[UIImageView alloc]init];
        //内容模式：保持比例，填充满
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconIV;
}
- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]init];
        _titleLb.font = [UIFont systemFontOfSize:17];
    }
    return _titleLb;
}
- (UILabel *)LongTitleLb
{
    if (!_LongTitleLb) {
        _LongTitleLb = [[UILabel alloc]init];
        _LongTitleLb.font = [UIFont systemFontOfSize:14];
        _LongTitleLb.textColor = [UIColor lightGrayColor];//浅灰色
    }
    return _LongTitleLb;
}
- (UILabel *)clicksNumLb
{
    if (!_clicksNumLb) {
        _clicksNumLb = [[UILabel alloc]init];
        _clicksNumLb.font = [UIFont systemFontOfSize:11];
        _clicksNumLb.textColor = [UIColor lightGrayColor];
    }
    return _clicksNumLb;
}
/** 重写init方法 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconIV];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.LongTitleLb];
        [self.contentView addSubview:self.clicksNumLb];
//图片左边10  宽高92 70  竖向居中（适配，从左到右，从上到下）
        [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(92, 70));
            make.centerY.mas_equalTo(0);
        }];
//题目 距离图片右边缘8   右边缘10  上边缘比图片上边缘矮3
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconIV.mas_right).mas_equalTo(8);
            make.right.mas_equalTo(-10);
            make.topMargin.mas_equalTo(_iconIV.mas_topMargin).mas_equalTo(3);
        }];
//详情  左右边缘和题目一样，上边缘具体题目下边缘8像素
        [self.LongTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(_titleLb.mas_leftMargin);
            make.rightMargin.mas_equalTo(_titleLb.mas_rightMargin);
            make.top.mas_equalTo(_titleLb.mas_bottom).mas_equalTo(8);
        }];
//点击数，下边缘与图片对齐。右边缘与任意的title对齐
        [self.clicksNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin);
            make.rightMargin.mas_equalTo(_titleLb.mas_rightMargin);
        }];
    }
    return self;
}
@end
