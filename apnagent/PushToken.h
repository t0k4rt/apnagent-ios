//
//  PushToken.h
//  apnagent
//
//  Created by Alexandre Assouad on 01/11/2013.
//  Copyright (c) 2013 Jake Luer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "settings.h"

@interface PushToken : NSObject

@property (nonatomic) NSString *token;

- (id)initWithToken: (NSData*) token;

- (void)showToken;

- (void)sendToken;

@end
