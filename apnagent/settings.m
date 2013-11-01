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

+ (id)sharedSettings {
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

@end
