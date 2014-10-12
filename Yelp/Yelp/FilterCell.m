//
//  FilterCell.m
//  Yelp
//
//  Created by Sneha  Datla on 10/11/14.
//  Copyright (c) 2014 Sneha  Datla. All rights reserved.
//

#import "FilterCell.h"

@implementation FilterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didChangeValue:(id)sender {
    BOOL val = self.filterCell.on;
    [self.delegate filterCell:self didChangeValue:val];
}


@end
