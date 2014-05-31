//
//  Copyright (c) 2014 miyagi389. All rights reserved.
//

#import "AllOutputViewController.h"

#import "NSString+Local.h"
#import "Pair.h"

@implementation AllOutputViewController
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

    AFOAuthCredential *credential = item.credential;

    [result addObject:[Pair pairWithFirst:@"accessToken" second:[NSString nilToWhitespace:credential.accessToken]]];
    [result addObject:[Pair pairWithFirst:@"tokenType" second:[NSString nilToWhitespace:credential.tokenType]]];
    [result addObject:[Pair pairWithFirst:@"refreshToken" second:[NSString nilToWhitespace:credential.refreshToken]]];
    [result addObject:[Pair pairWithFirst:@"isExpired" second:credential ? credential.isExpired ? @"YES" : @"NO" : @" "]];

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
