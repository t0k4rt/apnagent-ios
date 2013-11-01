//
//  settings.h
//  apnagent
//
//  Created by Alexandre Assouad on 01/11/2013.
//  Copyright (c) 2013 Jake Luer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface settings : NSObject {
    NSString *baseUrl;
    NSString *subscribeEndpoint;
}

@property (nonatomic, readonly) NSString *baseUrl;

@property (nonatomic, readonly) NSString *subscribeEndpoint;

+ (id)sharedSettings;

- (NSMutableString*)getSubscribeUrl;

@end
