//
//  SCConstants.h
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#ifndef SCConstants_h
#define SCConstants_h


enum MessageType
{
    kMessageTypeText = 0,
    kMessageTypeImage
} messageType;

#define Get_Messages_URL @"https://raw.githubusercontent.com/rvvivek/Chat-JSON/master/message.json"

#endif /* SCConstants_h */
