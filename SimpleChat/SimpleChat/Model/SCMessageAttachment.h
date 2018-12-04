//
//  SCMessageAttachment.h
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCMessageAttachment : NSObject
@property(nonatomic, strong)NSString *attachmentType;
@property(nonatomic, strong)NSString *caption;
@property(nonatomic, strong)NSString *url;
@end

NS_ASSUME_NONNULL_END
