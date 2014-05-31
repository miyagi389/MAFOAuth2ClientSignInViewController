//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFOAuth2Client/AFOAuth2Client.h>

@class MAFOAuth2ClientSignInViewController;

@protocol MAFOAuth2ClientSignInViewControllerDelegate <NSObject>

@optional

- (void)signInViewControllerLoginSuccess:(MAFOAuth2ClientSignInViewController *)viewController
                              credential:(AFOAuthCredential *)credential;

- (void)signInViewControllerLoginFailure:(MAFOAuth2ClientSignInViewController *)viewController
                                   error:(NSError *)error;

@end
