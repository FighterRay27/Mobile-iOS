//
//  QGERestDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/12/8.
//  Copyright © 2015年 Orange-W. All rights reserved.
//

#import "QGERestDetailViewController.h"

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
@property (strong, nonatomic) NSMutableArray *weekBtnArray;
@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) CGPoint startPoint1;
@end

@implementation QGERestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _weekViewShow = NO;
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, -ScreenHeight/2, ScreenWidth, ScreenHeight/2+64)];
    [self.view addSubview:_backView];
    
    _weekScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/2+34)];
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
    
    self.navigationItem.titleView = _titleView;
    
    _shadeView = [[UIView alloc]initWithFrame:CGRectMake(0, _backView.frame.size.height+64, ScreenWidth, ScreenHeight)];
    _shadeView.backgroundColor = [UIColor blackColor];
    _shadeView.alpha = 0.7;
    
    UIButton *shadeViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shadeViewBtn.frame = CGRectMake(0, 0, _shadeView.frame.size.width, _shadeView.frame.size.height);
    [shadeViewBtn addTarget:self action:@selector(clickShadeView) forControlEvents:UIControlEventTouchUpInside];
    [_shadeView  addSubview:shadeViewBtn];
    // Do any additional setup after loading the view from its nib.
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
            _backView.frame = CGRectMake(0, 0, _backView.frame.size.width, _backView.frame.size.height);
        } completion:^(BOOL finished) {
            _shadeView.frame = CGRectMake(0, _backView.frame.size.height, ScreenWidth, ScreenHeight);
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
