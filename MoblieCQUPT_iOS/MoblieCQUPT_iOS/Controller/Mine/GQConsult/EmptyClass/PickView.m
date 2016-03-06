//
//  PickView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "PickView.h"

@implementation PickView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
//    if (self) {
//        
//        
//    }
    self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    _backView = [[UIView alloc]initWithFrame:CGRectZero];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.frame = CGRectMake(0, 0, ScreenWidth/10*7.5, ScreenWidth/10*7.5-10);
    _backView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    
    CGFloat margin;
    CGFloat margin1;
    CGFloat imageWidth;
    CGFloat fontSize;
    if (ScreenWidth == 375) {
        margin = 25;
        margin1 = 15;
        imageWidth = 20;
        fontSize = 18;
    }else if (ScreenWidth == 320) {
        margin = 20;
        margin1 = 10;
        imageWidth = 15;
        fontSize = 16;
    }else {
        margin = 28;
        margin1 = 20;
        imageWidth = 23;
        fontSize = 20;
    }
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.text = @"空教室查询";
    _titleLabel.font = [UIFont systemFontOfSize:fontSize];
    _titleLabel.textColor = MAIN_COLOR;
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(margin, margin, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
    
    _timeImage = [[UIImageView alloc]init];
    _classImage = [[UIImageView alloc]init];
    _sectionImage = [[UIImageView alloc]init];
    
    _timeImage.image = [UIImage imageNamed:@"GQtime.png"];
    _classImage.image = [UIImage imageNamed:@"GQclass.png"];
    _sectionImage.image = [UIImage imageNamed:@"GQsection.png"];
    
    _timeImage.frame = CGRectMake(margin, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+margin, imageWidth, imageWidth);
    _classImage.frame = CGRectMake(margin, _timeImage.frame.origin.y+_timeImage.frame.size.height+margin, imageWidth, imageWidth);
    _sectionImage.frame = CGRectMake(margin, _classImage.frame.origin.y+_classImage.frame.size.height+margin, imageWidth, imageWidth);
    
    _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _classBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sectionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [_timeBtn setTitle:@"2015-03-06" forState:UIControlStateNormal];
    [_timeBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize-2];
    [_classBtn setTitle:@"三教" forState:UIControlStateNormal];
    [_classBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    _classBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize-2];
    [_sectionBtn setTitle:@"1~2节" forState:UIControlStateNormal];
    [_sectionBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    _sectionBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize-2];
    
    _timeBtn.frame = CGRectMake(_timeImage.frame.origin.x+_timeImage.frame.size.width+margin1, _timeImage.frame.origin.y, _backView.frame.size.width-margin*2-margin1-imageWidth, imageWidth);
    _classBtn.frame = CGRectMake(_classImage.frame.origin.x+_classImage.frame.size.width+margin1, _classImage.frame.origin.y, _backView.frame.size.width-margin*2-margin1-imageWidth, imageWidth);
    _sectionBtn.frame = CGRectMake(_sectionImage.frame.origin.x+_sectionImage.frame.size.width+margin1, _sectionImage.frame.origin.y, _backView.frame.size.width-margin*2-margin1-imageWidth, imageWidth);
    
    _line1 = [[UIView alloc]init];
    _line2 = [[UIView alloc]init];
    _line3 = [[UIView alloc]init];
    
    _line1.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    _line2.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    _line3.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    
    _line1.frame = CGRectMake(_timeBtn.frame.origin.x, _timeBtn.frame.origin.y+_timeBtn.frame.size.height, _backView.frame.size.width-margin*2-margin1-imageWidth, 1);
    _line2.frame = CGRectMake(_classBtn.frame.origin.x, _classBtn.frame.origin.y+_classBtn.frame.size.height, _backView.frame.size.width-margin*2-margin1-imageWidth, 1);
    _line3.frame = CGRectMake(_sectionBtn.frame.origin.x, _sectionBtn.frame.origin.y+_sectionBtn.frame.size.height, _backView.frame.size.width-margin*2-margin1-imageWidth, 1);
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchBtn setTitle:@"查找" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _searchBtn.backgroundColor = MAIN_COLOR;
    _searchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _sectionBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    _searchBtn.layer.cornerRadius = 5.0;
    [_searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    _searchBtn.frame = CGRectMake(15, _backView.frame.size.height-60, _backView.frame.size.width-30, 45);
    
    [self addSubview:_backView];
    [_backView addSubview:_titleLabel];
    [_backView addSubview:_timeImage];
    [_backView addSubview:_classImage];
    [_backView addSubview:_sectionImage];
    [_backView addSubview:_timeBtn];
    [_backView addSubview:_classBtn];
    [_backView addSubview:_sectionBtn];
    [_backView addSubview:_line1];
    [_backView addSubview:_line2];
    [_backView addSubview:_line3];
    [_backView addSubview:_searchBtn];
    return self;
}

- (void)searchBtn:(UIButton *)sender {
    NSLog(@"查找、、、、、、");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
