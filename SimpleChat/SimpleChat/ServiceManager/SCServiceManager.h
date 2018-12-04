//
//  SCServiceManager.h
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCServiceManager : NSObject
typedef void(^serviceBlock)(id responseData, NSError *error);
+(instancetype)sharedManager;
-(void)getChatMessage:(serviceBlock)serviceblock;
@end

NS_ASSUME_NONNULL_END
