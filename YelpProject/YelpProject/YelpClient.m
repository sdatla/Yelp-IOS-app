//
//  YelpClient.m
//  YelpProject
//
//  Created by Sneha Datla on 9/23/14.
//  Copyright (c) 2014 Sneha Datla. All rights reserved.
//

#import "YelpClient.h"

@implementation YelpClient




- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString *sortNum = @"0";
    NSString *radiusNum = @"0";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sorting = [defaults stringForKey:@"sortby"];
    NSString *radius  = [defaults stringForKey:@"radius"];
    
    if([sorting isEqualToString:@"Best Match"])
    {
        sortNum = @"0";
    }
    else if([sorting isEqualToString:@"Distance"])
    {
        sortNum = @"1";
    }
    else if([sorting isEqualToString:@"Highest Rated"])
    {
        sortNum = @"2";
    }
    
    NSDictionary *parameters;
    if([radius isEqualToString:@"Best Match"])
    {
        parameters = @{@"term": term, @"location" : @"San Francisco", @"sort" : sortNum }; }
    else if([radius isEqualToString:@"2 blocks"])
    {
        parameters = @{@"term": term, @"location" : @"San Francisco", @"sort" : sortNum, @"radius_filter" : @"200" };
    }
    else if([radius isEqualToString:@"6 blocks"])
    {
        parameters = @{@"term": term, @"location" : @"San Francisco", @"sort" : sortNum, @"radius_filter" : @"600" };
    }
    else if([radius isEqualToString:@"1 mile"])
    {
        parameters = @{@"term": term, @"location" : @"San Francisco", @"sort" : sortNum, @"radius_filter" : @"1609" };
    }
    else if([radius isEqualToString:@"5 miles"])
    {
        parameters = @{@"term": term, @"location" : @"San Francisco", @"sort" : sortNum, @"radius_filter" : @"8046.72" };
       
    }
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
   
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

@end
