//
//  TuWanImageCell.m
//  BaseProject
//
//  Created by tarena on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanImageCell.h"

@implementation TuWanImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.clickNumLb];
        [self.contentView addSubview:self.iconIV0];
        [self.contentView addSubview:self.iconIV1];
        [self.contentView addSubview:self.iconIV2];
/** 题目 左上10像素  右10 */
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(_clickNumLb.mas_left).mas_equalTo(-10);
        }];
/** 点击数 上和右 10 像素  宽度最大70像素，最小40像素 */
        [self.clickNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.width.mas_greaterThanOrEqualTo(40).mas_lessThanOrEqualTo(70);
        }];
/** 图片：宽和高相等，间距5 ，边缘10，高度是88，上边缘5像素 */
        [self.iconIV0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(88);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_titleLb.mas_bottom).mas_equalTo(5);
        }];
        [self.iconIV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_iconIV0);
            make.left.mas_equalTo(_iconIV0.mas_right).mas_equalTo(5);
            make.topMargin.mas_equalTo(_iconIV0);
        }];
        [self.iconIV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_iconIV0);
            make.left.mas_equalTo(_iconIV1.mas_right).mas_equalTo(5);
            make.topMargin.mas_equalTo(_iconIV0);
            make.right.mas_equalTo(-10);
        }];
    }
    return self;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]init];
        _titleLb.font = [UIFont systemFontOfSize:17];
    }
    return _titleLb;
}
- (UILabel *)clickNumLb
{
    if (!_clickNumLb) {
        _clickNumLb = [[UILabel alloc]init];
        _clickNumLb.font = [UIFont systemFontOfSize:12];
        _clickNumLb.textColor = [UIColor lightGrayColor];
    }
    return _clickNumLb;
}
- (UIImageView *)iconIV0
{
    if (!_iconIV0) {
        _iconIV0 = [[UIImageView alloc]init];
        //图片模式，按比例方法，充满全屏
        _iconIV0.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconIV0;
}
- (UIImageView *)iconIV1
{
    if (!_iconIV1) {
        _iconIV1 = [[UIImageView alloc]init];
        _iconIV1.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconIV1;
}
- (UIImageView *)iconIV2
{
    if (!_iconIV2) {
        _iconIV2 = [[UIImageView alloc]init];
        _iconIV2.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconIV2;
}
@end
