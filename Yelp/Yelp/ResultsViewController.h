//
//  ResultsViewController.h
//  Yelp
//
//  Created by Sneha  Datla on 10/11/14.
//  Copyright (c) 2014 Sneha  Datla. All rights reserved.
//

#import "FilterViewController.h"
#import "YelpClient.h"
#import <UIKit/UIKit.h>
#import "ResultCell.h"

@interface ResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, FilterViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *results;
@property (nonatomic, strong) YelpClient *client;
- (void)searchWithText:(NSString *)text filters:(NSMutableDictionary *)filters;
@end


