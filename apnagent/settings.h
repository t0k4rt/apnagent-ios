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
    NSString *getNotificationEndpoint;
}

@property (nonatomic, readonly) NSString *baseUrl;
@property (nonatomic, readonly) NSString *subscribeEndpoint;
@property (nonatomic, readonly) NSString *getNotificationEndpoint;

+ (id)sharedSettings;

- (NSMutableString*)getSubscribeUrl;
- (NSMutableString*)getNotificationUrlWithId: (NSInteger *) _startId;
- (NSMutableString*)getNotificationUrl;

@end
