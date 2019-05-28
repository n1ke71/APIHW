//
//  LoginViewController.m
//  APIHW
//
//  Created by Kozaderov Ivan on 05/05/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "LoginViewController.h"
#import <WebKit/WebKit.h>
#import "AccessToken.h"
#import "ServerManager.h"

@interface LoginViewController () <WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *wkWebView;
@property (weak, nonatomic)  ServerManager *serverManager;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.serverManager = [ServerManager sharedManager];
    self.wkWebView.navigationDelegate = self;
    NSString *urlString = [NSString stringWithFormat:@"https://oauth.vk.com/authorize?"
                           "client_id=6823444&"
                           "redirect_uri=https://oauth.vk.com/blank.html&"
                           "display=mobile&"
                           "scope=270370&" //2 + 8 + 16 + 8192 + 262144 + 8
                           "response_type=token&"
                           "v=5.95&state=Done"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
    
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    //  NSLog(@"navigationResponse.response.URL %@",navigationResponse.response.URL);
    NSString *responseString = navigationResponse.response.URL.description;
    NSArray *components = [responseString componentsSeparatedByString:@"#"];
    if ([components count] >1) {
        
        AccessToken *token = [[AccessToken alloc]init];
        NSString *query = navigationResponse.response.URL.description;
        NSArray *array = [query componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            query = [array lastObject];
        }
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        for (NSString *pair in pairs) {
            NSArray *values = [pair componentsSeparatedByString:@"="];
            if ([values count] == 2) {
                NSString *key = [values firstObject];
                if ([key isEqualToString:@"access_token"]) {
                    token.token = [values lastObject];
                    
                } else if ([key isEqualToString:@"expires_in"]){
                    NSTimeInterval interval = [[values lastObject] doubleValue];
                    token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                    
                }else if ([key isEqualToString:@"user_id"]){
                    token.userID = [values lastObject];
                }
                
            }
        }
        
        if (token) {
            self.serverManager.accessToken = token;
        }
        self.wkWebView.navigationDelegate = nil;
        [self performSegueWithIdentifier:@"ToTabBarController" sender:self];
        
    }
    decisionHandler(WKNavigationResponsePolicyAllow);    
}

@end
