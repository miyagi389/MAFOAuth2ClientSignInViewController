//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MAFOAuth2ClientSignInViewControllerDelegate.h"

@interface MAFOAuth2ClientSignInViewController : UIViewController <UIWebViewDelegate>

@property (weak) id<MAFOAuth2ClientSignInViewControllerDelegate> delegate;

@property (nonatomic) UIWebView *webView;

@property (nonatomic) NSURL *baseURL;

@property (nonatomic) NSString *clientID;

@property (nonatomic) NSString *secret;

@property (nonatomic) NSString *verifyParameter;

@property (nonatomic) NSString *requestTokenPath;

@property (nonatomic) NSString *userAuthorizationPath;

@property (nonatomic) NSURL *callbackURL;

@property (nonatomic) NSString *accessTokenPath;

@property (nonatomic) NSString *scope;

+ (instancetype)controllerWithBaseURL:(NSURL *)baseURL
                             clientID:(NSString *)clientID
                               secret:(NSString *)secret
                      verifyParameter:(NSString *)verifyParameter
                     requestTokenPath:(NSString *)requestTokenPath
                userAuthorizationPath:(NSString *)userAuthorizationPath
                          callbackURL:(NSURL *)callbackURL
                      accessTokenPath:(NSString *)accessTokenPath
                                scope:(NSString *)scope;

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                       clientID:(NSString *)clientID
                         secret:(NSString *)secret
                verifyParameter:(NSString *)verifyParameter
               requestTokenPath:(NSString *)requestTokenPath
          userAuthorizationPath:(NSString *)userAuthorizationPath
                    callbackURL:(NSURL *)callbackURL
                accessTokenPath:(NSString *)accessTokenPath
                          scope:(NSString *)scope;

@end
