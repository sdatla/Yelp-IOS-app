//
//  FilterViewController.m
//  YelpProject
//
//  Created by Sneha Datla on 9/24/14.
//  Copyright (c) 2014 Sneha Datla. All rights reserved.
//

#import "FilterCell.h"
#import "ResultsViewController.h"
#import "FilterViewController.h"

@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (strong, nonatomic) NSMutableDictionary *isCollapsed;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSArray * sortBy;
@property (strong, nonatomic) NSArray *distance;
@property (nonatomic) BOOL *dealsIsSelected;
@property (nonatomic) int sortNum;
@property (nonatomic) int distNum;
@property (nonatomic, strong) NSMutableDictionary *filterStates;


@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.filterStates = [NSMutableDictionary dictionary];
        self.categories =
                        @[
                            @{ @"name" : @"Bagels",
                               @"id" : @"bagels"},
                            @{ @"name" : @"Bakeries",
                               @"id" : @"bakeries"},
                            @{ @"name" : @"Beverage Stores",
                               @"id" : @"beverage_stores"},
                            @{ @"name" : @"Bubble Tea",
                               @"id" : @"bubbletea"},
                            @{ @"name" : @"Coffee & Tea",
                               @"id" : @"coffee"},
                            @{ @"name" : @"Convenience Stores",
                               @"id" : @"convenience"},
                            @{ @"name" : @"Cupcakes",
                               @"id" : @"cupcakes"},
                            @{ @"name" : @"Delicatessen",
                               @"id" : @"delicatessen"},
                            @{ @"name" : @"Desserts",
                               @"id" : @"desserts"},
                            @{ @"name" : @"Farmers Market",
                               @"id" : @"farmersmarket"},
                            @{ @"name" : @"Food Trucks",
                               @"id" : @"foodtrucks"},
                            @{ @"name" : @"Gelato",
                               @"id" : @"gelato"},
                            @{ @"name" : @"Grocery",
                               @"id" : @"grocery"},
                            @{ @"name" : @"Honey",
                               @"id" : @"honey"},
                            @{ @"name" : @"Ice Cream & Frozen Yogurt",
                               @"id" : @"icecream"},
                            @{ @"name" : @"Internet Cafes",
                               @"id" : @"internetcafe"},
                            @{ @"name" : @"Juice Bars & Smoothies",
                               @"id" : @"juicebars"},
                            @{ @"name" : @"Organic Stores",
                               @"id" : @"organic_stores"},
                            @{ @"name" : @"Specialty Food",
                               @"id" : @"gourmet"}
                            ];

        self.dealsIsSelected = NO;
        self.sortBy = @[
                           @"Best Match",
                           @"Distance",
                           @"Highest Rated"
                           ];
        self.sortNum = 0;
        self.distance = @[
                           @{ @"name" : @"500 meters",
                              @"meters" : @"500"},
                           @{ @"name" : @"1600 meters",
                              @"meters" : @"1600"},
                           @{ @"name" : @"8000 meters",
                              @"meters" : @"8000"},
                           @{ @"name" : @"40000 meters",
                              @"meters" : @"40000"}
                           ];
        self.distNum = 0;
        
    self.isCollapsed = [NSMutableDictionary dictionary];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.filterTableView.delegate = self;
    self.filterTableView.dataSource = self;
    self.filterTableView.rowHeight = 50;
    
    [self.filterTableView registerNib:[UINib nibWithNibName:@"FilterCell" bundle:nil]forCellReuseIdentifier:@"FilterCell"];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Search"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(onSearch)];
    
    
    self.navigationItem.rightBarButtonItem = searchButton;
    self.navigationItem.title = @"Search Filters";

}


-(void) onSearch{
    NSLog(@"Searching");
    BOOL deals;
    if(self.dealsIsSelected == 0)
    {
        deals = NO;

    }
    else{
        deals = YES;

    }
    NSString *sortNumber = [NSString stringWithFormat:@"%d", self.sortNum];
    NSString *distNumber = [self.distance[self.distNum] objectForKey:@"meters"];
    [self.delegate setFilters:self.categories filterStates:self.filterStates sortNum:sortNumber distNum:distNumber deals:deals];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(![self.isCollapsed[@(section)] boolValue]){
        return 1;
    }
    else{
        if(section == 0)
        {
            return self.categories.count;
        }
        if(section == 1)
        {
            return self.sortBy.count;
        }
        if(section == 2)
        {
            return self.distance.count;
        }
        else if(section == 3)
        {
            return 1;
        }
        else
        {
            return 1;
        }
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)
    {
        if(self.isCollapsed[@(0)]){
            FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell"];
            cell.filterText.text = [self.categories[indexPath.row] objectForKey:@"name"];
            BOOL on = [self.filterStates[@(indexPath.row)] boolValue];
            [cell.filterCell setOn:on];
            cell.delegate = self;
            return cell;
        }
        else{
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            UILabel *seeAllLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320, 50)];
            seeAllLabel.text = @"See All";
            [cell addSubview:seeAllLabel];
            return cell;
        }
    }
    else if(indexPath.section == 1)
    {
        if(self.isCollapsed[@(1)]){
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        UILabel *sortByLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320, 50)];
            if(indexPath.row == 0)
            {
                sortByLabel.text = self.sortBy[self.sortNum];
            }
            else{
                sortByLabel.text = self.sortBy[indexPath.row];
            }
            [cell addSubview:sortByLabel];
            return cell;
        }
        else{
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            UILabel *sortByLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320, 50)];
            sortByLabel.text = self.sortBy[self.sortNum];
            [cell addSubview:sortByLabel];
            return cell;
        }

    }
   else if(indexPath.section == 2)
   {
        if(self.isCollapsed[@(2)]){
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        UILabel *distLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320, 50)];
            if(indexPath.row == 0)
            {
                distLabel.text = [self.distance[self.distNum] objectForKey:@"name"];
            }
            else{
                distLabel.text = [self.distance[indexPath.row] objectForKey:@"name"];
            }
        [cell addSubview:distLabel];
        return cell;
        }
        else{
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            UILabel *distLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320, 50)];
            distLabel.text = [self.distance[self.distNum] objectForKey:@"name"];
            [cell addSubview:distLabel];
            return cell;
        }

    }
   else if(indexPath.section == 3)
    {
        FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell"];
        cell.filterText.text = @"Deals";
        if (self.dealsIsSelected) {
            [cell.filterCell setOn:YES animated:NO];
        } else {
            [cell.filterCell setOn:NO animated:NO];
        }
        cell.delegate = self;
        return cell;
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.isCollapsed[@(indexPath.section)] = @(![self.isCollapsed[@(indexPath.section)] boolValue]);
  
    if (indexPath.section == 1) {

        if( self.isCollapsed[@(1)])
        {
            self.sortNum =  indexPath.row;
        }
    }
    else if (indexPath.section == 2) {
        if(self.isCollapsed[@(2)])
        {
            self.distNum = indexPath.row;
        }
    }
    [self.filterTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    headerView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 50)];
    
    if(section == 0)
    {
        headerLabel.text = [NSString stringWithFormat:@"Category"];
    }
    else if(section == 1){
        
        headerLabel.text = [NSString stringWithFormat:@"Sort by"];
    }
    else if(section == 2){
        headerLabel.text = [NSString stringWithFormat:@"Radius (meters)"];
    }
    else if(section == 3){
        headerLabel.text = [NSString stringWithFormat:@"Deals"];
    }
    headerLabel.font = [UIFont systemFontOfSize:20];
    headerLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1];
    [headerView addSubview:headerLabel];
    return headerView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
    
}

-(void)filterCell:(FilterCell *)filterCell didChangeValue:(BOOL)value{
    NSIndexPath *indexPath = [self.filterTableView indexPathForCell:filterCell];
    if(indexPath.section == 3)
    {
        self.dealsIsSelected = &(value);
    }
    else{
        self.filterStates[@(indexPath.row)] = @(value);
    }
    
    
}


@end

