//
//  FilterViewController.m
//  YelpProject
//
//  Created by Sneha Datla on 9/24/14.
//  Copyright (c) 2014 Sneha Datla. All rights reserved.
//

#import "FilterCell.h"
#import "SearchResultsViewController.h"
#import "FilterViewController.h"

@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (strong, nonatomic) NSMutableDictionary *isCollapsed;
@property (strong, nonatomic) NSString *sort;
@property (strong, nonatomic) NSString *rad;

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    self.isCollapsed = [NSMutableDictionary dictionary];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.sort = [defaults stringForKey:@"sortby"];
    self.rad  = [defaults stringForKey:@"radius"];

    self.filterTableView.delegate = self;
    self.filterTableView.dataSource = self;
    self.filterTableView.rowHeight = 50;

    [self.filterTableView registerNib:[UINib nibWithNibName:@"FilterCell" bundle:nil]forCellReuseIdentifier:@"FilterCell"];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Search"
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(onSearch)];
    
   
    self.navigationItem.rightBarButtonItem = searchButton;
    
   
    self.navigationItem.title = @"Search Filters";
        
    
    
}


-(void) onSearch{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.sort forKey:@"sortby"];
    [defaults setObject:self.rad forKey:@"radius"];
    [defaults synchronize];
    NSString *sortStr = [defaults stringForKey:@"sortby"];
    NSString *radiusStr = [defaults stringForKey:@"radius"];
    NSLog(@"Sorting by %@ :", sortStr);
    NSLog(@"Radius by %@ :", radiusStr);
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
        if(section == 1)
        {
            return 3;
        }
        if(section == 2)
        {
            return 5;
        }
        else if(section == 3)
        {
            return 1;
        }
        else
        {
            return 3;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FilterCell *cell = [self.filterTableView dequeueReusableCellWithIdentifier:@"FilterCell"];
     cell.dealsSwitch.hidden = YES;
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        NSString *str = [NSString stringWithFormat:@"%@", self.sort];
        cell.filterCellLabel.text = str;
        
    }
    else if(indexPath.section == 1 && indexPath.row == 1)
    {
        NSString *str = [NSString stringWithFormat:@"%@", @"Distance"];
        cell.filterCellLabel.text = str;
    }
    else if(indexPath.section == 1 && indexPath.row == 2)
    {
        
        NSString *str = [NSString stringWithFormat:@"%@", @"Highest Rated"];
        
        cell.filterCellLabel.text = str;
        
    }
    
    else if(indexPath.section == 2 && indexPath.row == 0)
        
    {
        
        NSString *str = [NSString stringWithFormat:@"%@", self.rad ];
        
        cell.filterCellLabel.text = str;
        
    }
    
    else if(indexPath.section == 2 && indexPath.row == 1)
        
    {
        
        NSString *str = [NSString stringWithFormat:@"%@", @"2 blocks"];
        
        cell.filterCellLabel.text = str;
        
    }
    
    else if(indexPath.section == 2 && indexPath.row == 2)
        
    {
        
        NSString *str = [NSString stringWithFormat:@"%@", @"6 blocks"];
        
        cell.filterCellLabel.text = str;
        
    }
    
    else if(indexPath.section == 2 && indexPath.row == 3)
        
    {
        
        NSString *str = [NSString stringWithFormat:@"%@", @"1 mile"];
        
        cell.filterCellLabel.text = str;
        
    }
    
    else if(indexPath.section == 2 && indexPath.row == 4)
        
    {
        
        NSString *str = [NSString stringWithFormat:@"%@", @"5 miles"];
        
        cell.filterCellLabel.text = str;
        
    }
    else if(indexPath.section == 3 && indexPath.row == 0)

    {
         NSString *dealOffer = @"Offering a deal";
         cell.filterCellLabel.text = dealOffer;
         cell.dealsSwitch.hidden = NO;
    }
    
    else if(indexPath.section == 0 && indexPath.row == 0)
        
    {
        NSString *str = @"See All";
        cell.filterCellLabel.text = str;
        
    }
    else if(indexPath.section == 0 && indexPath.row == 1)
        
    {
        NSString *str = @"Coffee & Tea";
        cell.filterCellLabel.text = str;
            }
    else if(indexPath.section == 0 && indexPath.row == 2)
        
    {
        NSString *str = @"Specialty Stores";
        cell.filterCellLabel.text = str;
        
    }
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 1 && indexPath.row == 0)
        
    {
        
        self.sort = [NSString stringWithFormat:@"%@", @"Best Match"];
        
    }
    
   if(indexPath.section == 1 && indexPath.row == 1)
        
    {
        
        self.sort = [NSString stringWithFormat:@"%@", @"Distance"];
        
    }
    
    if(indexPath.section == 1 && indexPath.row == 2)
        
    {
        
        self.sort = [NSString stringWithFormat:@"%@", @"Highest Rated"];
        
    }
    
    // [defaults setObject:sortStr forKey:@"sortby"];
    
    
    if(indexPath.section == 2 && indexPath.row == 0)
        
    {
        
        self.rad = [NSString stringWithFormat:@"%@", @"Best Match"];
        
    }
    
    if(indexPath.section == 2 && indexPath.row == 1)
        
    {
        
        self.rad  = [NSString stringWithFormat:@"%@", @"2 blocks"];
        
    }
    
    if(indexPath.section == 2 && indexPath.row == 2)
        
    {
        
        self.rad = [NSString stringWithFormat:@"%@", @"6 blocks"];
        
    }
    
    if(indexPath.section == 2 && indexPath.row == 3)
        
    {
        
        self.rad = [NSString stringWithFormat:@"%@", @"1 mile"];
        
    }
    
    if(indexPath.section == 2 && indexPath.row == 4)
        
    {
        
        self.rad  = [NSString stringWithFormat:@"%@", @"5 miles"];
        
    }

    

    self.isCollapsed[@(indexPath.section)] = @(![self.isCollapsed[@(indexPath.section)] boolValue]);
    
    
    
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

@end