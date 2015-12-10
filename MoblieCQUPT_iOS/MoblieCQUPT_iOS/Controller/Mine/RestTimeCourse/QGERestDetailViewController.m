//
//  QGERestDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/12/8.
//  Copyright © 2015年 Orange-W. All rights reserved.
//

#import "QGERestDetailViewController.h"

#define Course_API @"http://hongyan.cqupt.edu.cn/redapi2/api/kebiao"

@interface QGERestDetailViewController ()
@property (strong, nonatomic) NSArray *weekArray;
@property (assign, nonatomic) BOOL weekViewShow;
@property (strong, nonatomic) UIButton *titleButton;
@property (strong, nonatomic) UIImageView *tagView;
@property (strong, nonatomic) UIScrollView *weekScrollView;
@property (strong, nonatomic) UIView *shadeView;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIButton *clickBtn;
@property (strong, nonatomic) UIView *titleView;

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *mainView;

@property (strong, nonatomic) NSMutableArray *weekBtnArray;
@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) CGPoint startPoint1;

@property (strong, nonatomic) NSMutableArray *allStuCourseArray;
@end

@implementation QGERestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCourseTable];
    [self initWeekSelectedList];
    self.navigationItem.titleView = _titleView;
    
    [self loadAllStuCourse];
    
    NSLog(@"%@",_allStuNumArray);
    // Do any additional setup after loading the view from its nib.
}
- (void)initWeekSelectedList {
    _weekViewShow = NO;
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, -ScreenHeight/2+64, ScreenWidth, ScreenHeight/2)];
    [self.view addSubview:_backView];
    
    _weekScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/2)];
    _weekScrollView.contentSize = CGSizeMake(ScreenWidth, 35*19);
    _weekScrollView.backgroundColor = [UIColor whiteColor];
    _weekScrollView.bounces = NO;
    [_backView addSubview:_weekScrollView];
    
    _weekArray = @[@"本学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周"];
    _weekBtnArray = [NSMutableArray array];
    for (int i = 0; i < 19; i ++) {
        UIButton *weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        weekBtn.frame = CGRectMake(0, 35*i, ScreenWidth, 35);
        [weekBtn setTitle:_weekArray[i] forState:UIControlStateNormal];
        [weekBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weekBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        weekBtn.tag = i;
        [_weekBtnArray addObject:weekBtn];
        [_weekScrollView addSubview:weekBtn];
    }
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, _backView.frame.size.height-30, ScreenWidth, 30);
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(hiddenWeekView) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(backViewChange:)];
    [backBtn addGestureRecognizer:pan];
    [_backView addSubview:backBtn];
    
    UIImageView *backBtnImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    backBtnImage.center = CGPointMake(backBtn.frame.size.width/2, backBtn.frame.size.height/2);
    backBtnImage.image = [UIImage imageNamed:@"iconfont-backTag.png"];
    [backBtn addSubview:backBtnImage];
    
    UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(0, _backView.frame.size.height-30, ScreenWidth, 1)];
    underLine.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [_backView addSubview:underLine];
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleButton.frame = CGRectMake(0, 0, 100, 44);
    [_titleButton setTitle:@"本学期" forState:UIControlStateNormal];
    [_titleButton sizeToFit];
    _titleButton.center = CGPointMake(_titleView.frame.size.width/2, _titleView.frame.size.height/2);
    [_titleButton addTarget:self action:@selector(showWeekList) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:_titleButton];
    
    _tagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 6)];
    _tagView.image = [UIImage imageNamed:@"iconfont-titleTag.png"];
    _tagView.center = CGPointMake(_titleView.frame.size.width/2+_titleButton.frame.size.width/2+_tagView.frame.size.width/2, _titleView.frame.size.height/2);
    [_titleView addSubview:_tagView];
    
    _shadeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+_backView.frame.size.height, ScreenWidth, ScreenHeight)];
    _shadeView.backgroundColor = [UIColor blackColor];
    _shadeView.alpha = 0.7;
    
    UIButton *shadeViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shadeViewBtn.frame = CGRectMake(0, 0, _shadeView.frame.size.width, _shadeView.frame.size.height);
    [shadeViewBtn addTarget:self action:@selector(clickShadeView) forControlEvents:UIControlEventTouchUpInside];
    [_shadeView  addSubview:shadeViewBtn];
}

- (void)initCourseTable {
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [self.view addSubview:_mainView];
    
    UIView *dayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    dayView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [_mainView addSubview:dayView];
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, _mainView.frame.size.height - 30)];
    
    NSArray *array = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    for (int i = 0; i < 7; i ++) {
        UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake((i+0.5)*kWidthGrid, 1, kWidthGrid, 29)];
        dayLabel.text = [NSString stringWithFormat:@"%@",array[i]];
        dayLabel.font = [UIFont systemFontOfSize:14];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
        [dayView addSubview:dayLabel];
    }
    
    _mainScrollView.contentSize = CGSizeMake(ScreenWidth, kWidthGrid * 12);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [_mainView addSubview:_mainScrollView];
    
    for (int i = 0; i < 12; i ++) {
        UILabel *classNum = [[UILabel alloc]initWithFrame:CGRectMake(0, i*kWidthGrid, kWidthGrid*0.5, kWidthGrid)];
        classNum.text = [NSString stringWithFormat:@"%d",i+1];
        classNum.textAlignment = NSTextAlignmentCenter;
        classNum.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
        [_mainScrollView addSubview:classNum];
    }
}

- (void)clickBtn:(UIButton *)sender {
    if (_clickBtn == nil) {
        sender.selected = YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithRed:250/255.0 green:165/255.0 blue:69/255.0 alpha:1];
        [_titleButton setTitle:[NSString stringWithFormat:@"%@",sender.titleLabel.text] forState:UIControlStateNormal];
        [_titleButton sizeToFit];
        _titleButton.center = CGPointMake(_titleView.frame.size.width/2, _titleView.frame.size.height/2);
        _tagView.center = CGPointMake(_titleView.frame.size.width/2+_titleButton.frame.size.width/2+_tagView.frame.size.width/2, _titleView.frame.size.height/2);
        _clickBtn = sender;
    }else if (_clickBtn == sender) {
        sender.selected = YES;
    }else if (_clickBtn != sender) {
        _clickBtn.selected = NO;
        [_clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _clickBtn.backgroundColor = [UIColor whiteColor];
        sender.selected = YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithRed:250/255.0 green:165/255.0 blue:69/255.0 alpha:1];
        [_titleButton setTitle:[NSString stringWithFormat:@"%@",sender.titleLabel.text] forState:UIControlStateNormal];
        [_titleButton sizeToFit];
        _titleButton.center = CGPointMake(_titleView.frame.size.width/2, _titleView.frame.size.height/2);
        _tagView.center = CGPointMake(_titleView.frame.size.width/2+_titleButton.frame.size.width/2+_tagView.frame.size.width/2, _titleView.frame.size.height/2);
        _clickBtn = sender;
    }
    [self showWeekList];
}

- (void)showWeekList {
    if (_weekViewShow) {
        _tagView.transform = CGAffineTransformMakeRotation(0);
        [UIView animateWithDuration:0 animations:^{
            [_shadeView removeFromSuperview];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _backView.frame = CGRectMake(0, -ScreenHeight/2, _backView.frame.size.width, _backView.frame.size.height);
                _weekViewShow = NO;
            } completion:nil];
        }];
    }else {
        _tagView.transform = CGAffineTransformMakeRotation(M_PI);
        [UIView animateWithDuration:0.3 animations:^{
            _backView.frame = CGRectMake(0, 64, _backView.frame.size.width, _backView.frame.size.height);
        } completion:^(BOOL finished) {
            _shadeView.frame = CGRectMake(0, 64+_backView.frame.size.height, ScreenWidth, ScreenHeight);
//            [[[UIApplication sharedApplication]keyWindow]addSubview:_shadeView];
            [self.view addSubview:_shadeView];
            _weekViewShow = YES;
        }];
    }
}

- (void)hiddenWeekView {
    [_shadeView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _backView.frame = CGRectMake(0, -ScreenHeight/2, _backView.frame.size.width, _backView.frame.size.height);
    } completion:nil];
    _tagView.transform = CGAffineTransformMakeRotation(0);
    _weekViewShow = NO;
}
- (void)clickShadeView {
    [_shadeView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _backView.frame = CGRectMake(0, -ScreenHeight/2, _backView.frame.size.width, _backView.frame.size.height);
    } completion:nil];
    _tagView.transform = CGAffineTransformMakeRotation(0);
    _weekViewShow = NO;
}

- (void)backViewChange:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _startPoint = _backView.center;
        _startPoint1 = _shadeView.center;
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gesture translationInView:_backView];//求出手指在屏幕上的位移
        if (point.y < 0) {
            _backView.center = CGPointMake(_backView.center.x,_startPoint.y + point.y);
            _shadeView.center = CGPointMake(_shadeView.center.x, _startPoint1.y + point.y);
        }
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [gesture translationInView:_backView];
        CGPoint point1 = [gesture velocityInView:_backView];
        if (point1.y < 0) {
            if (point.y > -60) {
                [UIView animateWithDuration:0.2 animations:^{
                    _backView.frame = CGRectMake(0, 0, _backView.frame.size.width, _backView.frame.size.height);
                    _shadeView.frame = CGRectMake(0, _backView.frame.size.height, ScreenWidth, ScreenHeight);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.05 animations:^{
                        _backView.frame = CGRectMake(0, -3, _backView.frame.size.width, _backView.frame.size.height);
                        _shadeView.frame = CGRectMake(0, _backView.frame.size.height-3, ScreenWidth, ScreenHeight);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 animations:^{
                            _backView.frame = CGRectMake(0, -1, _backView.frame.size.width, _backView.frame.size.height);
                            _shadeView.frame = CGRectMake(0, _backView.frame.size.height-1, ScreenWidth, ScreenHeight);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.05 animations:^{
                                _backView.frame = CGRectMake(0, 0, _backView.frame.size.width, _backView.frame.size.height);
                                _shadeView.frame = CGRectMake(0, _backView.frame.size.height, ScreenWidth, ScreenHeight);
                            } completion:nil];
                        }];
                    }];
                }];
            }else {
                [self hiddenWeekView];
            }
        }else if (point1.y > 0) {
            [UIView animateWithDuration:0.2 animations:^{
                _backView.frame = CGRectMake(0, 0, _backView.frame.size.width, _backView.frame.size.height);
                _shadeView.frame = CGRectMake(0, _backView.frame.size.height, ScreenWidth, ScreenHeight);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    _backView.frame = CGRectMake(0, -3, _backView.frame.size.width, _backView.frame.size.height);
                    _shadeView.frame = CGRectMake(0, _backView.frame.size.height-3, ScreenWidth, ScreenHeight);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.05 animations:^{
                        _backView.frame = CGRectMake(0, -1, _backView.frame.size.width, _backView.frame.size.height);
                        _shadeView.frame = CGRectMake(0, _backView.frame.size.height-1, ScreenWidth, ScreenHeight);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 animations:^{
                            _backView.frame = CGRectMake(0, 0, _backView.frame.size.width, _backView.frame.size.height);
                            _shadeView.frame = CGRectMake(0, _backView.frame.size.height, ScreenWidth, ScreenHeight);
                        } completion:nil];
                    }];
                }];
            }];
        }
    }
}
#pragma mark - 请求课表
- (void)loadAllStuCourse {
    _allStuCourseArray = [NSMutableArray array];
    for (int i = 0; i < _allStuNumArray.count; i++) {
        NSString *stuNum = [NSString stringWithFormat:@"%@",_allStuNumArray[i]];
        [NetWork NetRequestPOSTWithRequestURL:Course_API WithParameter:@{@"stuNum":stuNum} WithReturnValeuBlock:^(id returnValue) {
            [_allStuCourseArray addObject:returnValue[@"data"]];
            if (_allStuCourseArray.count == _allStuNumArray.count) {
                NSLog(@"%ld",_allStuCourseArray.count);
            }
        } WithFailureBlock:^{
            NSLog(@"请求失败");
        }];
    }
}
#pragma mark 获取周课表
- (NSMutableArray *)getWeekCourseArray:(NSMutableArray *)courseArray withWeek:(NSInteger)week {
    NSMutableArray *weekCourseArray = [NSMutableArray array];
    for (int i = 0; i < courseArray.count; i ++) {
        if ([courseArray[i][@"week"] containsObject:[NSNumber numberWithInteger:week]]) {
            NSMutableDictionary *weekDataDic = [[NSMutableDictionary alloc]initWithDictionary:courseArray[i]];
            [weekCourseArray addObject:weekDataDic];
        }
    }
    return weekCourseArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
