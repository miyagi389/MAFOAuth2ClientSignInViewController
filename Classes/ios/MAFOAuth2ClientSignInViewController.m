//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//
//  This source, we have referred to the 'AFOAuthSignInViewController'.
//

#import <AFOAuth2Client/AFOAuth2Client.h>

#import "MAFOAuth2ClientSignInViewController.h"

@implementation MAFOAuth2ClientSignInViewController
{
    AFOAuth2Client *_client;
}

+ (instancetype)controllerWithBaseURL:(NSURL *)baseURL
                             clientID:(NSString *)clientID
                               secret:(NSString *)secret
                      verifyParameter:(NSString *)verifyParameter
                     requestTokenPath:(NSString *)requestTokenPath
                userAuthorizationPath:(NSString *)userAuthorizationPath
                          callbackURL:(NSURL *)callbackURL
                      accessTokenPath:(NSString *)accessTokenPath
                                scope:(NSString *)scope
{
    return [[self alloc] initWithBaseURL:baseURL
                                clientID:clientID
                                  secret:secret
                         verifyParameter:verifyParameter
                        requestTokenPath:requestTokenPath
                   userAuthorizationPath:userAuthorizationPath
                             callbackURL:callbackURL
                         accessTokenPath:accessTokenPath
                                   scope:scope
            ];
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                       clientID:(NSString *)clientID
                         secret:(NSString *)secret
                verifyParameter:(NSString *)verifyParameter
               requestTokenPath:(NSString *)requestTokenPath
          userAuthorizationPath:(NSString *)userAuthorizationPath
                    callbackURL:(NSURL *)callbackURL
                accessTokenPath:(NSString *)accessTokenPath
                          scope:(NSString *)scope
{
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _clientID = clientID;
        _secret = secret;
		_verifyParameter = verifyParameter;
        _requestTokenPath = requestTokenPath;
        _userAuthorizationPath = userAuthorizationPath;
		_callbackURL = callbackURL;
		_accessTokenPath = accessTokenPath;
        _scope = scope;
    }
    return self;
}

- (void)loadView
{
    [super loadView];

	UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.scalesPageToFit = YES;

	self.view = webView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    _client = [AFOAuth2Client clientWithBaseURL:_baseURL clientID:_clientID secret:_secret];

    NSString *url = [self buildAuthenticateURLString];

    UIWebView *webView = (UIWebView *)self.view;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *callbackURLString = _callbackURL.absoluteString;
	NSString *urlString = request.URL.absoluteString;
#ifdef DEBUG
    NSLog(@"urlString=%@", urlString);
#endif
	if ([urlString rangeOfString:callbackURLString].location == NSNotFound) {
        return YES;
    } else {
        if ([urlString rangeOfString:callbackURLString].location == 0 && [urlString rangeOfString:callbackURLString].length == callbackURLString.length) {
            NSURL *url = [NSURL URLWithString:urlString];
            NSDictionary *urlParameters = [self parseURLParameters:url];
            if (_verifyParameter && [urlParameters objectForKey:_verifyParameter]) {
                NSString *verifyValue = urlParameters[_verifyParameter];
                [self authenticateWithVerifyValue:verifyValue];
            }
        }
    }

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

#pragma mark - Private

- (NSString *)buildAuthenticateURLString
{
    NSString *escapeCallbackURL = [_callbackURL.URLByStandardizingPath.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    NSString *escapeScope = [_scope stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    NSString *url = [NSString stringWithFormat:@"%@%@?client_id=%@&response_type=code&scope=%@&redirect_uri=%@&state=security_token=%@=%@",
                     _baseURL,
                     _userAuthorizationPath,
                     _clientID,
                     escapeScope,
                     escapeCallbackURL,
                     _secret,
                     escapeCallbackURL];
    return url;
}

- (NSString *)buildAccessTokenURLString
{
    NSString *url = [NSString stringWithFormat:@"%@%@", _baseURL, _accessTokenPath];
    return url;
}

- (void)authenticateWithVerifyValue:(NSString *)verifyValue
{
    NSString *url = [self buildAccessTokenURLString];
    NSString *redirectURI = _callbackURL.URLByStandardizingPath.absoluteString;
    [_client authenticateUsingOAuthWithURLString:url
                                            code:verifyValue
                                     redirectURI:redirectURI
                                         success:^(AFOAuthCredential *credential) {
                                             [_delegate signInViewControllerLoginSuccess:self credential:credential];
                                         }
                                         failure:^(NSError *error) {
                                             [_delegate signInViewControllerLoginFailure:self error:error];
                                         }];
}

- (NSDictionary *)parseURLParameters:(NSURL *)url
{
    NSString *query = [url query];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *value = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        dict[key] = value;
    }
    return dict;
}

@end
