//
//  FirstViewController.m
//  重邮小帮手
//
//  Created by 1808 on 15/8/20.
//  Copyright (c) 2015年 1808. All rights reserved.
//

#import "FirstViewController.h"
#import "NetWork.h"
#import "HCHttp.h"
#import "AnnexViewController.h"

@interface FirstViewController ()
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableDictionary *backData;
@property (strong, nonatomic)UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *devLine;
@property (weak, nonatomic) UINavigationItem *commonNavigationItem;
@property (strong, nonatomic) NSMutableDictionary *annex;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.data1 = [[NSMutableDictionary alloc] init];
    self.backData = [[NSMutableDictionary alloc] init];
    
    // 创建UIScrollView
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(15, _devLine.frame.origin.y+15, MAIN_SCREEN_W-30, MAIN_SCREEN_H-_devLine.frame.origin.y); // frame中的size指UIScrollView的可视范围
    _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_W-30, MAIN_SCREEN_H-_devLine.frame.origin.y);
    [self.view addSubview:_scrollView];
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W-30, MAIN_SCREEN_H)];
    _textView.text = @"查询中";
    _textView.userInteractionEnabled = NO;
    [_scrollView addSubview:_textView];
    // 隐藏水平滚动条
     _scrollView.showsHorizontalScrollIndicator = NO;
     _scrollView.showsVerticalScrollIndicator = YES;
    [_scrollView setPagingEnabled:YES];

    self.day1label.text =self.data1[@"date"];
    _textView.text = self.data1[@"newsContent"];

    self.top1label.text =self.data1[@"title"];

    UIFont *font = [UIFont fontWithName:@"苹方" size:28];
    _textView.textColor = [UIColor grayColor];
    self.textView.font = font;
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [value boundingRectWithSize:CGSizeMake(width-16, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.height+16;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
   float H = [self heightForString:self.data1[@"newsContent"] fontSize:14 andWidth:MAIN_SCREEN_W];
    _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_W,H);
    _scrollView.backgroundColor = [UIColor clearColor];
    [_scrollView sizeToFit];
    
    //附件网络请求
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/home/news/searchcontent"
                            WithParameter:@{@"page":_info[@"page"],
                                            @"size":[NSNumber numberWithInt:15],
                                            @"type":@"jwzx",
                                            @"articleid":_data1[@"id"]
                                            }
                     WithReturnValeuBlock:^(id returnValue) {
                         _annex = returnValue;
                         
                         if (![_annex[@"data"][@"annex"][0][@"address"] isEqualToString:@""]) {
                             UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"打开附件" style:UIBarButtonItemStylePlain target:self action:@selector(OpenAnnex)];
                             self.navigationItem.rightBarButtonItem = rightBarButton;
                         }
                         
                     } WithFailureBlock:nil];
    
}
//跳转到 Safari 打开附件
- (void)OpenAnnex {
    NSString *annexUrlString = _annex[@"data"][@"annex"][0][@"address"];
    if ([annexUrlString isEqualToString:@""]) {
        
    } else {
        [HCHttp requestStringFrom:annexUrlString
                completionHandler:^(NSString *responseString, NSError *error) {
                    NSString* FinalAnnexURLString = [[responseString substringWithRange:NSMakeRange(1, responseString.length-2)] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: FinalAnnexURLString]];
                }];
    }
    
}

@end
