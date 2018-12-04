//
//  SCMessage.h
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCMessage : NSObject
@property(nonatomic, strong)NSString *messageType;
@property(nonatomic, strong)NSString *messageText;
@property(nonatomic, strong)NSString *messageFrom;
@property(nonatomic, strong)NSString *messageTo;
@property(nonatomic, strong)NSString *senderName;
@property(nonatomic, strong)NSArray *attachments;
@end

NS_ASSUME_NONNULL_END
