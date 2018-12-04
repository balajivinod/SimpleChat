//
//  TextCell.h
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView_senderIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UILabel *lbl_message;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_imgView_CenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_lblDate_centerX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_lblMessage_centerX;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgView_Leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbl_date_Leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbl_Message_Leading;

@end

NS_ASSUME_NONNULL_END
