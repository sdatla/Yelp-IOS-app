//
//  ResultCell.h
//  YelpProject
//
//  Created by Sneha Datla on 9/23/14.
//  Copyright (c) 2014 Sneha Datla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *businessImage;
@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starsImage;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
