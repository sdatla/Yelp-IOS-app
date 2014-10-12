//
//  FilterViewController.h
//  Yelp
//
//  Created by Sneha  Datla on 10/11/14.
//  Copyright (c) 2014 Sneha  Datla. All rights reserved.
//

#import "FilterCell.h"
#import <UIKit/UIKit.h>

@class FilterViewController;

@protocol FilterViewControllerDelegate <NSObject>

- (void)setFilters:(NSArray *)categories filterStates:(NSMutableDictionary *) filterStates sortNum:(NSString *) sortNum distNum:(NSString *) distNum deals:(BOOL) dealsIsSelected;
@end


@interface FilterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FilterCellDelegate>
@property (nonatomic, weak) id <FilterViewControllerDelegate> delegate;
@end
