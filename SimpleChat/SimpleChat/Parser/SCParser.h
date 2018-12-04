//
//  SCParser.h
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCParser : NSObject
+(NSArray *)parseChatMessagesResponse:(id)response;
@end

NS_ASSUME_NONNULL_END
