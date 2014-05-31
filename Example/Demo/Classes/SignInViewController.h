//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MAFOAuth2ClientSignInViewController.h>
#import <MAFOAuth2ClientSignInViewControllerDelegate.h>

#import "OAuth2ServiceItem.h"

@interface SignInViewController : UITableViewController <MAFOAuth2ClientSignInViewControllerDelegate>

@property (nonatomic) OAuth2ServiceItem *item;

@property (weak, nonatomic) IBOutlet UILabel *baseURLLabel;

@property (weak, nonatomic) IBOutlet UILabel *clientIDLabel;

@property (weak, nonatomic) IBOutlet UILabel *secretLabel;

@property (weak, nonatomic) IBOutlet UILabel *accessTokenLabel;

@end
