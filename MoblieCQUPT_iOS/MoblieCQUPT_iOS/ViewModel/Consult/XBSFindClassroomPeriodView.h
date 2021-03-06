//
//  XBSFindClassroomPeriodView.h
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/12/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBSFindClassroomPeriodView : UIView
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) NSInteger   index;
@property (nonatomic, strong) UIImage     *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *label;

//- (instancetype)initWithIndex:(NSInteger)index;
- (instancetype)initWithIndex:(NSInteger)index Delegate:(UIViewController *)delegate;

@end
