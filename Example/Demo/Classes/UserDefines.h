//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import <Foundation/Foundation.h>

// Feedly
// see: https://groups.google.com/forum/#!forum/feedly-cloud
#define kDemoOAuth2FeedlyClientID @"sandbox"
#define kDemoOAuth2FeedlySecret @"ES3R6KCEG46BW9MYD332" // (expires on 8/1/2014)
#define kDemoOAuth2FeedlyCallbackURL [NSURL URLWithString:@"http://localhost"]

// Google (YouTube DATA API)
// see: https://developers.google.com/youtube/v3/guides/authentication
#define kDemoOAuth2GoogleClientID @"[YOUR APP ClientID]"
#define kDemoOAuth2GoogleSecret @"[YOUR APP Secret]"
#define kDemoOAuth2GoogleCallbackURL [NSURL URLWithString:@"[YOUR APP Callback URL]"]

// GitHub
// see: https://github.com/settings/applications/new
#define kDemoOAuth2GitHubClientID @"[YOUR APP ClientID]"
#define kDemoOAuth2GitHubSecret @"[YOUR APP Secret]"
#define kDemoOAuth2GitHubCallbackURL [NSURL URLWithString:@"[YOUR APP Callback URL]"]
