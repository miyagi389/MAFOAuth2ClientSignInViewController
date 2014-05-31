//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import "AllInputViewController.h"

#import "NSString+Local.h"
#import "Pair.h"

@implementation AllInputViewController
{
    NSArray/*<Pair *>*/ *_objects;
}

#pragma mark - Managing the detail item

- (void)setItem:(OAuth2ServiceItem *)item
{
    if (_item != item) {
        _item = item;

        _objects = [self convertObjects:item];

        [self configureView];
    }
}

- (NSArray *)convertObjects:(OAuth2ServiceItem *)item
{
    NSMutableArray *result = [NSMutableArray array];

    if (!item) {
        return result;
    }

    [result addObject:[Pair pairWithFirst:@"baseURL" second:[NSString nilToWhitespace:item.baseURL.absoluteString]]];
    [result addObject:[Pair pairWithFirst:@"clientID" second:[NSString nilToWhitespace:item.clientID]]];
    [result addObject:[Pair pairWithFirst:@"secret" second:[NSString nilToWhitespace:item.secret]]];
    [result addObject:[Pair pairWithFirst:@"verifyParameter" second:[NSString nilToWhitespace:item.verifyParameter]]];
    [result addObject:[Pair pairWithFirst:@"requestTokenPath" second:[NSString nilToWhitespace:item.requestTokenPath]]];
    [result addObject:[Pair pairWithFirst:@"userAuthorizationPath" second:[NSString nilToWhitespace:item.userAuthorizationPath]]];
    [result addObject:[Pair pairWithFirst:@"callbackURL" second:[NSString nilToWhitespace:item.callbackURL.absoluteString]]];
    [result addObject:[Pair pairWithFirst:@"accessTokenPath" second:[NSString nilToWhitespace:item.accessTokenPath]]];
    [result addObject:[Pair pairWithFirst:@"scope" second:[NSString nilToWhitespace:item.scope]]];

    return result;
}

- (void)configureView
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureView];
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

    Pair *o = _objects[indexPath.row];

    cell.textLabel.text = o.first;
    cell.detailTextLabel.text = o.second;
    
    return cell;
}

@end
