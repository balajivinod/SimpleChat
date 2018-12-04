//
//  TextCellTwo.h
//  SimpleChat
//
//  Created by BalajiMAC on 04/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextCellTwo : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl_message;
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_senderIcon;

@end

NS_ASSUME_NONNULL_END
