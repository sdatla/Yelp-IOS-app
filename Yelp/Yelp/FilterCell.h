//
//  FilterCell.h
//  Yelp
//
//  Created by Sneha  Datla on 10/11/14.
//  Copyright (c) 2014 Sneha  Datla. All rights reserved.
//


#import <UIKit/UIKit.h>

@class FilterCell;

@protocol FilterCellDelegate <NSObject>

-(void)filterCell:(FilterCell *)filterCell didChangeValue:(BOOL)value;

@end

@interface FilterCell : UITableViewCell
@property (nonatomic, weak) id<FilterCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *filterText;

@property (strong, nonatomic) IBOutlet UISwitch *filterCell;

@end
