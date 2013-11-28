//
//  NotificationListManager.m
//  apnagent
//
//  Created by Alexandre Assouad on 24/11/2013.
//  Copyright (c) 2013 Jake Luer. All rights reserved.
//

#import "NotificationListManager.h"
#import <AFNetworking.h>
#import <FMDB/FMDatabase.h>


@implementation NotificationListManager

+ (void)refreshNotifications
{
    
    FMDatabase *db = [FMDatabase databaseWithPath:NULL];
    if (![db open]) {
        return;
    }
    FMResultSet *createTableQuery = [db executeQuery:@"CREATE TABLE IF NOT EXISTS notifications (id INT CONTRAINT PRIMARY KEY, img_url TEXT, message TEXT, title TEXT, url TEXT, url_title TEXT)"];
    NSLog(@"create query : %@", createTableQuery);
    
    NSLog(@"Getting notifications");
    
    settings *sharedSettings = [settings sharedSettings];
    NSMutableString *notificationUrl = [sharedSettings getNotificationUrl];
    NSLog(@"Using url : %@", notificationUrl);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:notificationUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //FMResultSet *start = [db executeQuery:@"BEGIN TRANSACTION"];
        for (id object in responseObject) {
            // do something with object
            //NSLog(@"JSON: %@", [object objectForKey:@"message"]);
            NSLog(@"class: %@", object);
            
            FMResultSet *insertQuery = [db executeQuery:@"INSERT INTO notifications VALUES (:id, :img_url, :message, :title, :url, :url_title)" withParameterDictionary:object];
            NSLog(@"insert query : %@", insertQuery);
        }
        /*FMResultSet *end = [db executeQuery:@"COMMIT TRANSACTION"];
        NSLog(@"query : %@", end);
        if(end == nil) {
            NSLog(@"issue when commit transaction");
            FMResultSet *end = [db executeQuery:@"ROLLBACK TRANSACTION"];
        }*/
        
        FMResultSet *verif = [db executeQuery:@"SELECT * FROM notifications"];
        while ([verif next]) {
            NSLog(@"dbresult: %@", verif);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", operation.responseString);
        NSLog(@"Error: %@", error);
    }];
}


@end
