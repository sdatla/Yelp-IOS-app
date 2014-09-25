//
//  FilterCell.h
//  YelpProject
//
//  Created by Sneha Datla on 9/24/14.
//  Copyright (c) 2014 Sneha Datla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *filterCellLabel;
@property (weak, nonatomic) IBOutlet UISwitch *dealsSwitch;

@end
