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
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    
    NSDictionary *parameters = @{@"term": term, @"location" : @"San Francisco"};
    return [self GET:@"search" parameters:parameters success:success failure:failure];
  
}

-(AFHTTPRequestOperation *)searchWithTerm:(NSString *)term filters:(NSMutableDictionary *)filters success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
{
  
    NSDictionary *parameters = @{@"term": term, @"location" : @"San Francisco"};
    if (filters) {
        [filters addEntriesFromDictionary:parameters];
        NSLog(@"These are filters %@", filters);
        NSLog(@"These are params %@", parameters);
    
    }
    return [self GET:@"search" parameters:filters success:success failure:failure];
}
@end
