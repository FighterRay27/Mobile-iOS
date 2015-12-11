//
//  RestTimeButton.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 12/11/15.
//  Copyright © 2015 Orange-W. All rights reserved.
//

#import "RestTimeButton.h"

@implementation RestTimeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 1.5;
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 6;
    }
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
