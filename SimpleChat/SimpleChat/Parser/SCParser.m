//
//  SCParser.m
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import "SCParser.h"
#import "SCMessage.h"
#import "SCMessageAttachment.h"

@implementation SCParser

+(NSArray *)parseChatMessagesResponse:(id)response
{
    NSMutableArray *messagesArray;
    SCMessage *message;
    
    NSArray *responseArray = (NSArray *)[response objectForKey:@"messages"];
    
    if(responseArray)
    {
        messagesArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *messagesDict in responseArray)
        {
            message = [[SCMessage alloc] init];
            
            if([messagesDict objectForKey:@"type"])
            {
                message.messageType = [messagesDict objectForKey:@"type"];
            }
            if([messagesDict objectForKey:@"text"])
            {
                message.messageText = [messagesDict objectForKey:@"text"];
            }
            if([messagesDict objectForKey:@"from"])
            {
                message.messageFrom = [messagesDict objectForKey:@"from"];
            }
            if([messagesDict objectForKey:@"to"])
            {
                message.messageTo = [messagesDict objectForKey:@"to"];
            }
            if([messagesDict objectForKey:@"sender_name"])
            {
                message.senderName = [messagesDict objectForKey:@"sender_name"];
            }
            
            if([messagesDict objectForKey:@"attachment"])
            {
                message.attachments = [self parseMessageAttachment:[messagesDict objectForKey:@"attachment"]];
            }
            
            [messagesArray addObject:message];
        }
    }
    
    return messagesArray;
}


+(NSArray *)parseMessageAttachment:(NSArray *)attachmentsArray
{
    NSMutableArray *attachmentsArr;
    SCMessageAttachment *attachment;
    
    if(attachmentsArray)
    {
        attachmentsArr = [[NSMutableArray alloc] init];
        for(NSDictionary *attachmentsDict in attachmentsArray)
        {
            attachment = [[SCMessageAttachment alloc] init];
            if([attachmentsDict objectForKey:@"type"])
            {
                attachment.attachmentType = [attachmentsDict objectForKey:@"type"];
            }
            if([attachmentsDict objectForKey:@"caption"])
            {
                attachment.caption = [attachmentsDict objectForKey:@"caption"];
            }
            if([attachmentsDict objectForKey:@"payload"])
            {
                NSDictionary *payloadDict = [attachmentsDict objectForKey:@"payload"];
                if([payloadDict objectForKey:@"url"])
                attachment.url = [payloadDict objectForKey:@"url"];
            }
            
            [attachmentsArr addObject:attachment];
        }
    }
    
    return attachmentsArr;
}


@end
