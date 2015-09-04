//
//  MineViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/30.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "MineViewController.h"
#import "ButtonClicker.h"
#import "SuggestionViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIImageView *myPhoto;
@property (strong, nonatomic) UILabel *loginLabel;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat currentHeight;
@property (strong, nonatomic) ButtonClicker *clicker;
@property (strong, nonatomic) NSMutableArray *cellDictionary;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentHeight = 0;
    _cellDictionary = [NSMutableArray array];
    _cellDictionary = [@[
                        @{@"cell":@"去哪吃",@"img":@""},
                         @{@"cell":@"校历",@"img":@""},
                         @{@"cell":@"反馈信息",@"img":@"",@"controller":@"SuggestionViewController"},
                         @{@"cell":@"关于",@"img":@""},
                         @{@"cell":@"退出登录",@"img":@""},
                        ]
                       mutableCopy];
    UIView *topView = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H*0.35)];
    _currentHeight += topView.frame.size.height;
    
    topView.backgroundColor = MAIN_COLOR;
    [self.view addSubview:topView];

    
    [self.view addSubview:self.myPhoto];
    [self.view addSubview:self.loginLabel];
    
    /**button **/
    self.clicker = [[ButtonClicker alloc]init];
    self.clicker.delegate = self;
    NSArray *tempStrArr = @[@"20-3b.png",@"20-3补考.png",@"20-3exam.png",@"20-3c.png"];
    SEL s[4] = {@selector(clickForExamSchedule),@selector(clickForReexamSchedule),
        @selector(clickForExamGrade),@selector(clickForEmptyRooms)};
    
    //button
    for (int i=0; i<4; i++) {
        UIButton *labelButton = [[UIButton alloc] initWithFrame:CGRectMake( MAIN_SCREEN_W/4*i, topView.frame.size.height, MAIN_SCREEN_W/4, MAIN_SCREEN_H*0.1)];
        labelButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        labelButton.layer.borderWidth = 1;
        UIImage *stretchableButtonImage = [[UIImage imageNamed:tempStrArr[i]]  stretchableImageWithLeftCapWidth:0  topCapHeight:0];
        [labelButton setImage:stretchableButtonImage forState:UIControlStateNormal];
//        labelButton.imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        /**/
        [labelButton addTarget:self.clicker action:s[i] forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:labelButton];
    }
    
    _currentHeight += MAIN_SCREEN_H*0.1;

    [self.view addSubview:self.tableView];
    _currentHeight += _tableView.frame.size.height;
    
    
    
    
    
    
    for (NSString* family in [UIFont familyNames])
    {
       
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            if ([name  isEqual: @"uxIconFont"]) {
                NSLog(@"  %@", name);
            }
            
        }
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _currentHeight, MAIN_SCREEN_W, MAIN_SCREEN_H-_currentHeight-44) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setAutoresizesSubviews:NO];
    }
    
    return _tableView;
}

- (UIImageView *)myPhoto{
    if (!_myPhoto) {
        _myPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W*0.2, MAIN_SCREEN_W*0.2)];
        _myPhoto.center = CGPointMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H*0.12);
        [_myPhoto setImage:[UIImage imageNamed:@"main_login.png"]];
        _myPhoto.backgroundColor = [UIColor whiteColor];
        _myPhoto.layer.cornerRadius = _myPhoto.frame.size.width/2;
    }
    return _myPhoto;
}

- (UILabel *)loginLabel{
    if (!_loginLabel) {
        _loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,MAIN_SCREEN_W/2, 0)];
        _loginLabel.textColor = [UIColor greenColor];
        NSMutableAttributedString *loginText = [[NSMutableAttributedString alloc] initWithString:@"刘慧吱"];
        [loginText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 3)];
        _loginLabel.attributedText = loginText;
        _loginLabel.textAlignment = NSTextAlignmentCenter;
        
        [_loginLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [_loginLabel sizeToFit];
        _loginLabel.center = CGPointMake(MAIN_SCREEN_W/2, _myPhoto.center.y+_myPhoto.frame.size.height/2+_loginLabel.frame.size.height+8);
    }
    return _loginLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"butttonCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"butttonCell"];
        cell.textLabel.text = _cellDictionary[indexPath.section][@"cell"];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Courier" size:20]];
//        cell.detailTextLabel.textColor = [UIColor groupTableViewBackgroundColor];
        cell.detailTextLabel.text = @">";
        cell.imageView.image = [UIImage imageNamed:@"icon_menu_2.png"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSSet *set = [NSSet setWithObjects:@0,@1,@4, nil];
    NSSet *nowSet = [NSSet setWithObject:[NSNumber numberWithInteger:section]];
    if ([nowSet isSubsetOfSet:set]) {
        return 8;
    }else{
        return 0.000001;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (_tableView.frame.size.height-8*3-2)/5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className;
    if ((className = _cellDictionary[indexPath.section][@"controller"])) {
        
        id viewController =  [[NSClassFromString(className) alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

@end
