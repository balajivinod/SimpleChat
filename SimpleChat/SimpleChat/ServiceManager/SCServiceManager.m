//
//  SCServiceManager.m
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import "SCServiceManager.h"
#import "SCConstants.h"
#import "SCParser.h"

@implementation SCServiceManager

+(instancetype)sharedManager
{
    static id sharedManager;
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(sharedManager == nil)
            sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


-(void)getChatMessage:(serviceBlock)serviceblock
{
    __block NSArray *messagesArray;
    
    NSURL *taskURL = [NSURL URLWithString:Get_Messages_URL];
    
    NSURLSession *sharedSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithURL:taskURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(!error)
        {
            id jsonString = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            messagesArray = (NSArray *)[SCParser parseChatMessagesResponse:jsonString];

        }
       
        serviceblock(messagesArray, error);
        
    }];
    
    [dataTask resume];
}

@end
