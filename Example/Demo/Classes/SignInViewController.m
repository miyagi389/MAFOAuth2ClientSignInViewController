//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import "SignInViewController.h"

#import "AllInputViewController.h"
#import "AllOutputViewController.h"
#import "NSString+Local.h"

@implementation SignInViewController

#pragma mark - Managing the detail item

- (void)setItem:(OAuth2ServiceItem *)item
{
    if (_item != item) {
        _item = item;

        [self configureView];
    }
}

- (void)configureView
{
    self.title = [NSString nilToWhitespace:_item.title];

    _baseURLLabel.text = [NSString nilToWhitespace:_item.baseURL.absoluteString];
    _clientIDLabel.text = [NSString nilToWhitespace:_item.clientID];
    _secretLabel.text = [NSString nilToWhitespace:_item.secret];

    _accessTokenLabel.text = [NSString nilToWhitespace:_item.credential.accessToken];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureView];
}

#pragma mark - Table View

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self didSignIn];
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        [self didClear];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)didSignIn
{
    [self performSegueWithIdentifier:@"showSignIn" sender:self];
}

- (void)didClear
{
    _item.credential = nil;
    [_item synchronize];
    [self configureView];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueIdentifier = [segue identifier];
    if ([segueIdentifier isEqualToString:@"showSignIn"]) {
        [self prepareShowSignInForSegue:segue];
    } else if ([segueIdentifier isEqualToString:@"showAllInput"]) {
        [self prepareShowAllInputInForSegue:segue];
    } else if ([segueIdentifier isEqualToString:@"showAllOutput"]) {
        [self prepareShowAllOutputInForSegue:segue];
    }
}

- (void)prepareShowSignInForSegue:(UIStoryboardSegue *)segue
{
    // UIWebView にログイン情報が保持されてしまうので、 Cookie を削除する。
    [self deleteAllHTTPCookies];

    MAFOAuth2ClientSignInViewController *controller = (MAFOAuth2ClientSignInViewController *) [segue destinationViewController];
    controller.delegate = self;
    controller.baseURL = _item.baseURL;
    controller.clientID = _item.clientID;
    controller.secret = _item.secret;
    controller.verifyParameter = _item.verifyParameter;
    controller.requestTokenPath = _item.requestTokenPath;
    controller.userAuthorizationPath = _item.userAuthorizationPath;
    controller.callbackURL = _item.callbackURL;
    controller.accessTokenPath = _item.accessTokenPath;
    controller.scope = _item.scope;
}

- (void)prepareShowAllInputInForSegue:(UIStoryboardSegue *)segue
{
    AllInputViewController *controller = (AllInputViewController *) [segue destinationViewController];
    controller.item = _item;
}

- (void)prepareShowAllOutputInForSegue:(UIStoryboardSegue *)segue
{
    AllOutputViewController *controller = (AllOutputViewController *) [segue destinationViewController];
    controller.item = _item;
}

#pragma mark - MAFOAuth2ClientSignInViewControllerDelegate

- (void)signInViewControllerLoginSuccess:(MAFOAuth2ClientSignInViewController *)viewController credential:(AFOAuthCredential *)credential
{
    LOGD(@"credential=%@", credential);
    _item.credential = credential;
    [_item synchronize];
    [self configureView];
    [self.navigationController popToViewController:self animated:YES];
    _item.testActionHandler(_item);
}

- (void)signInViewControllerLoginFailure:(MAFOAuth2ClientSignInViewController *)viewController error:(NSError *)error
{
    LOGD(@"error=%@", error);

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentication error"
                                                    message:error.localizedDescription
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Private

- (void)deleteAllHTTPCookies
{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [[cookieStorage cookies] enumerateObjectsUsingBlock:^(NSHTTPCookie *cookie, NSUInteger idx, BOOL *stop) {
        [cookieStorage deleteCookie:cookie];
    }];
}

@end
