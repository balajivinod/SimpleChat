//
//  ImageCell.h
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrllView_image;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *lbl_caption;
@property (weak, nonatomic) IBOutlet UIView *view_Parent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_view_centerX;

@end

NS_ASSUME_NONNULL_END
