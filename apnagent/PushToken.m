//
//  PushToken.m
//  apnagent
//
//  Created by Alexandre Assouad on 01/11/2013.
//  Copyright (c) 2013 Jake Luer. All rights reserved.
//

#import <AFNetworking.h>
#import "PushToken.h"
#import "settings.h"

@implementation PushToken

@synthesize token;

- (id)initWithToken: (NSData *) _token
{
    // convert token to string
    const unsigned *tokenBytes = [_token bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    if (self = [super init]) {
        [self setToken:(NSString *)hexToken];
        NSLog(@"set token : %@", self.token);
    }
    return self;
}

- (void)showToken
{
    NSLog(@"%@",self.token);
}

- (void)sendToken {
    
    NSLog(@"Sending token");
    
    settings *sharedSettings = [settings sharedSettings];
    NSMutableString *subscribeUrl = [sharedSettings getSubscribeUrl];
    
    NSLog(@"Using url : %@", subscribeUrl);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"token": self.token};
    [manager POST:subscribeUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", operation.responseString);
        NSLog(@"Error: %@", error);
    }];
}

@end
