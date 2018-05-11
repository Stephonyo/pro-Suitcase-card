//
//  WebViewViewController.m
//  33caipiao
//
//  Created by 周虹良 on 2017/6/18.
//  Copyright © 2017年 cp33.com. All rights reserved.
//

#import "WebViewViewController.h"
#import "SVProgressHUD.h"
@interface WebViewViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];

    
    [self.view addSubview:self.webView];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [SVProgressHUD dismiss];
}
-(void)viewDidDisappear:(BOOL)animated {
//   [SVProgressHUD dismiss];
}
-(UIWebView *)webView {
    if (!_webView) {

        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _webView.backgroundColor = [UIColor whiteColor];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
        _webView.scrollView.bounces = NO;
        _webView.delegate = self;
    }
    return _webView;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
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
