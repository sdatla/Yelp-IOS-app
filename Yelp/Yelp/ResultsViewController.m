//
//  ResultsViewController.m
//  Yelp
//
//  Created by Sneha  Datla on 10/11/14.
//  Copyright (c) 2014 Sneha  Datla. All rights reserved.
//

#import "ResultsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ResultCell.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.searchBar = [[UISearchBar alloc] init];
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultCell" bundle:nil]forCellReuseIdentifier:@"ResultCell"];
    
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilter)];
    
    self.navigationItem.leftBarButtonItem = filterButton;
    [self.searchBar becomeFirstResponder];
    [self.tableView reloadData];
    
    }

-(void) onFilter{
    
    NSLog(@"Going to filters page");
    FilterViewController *fvc = [[FilterViewController alloc] init];
    fvc.delegate = self;
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.results.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell"];

    cell.businessNameLabel.text = self.results[indexPath.row][@"name"];
    
    cell.reviewNumberLabel.text = [self.results[indexPath.row][@"review_count"] stringValue];
    
    NSArray *addressObj = self.results[indexPath.row][@"location"][@"display_address"];
    
    NSString *addressStr = [addressObj objectAtIndex:0];
    
    cell.addressLabel.text =  addressStr;
    
    NSArray *categ = self.results[indexPath.row][@"categories"];
    
    NSString *str = @"";
    
    for(int i=0; i < categ.count; i++)
    {

        NSArray *strObj = [categ objectAtIndex:i];
        NSString *st = [strObj objectAtIndex:0];
        if(i == categ.count -1)
        {
            str = [str stringByAppendingString:st];
        }
        else{
            str = [str stringByAppendingString:st];
            str = [str stringByAppendingString:@", "];
        }
    }
    cell.categoriesLabel.text = str;
    NSString *businessImageURL = self.results[indexPath.row][@"image_url"];
    NSString *ratingImageURL = self.results[indexPath.row][@"rating_img_url"];
    [cell.businessImage setImageWithURL:[NSURL URLWithString:businessImageURL]];
    [cell.starsImage setImageWithURL:[NSURL URLWithString:ratingImageURL]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.client searchWithTerm:searchText success:^(AFHTTPRequestOperation *operation, id response) {
        
        self.results = response[@"businesses"];
//        NSLog(@"%@", self.results);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", operation.error);
    }];
}
- (void)searchWithText:(NSString *)text filters:(NSMutableDictionary *)filters {
    [self.client searchWithTerm:text filters:filters success:^(AFHTTPRequestOperation *operation, id response) {
        
        self.results = response[@"businesses"];
        [self.tableView reloadData];
         NSLog(@"%@", self.results);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", operation.error);
    }];
}

-(void)setFilters:(NSArray *)categories filterStates:(NSMutableDictionary *)filterStates sortNum:(NSString *)sortNum distNum:(NSString *)distNum deals:(BOOL)dealsIsSelected{
    
    int sort = [sortNum intValue];
    int dist = [distNum intValue];
    int numSelected = 0;
    
    
    NSMutableString *categoryListStr = [NSMutableString stringWithString:@""];
    
    for (int i = 0; i < categories.count; i++) {
        if ([filterStates[@(i)] boolValue]) {
            if (numSelected == 0) {
                [categoryListStr appendString:categories[i][@"id"]];
            } else {
                [categoryListStr appendString:[NSString stringWithFormat:@",%@", categories[i][@"id"]]];
            }
            numSelected++;
        }
    }
    

    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
    
    filters[@"category_filter"] = categoryListStr;
    if(sort == 0)
    {
        filters[@"sort"] = @(0);
        
    }
    else if(sort == 1)
    {
        filters[@"sort"] = @(1);
    }
    else if(sort == 2)
    {
        filters[@"sort"] = @(2);
    }
    NSLog(@"dist is %@", distNum);
    if(dist == 500)
    {
        filters[@"radius_filter"] = @(500);
    }
    else if(dist == 1600)
    {
        filters[@"radius_filter"] = @(1600);
    }
    else if(dist== 8000)
    {
        filters[@"radius_filter"] = @(8000);
    }
    else if(dist== 40000)
    {
        filters[@"radius_filter"] = @(40000);
    }
    filters[@"deals_filter"] = @(dealsIsSelected);
    
    [self searchWithText:self.searchBar.text filters:filters];
    
}

@end
