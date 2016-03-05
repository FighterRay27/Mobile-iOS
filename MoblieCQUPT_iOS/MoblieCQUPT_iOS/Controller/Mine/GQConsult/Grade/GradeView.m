//
//  GradeView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/5.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "GradeView.h"

@implementation GradeView

- (instancetype)initWithFrame:(CGRect)frame
        titileWithDic:(NSDictionary *)dic
             fontSize:(CGFloat)fontSize
           gradeFrame:(CGRect)gradeFrame
            typeFrame:(CGRect)typeFrame {
    self = [super initWithFrame:frame];
//    UIView *view = [[UIView alloc]initWithFrame:frame];
    UILabel *grade = [[UILabel alloc]initWithFrame:CGRectZero];
    grade.text = @"100";
    grade.font = [UIFont systemFontOfSize:fontSize];
    [grade sizeToFit];
    grade.frame = CGRectMake(self.frame.size.width-35, 0, grade.frame.size.width, self.frame.size.height);
    grade.center = CGPointMake(gradeFrame.origin.x+gradeFrame.size.width/2, self.frame.size.height/2);
    
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectZero];
    type.text = @"独立实践";
    type.font = [UIFont systemFontOfSize:fontSize];
    [type sizeToFit];
    type.frame = CGRectMake(grade.frame.origin.x-40, 0, type.frame.size.width, self.frame.size.height);
    type.center = CGPointMake(typeFrame.origin.x+typeFrame.size.width/2, self.frame.size.height/2);
    
    UILabel *courseName = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width-type.frame.origin.x-20, self.frame.size.height)];
    courseName.text = @"中国近代史纲要";
    courseName.font = [UIFont systemFontOfSize:fontSize];
    

    [self addSubview:grade];
    [self addSubview:type];
    [self addSubview:courseName];
    
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
