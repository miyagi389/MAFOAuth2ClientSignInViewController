//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFOAuth2Client/AFOAuth2Client.h>

@interface OAuth2ServiceItem : NSObject

typedef void (^OAuth2ServiceItemTestActionHandler)(OAuth2ServiceItem *item);


#pragma mark - Local

@property(nonatomic) NSString *identifier;

@property(nonatomic) NSString *title;


#pragma mark - Input

@property (nonatomic) NSURL *baseURL;

@property (nonatomic) NSString *clientID;

@property (nonatomic) NSString *secret;

@property (nonatomic) NSString *verifyParameter;

@property (nonatomic) NSString *requestTokenPath;

@property (nonatomic) NSString *userAuthorizationPath;

@property (nonatomic) NSURL *callbackURL;

@property (nonatomic) NSString *accessTokenPath;

@property (nonatomic) NSString *scope;

@property (nonatomic, copy) OAuth2ServiceItemTestActionHandler testActionHandler;


#pragma mark - Output

@property (nonatomic) AFOAuthCredential *credential;


#pragma mark - Method

- (instancetype)initWithIdentifier:(NSString *)identifier
                             title:(NSString *)title
                           baseURL:(NSURL *)baseURL
                          clientID:(NSString *)clientID
                            secret:(NSString *)secret
                   verifyParameter:(NSString *)verifyParameter
                  requestTokenPath:(NSString *)requestTokenPath
             userAuthorizationPath:(NSString *)userAuthorizationPath
                       callbackURL:(NSURL *)callbackURL
                   accessTokenPath:(NSString *)accessTokenPath
                             scope:(NSString *)scope
                 testActionHandler:(OAuth2ServiceItemTestActionHandler)testActionHandler;

+ (NSArray/*<OAuth2ServiceItem *>*/ *)defaultItems;

- (BOOL)synchronize;

@end
