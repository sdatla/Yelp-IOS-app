//
//  SearchResultsViewController.h
//  YelpProject
//
//  Created by Sneha Datla on 9/23/14.
//  Copyright (c) 2014 Sneha Datla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsViewController : UIViewController <UITextFieldDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate>




@property (strong, nonatomic) NSArray *results;

@end
