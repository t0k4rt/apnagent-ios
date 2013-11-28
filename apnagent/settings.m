//
//  settings.m
//  apnagent
//
//  Created by Alexandre Assouad on 01/11/2013.
//  Copyright (c) 2013 Jake Luer. All rights reserved.
//

#import "settings.h"

@implementation settings

@synthesize baseUrl;
@synthesize subscribeEndpoint;
@synthesize getNotificationEndpoint;

+ (id)sharedSettings
{
    static settings *sharedSettings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSettings = [[self alloc] init];
    });
    return sharedSettings;
}


- (id)init
{
    self = [super init];
    if ( self ) {
        
        self->baseUrl = @"http://kairosapns.herokuapp.com";
        self->subscribeEndpoint = @"/api/subscribe";
        self->getNotificationEndpoint = @"/api/notification";
    
    }
    return self;
}


-(NSMutableString*)getSubscribeUrl
{
    NSMutableString *result  = [NSMutableString string];
    [result appendString:self.baseUrl];
    [result appendString:self.subscribeEndpoint];
    NSLog(@"%@",result);
    return result;
}


-(NSMutableString*)getNotificationUrlWithId: (NSInteger *) _startId
{
    NSMutableString *result  = [NSMutableString string];
    [result appendString:self.baseUrl];
    [result appendString:self.getNotificationEndpoint];
    [result appendString:@"/"];
    NSString *startId = [NSString stringWithFormat:@"%i", _startId];
    [result appendString:startId];
    NSLog(@"%@",result);
    return result;
}


-(NSMutableString*)getNotificationUrl
{
    NSMutableString *result  = [NSMutableString string];
    [result appendString:self.baseUrl];
    [result appendString:self.getNotificationEndpoint];
    NSLog(@"%@",result);
    return result;
}
@end
