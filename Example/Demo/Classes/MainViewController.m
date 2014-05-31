//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import "MainViewController.h"
#import "OAuth2ServiceItem.h"
#import "SignInViewController.h"

@implementation MainViewController
{
    NSArray/*<OAuth2ServiceItem *>*/ *_objects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _objects = [OAuth2ServiceItem defaultItems];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    OAuth2ServiceItem *o = _objects[indexPath.row];

    cell.textLabel.text = o.title;

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SignInViewController *destinationViewController = [segue destinationViewController];
        OAuth2ServiceItem *o = _objects[indexPath.row];
        destinationViewController.item = o;
    }
}

@end
