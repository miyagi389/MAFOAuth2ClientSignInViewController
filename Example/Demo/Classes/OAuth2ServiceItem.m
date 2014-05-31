//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import "OAuth2ServiceItem.h"

#import "UserDefines.h"

@implementation OAuth2ServiceItem

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
                 testActionHandler:(OAuth2ServiceItemTestActionHandler)testActionHandler
{
    self = [super init];
    if (self) {
        _identifier = identifier;
        _title = title;
        _baseURL = baseURL;
        _clientID = clientID;
        _secret = secret;
        _verifyParameter = verifyParameter;
        _requestTokenPath = requestTokenPath;
        _userAuthorizationPath = userAuthorizationPath;
        _callbackURL = callbackURL;
        _accessTokenPath = accessTokenPath;
        _scope = scope;
        _testActionHandler = testActionHandler;
    }
    return self;
}

+ (NSArray/*<OAuth2ServiceItem *>*/ *)defaultItems
{
    NSMutableArray *result = [NSMutableArray array];

    // Feedly
    {
        NSString *identifier = @"C443D0D7-1107-40D7-853D-42BDBE6FEE7D";
        NSString *scope = [@"https://cloud.feedly.com/subscriptions" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        OAuth2ServiceItemTestActionHandler testActionHandler = ^(OAuth2ServiceItem *item) {
            LOGD(@"item=%@", item);

            AFOAuth2Client *client = [AFOAuth2Client clientWithBaseURL:item.baseURL clientID:item.clientID secret:item.secret];

            AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:identifier];
            [client setAuthorizationHeaderWithCredential:credential];

            [client GET:@"https://sandbox.feedly.com/v3/profile"
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    LOGD(@"responseObject class=%@", NSStringFromClass([responseObject class]));
                    LOGD(@"responseObject=%@", responseObject);
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    LOGD(@"error=%@", error);
                }];
        };
        OAuth2ServiceItem *o = [[OAuth2ServiceItem alloc] initWithIdentifier:identifier
                                                                       title:@"Feedly"
                                                                     baseURL:[NSURL URLWithString:@"https://sandbox.feedly.com"]
                                                                    clientID:kDemoOAuth2FeedlyClientID
                                                                      secret:kDemoOAuth2FeedlySecret
                                                             verifyParameter:@"code"
                                                            requestTokenPath:@""
                                                       userAuthorizationPath:@"/v3/auth/auth"
                                                                 callbackURL:kDemoOAuth2FeedlyCallbackURL
                                                             accessTokenPath:@"/v3/auth/token"
                                                                       scope:scope
                                                           testActionHandler:testActionHandler];
        o.credential = [AFOAuthCredential retrieveCredentialWithIdentifier:identifier];
        [result addObject:o];
    }

    // Google (YouTube DATA API)
    {
        NSString *identifier = @"C9ABEECD-E654-418E-BC7B-BB583650E434";
        NSString *scope = [@"https://www.googleapis.com/auth/youtube.readonly" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        OAuth2ServiceItemTestActionHandler testActionHandler = ^(OAuth2ServiceItem *item) {
            LOGD(@"item=%@", item);

            AFOAuth2Client *client = [AFOAuth2Client clientWithBaseURL:item.baseURL clientID:item.clientID secret:item.secret];

            AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:identifier];
            [client setAuthorizationHeaderWithCredential:credential];

            [client GET:@"https://www.googleapis.com/youtube/v3/channels?part=id&mine=true"
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    LOGD(@"responseObject class=%@", NSStringFromClass([responseObject class]));
                    LOGD(@"responseObject=%@", responseObject);
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    LOGD(@"error=%@", error);
                }];
        };
        OAuth2ServiceItem *o = [[OAuth2ServiceItem alloc] initWithIdentifier:identifier
                                                                       title:@"Google"
                                                                     baseURL:[NSURL URLWithString:@"https://accounts.google.com"]
                                                                    clientID:kDemoOAuth2GoogleClientID
                                                                      secret:kDemoOAuth2GoogleSecret
                                                             verifyParameter:@"code"
                                                            requestTokenPath:@""
                                                       userAuthorizationPath:@"/o/oauth2/auth"
                                                                 callbackURL:kDemoOAuth2GoogleCallbackURL
                                                             accessTokenPath:@"/o/oauth2/token"
                                                                       scope:scope
                                                           testActionHandler:testActionHandler];
        o.credential = [AFOAuthCredential retrieveCredentialWithIdentifier:identifier];
        [result addObject:o];
    }

    // GitHub
    {
        NSString *identifier = @"B1D00630-C6DB-4E92-90C9-36EA2CBC26BE";
        NSString *scope = [@"user:email" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        OAuth2ServiceItemTestActionHandler testActionHandler = ^(OAuth2ServiceItem *item) {
            LOGD(@"item=%@", item);

            AFOAuth2Client *client = [AFOAuth2Client clientWithBaseURL:item.baseURL clientID:item.clientID secret:item.secret];

            AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:identifier];
            [client setAuthorizationHeaderWithCredential:credential];

            [client GET:@"https://api.github.com/user/emails"
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    LOGD(@"responseObject class=%@", NSStringFromClass([responseObject class]));
                    LOGD(@"responseObject=%@", responseObject);
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    LOGD(@"error=%@", error);
                }];
        };
        OAuth2ServiceItem *o = [[OAuth2ServiceItem alloc] initWithIdentifier:identifier
                                                                       title:@"GitHub"
                                                                     baseURL:[NSURL URLWithString:@"https://github.com"]
                                                                    clientID:kDemoOAuth2GitHubClientID
                                                                      secret:kDemoOAuth2GitHubSecret
                                                             verifyParameter:@"code"
                                                            requestTokenPath:@""
                                                       userAuthorizationPath:@"/login/oauth/authorize"
                                                                 callbackURL:kDemoOAuth2GitHubCallbackURL
                                                             accessTokenPath:@"/login/oauth/access_token"
                                                                       scope:scope
                                                           testActionHandler:testActionHandler];
        o.credential = [AFOAuthCredential retrieveCredentialWithIdentifier:identifier];
        [result addObject:o];
    }

    return result;
}

- (BOOL)synchronize
{
    if (_credential) {
        return [AFOAuthCredential storeCredential:_credential withIdentifier:_identifier];
    } else {
        return [AFOAuthCredential deleteCredentialWithIdentifier:_identifier];
    }
}

@end
