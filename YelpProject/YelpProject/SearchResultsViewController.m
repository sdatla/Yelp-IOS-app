//

//  SearchResultsViewController.m

//  YelpProject

//

//  Created by Sneha Datla on 9/23/14.

//  Copyright (c) 2014 Sneha Datla. All rights reserved.

//


#import "SearchResultsViewController.h"

#import "ResultCell.h"

#import "YelpClient.h"

#import "UIImageView+AFNetworking.h"
#import "FilterCell.h"
#import "FilterViewController.h"



NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";

NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";

NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";

NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";


@interface SearchResultsViewController ()

@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) NSArray *searchResults;

@property (strong, nonatomic) YelpClient *client;

@property (strong, nonatomic) UITableView *searchResultsTableView;

@property (strong, nonatomic) UISearchBar *searchBar;


- (IBAction)onTap:(id)sender;

@property (strong, nonatomic) NSArray *business;

@end


@implementation SearchResultsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        
        
    }
    
    return self;
    
}


-(void) viewWillAppear:(BOOL)animated

{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *sortStr = [defaults stringForKey:@"sortby"];
    
    NSString *radiusStr = [defaults stringForKey:@"radius"];
    
    NSLog(@"Soarting by %@ :", sortStr);
    
    NSLog(@"Raadius by %@ :", radiusStr);
    
}



- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [NSString stringWithFormat:@"%@", @"Best Match"];
    
    [defaults setObject:str forKey:@"sortby"];
    
    [defaults setObject:str forKey:@"radius"];

    
    [defaults synchronize];
    
    
    
    self.searchResultsTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    self.searchResultsTableView.delegate = self;
    
    self.searchResultsTableView.dataSource = self;
    
    self.searchResultsTableView.rowHeight = 110;
    [self.searchResultsTableView registerNib:[UINib nibWithNibName:@"ResultCell" bundle:nil]forCellReuseIdentifier:@"ResultCell"];
    
    
    [self.view addSubview:self.searchResultsTableView];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 44.0)];
    
    self.searchBar.placeholder = @"Search for..";
    
    self.searchBar.delegate = self;
    
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    
 
    [searchBarView addSubview:self.searchBar];
    
    self.navigationItem.titleView = searchBarView;
    
    
    
    
    
    UISearchDisplayController *searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    
    
    searchDisplayController.delegate = self;
    
    searchDisplayController.searchResultsDataSource = self.searchResultsTableView.dataSource;
    
    searchDisplayController.searchResultsDelegate = self.searchResultsTableView.delegate;
    
    
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc]
                                     
                                     initWithTitle:@"Filter"
                                     
                                     style:UIBarButtonItemStyleBordered
                                     
                                     target:self
                                     
                                     action:@selector(onFilter)];
    
    self.navigationItem.leftBarButtonItem = filterButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     
                                     initWithTitle:@"Cancel"
                                     
                                     style:UIBarButtonItemStyleBordered
                                     
                                     target:self
                                     
                                     action:@selector(onCancel)];
    
    self.navigationItem.rightBarButtonItem = cancelButton;
}


- (void) onFilter{
    
    [self.navigationController pushViewController:[[FilterViewController alloc] init] animated:YES];
    
}

- (void) onCancel{
    
    [self.searchBar endEditing:YES];
    
}

- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.business.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    ResultCell *cell = [self.searchResultsTableView dequeueReusableCellWithIdentifier:@"ResultCell"];
    
    
    cell.businessNameLabel.text = self.business[indexPath.row][@"name"];
    
    cell.reviewNumberLabel.text = [self.business[indexPath.row][@"review_count"] stringValue];
    
    NSArray *addressObj = self.business[indexPath.row][@"location"][@"display_address"];
    
    NSString *addressStr = [addressObj objectAtIndex:0];
    
    cell.addressLabel.text =  addressStr;
    
    
    
    NSArray *categ = self.business[indexPath.row][@"categories"];
    
    
    
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
    
    
    
    NSString *businessImageURL = self.business[indexPath.row][@"image_url"];
    
    
    NSString *ratingImageURL = self.business[indexPath.row][@"rating_img_url"];
    
    
    
    [cell.businessImage setImageWithURL:[NSURL URLWithString:businessImageURL]];
    
    
    
    [cell.starsImage setImageWithURL:[NSURL URLWithString:ratingImageURL]];
    
    
    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.searchResultsTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    
    [self.client searchWithTerm:searchBar.text success:^(AFHTTPRequestOperation *operation, id response) {
        
        self.business = response[@"businesses"];
        
        [self.searchResultsTableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@", [error description]);
        
    }];
    
    
    
}


- (IBAction)onTap:(id)sender {
    
    [self.searchBar resignFirstResponder];
    
}

@end