//
//  SCImageCaptureViewController.h
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"
NS_ASSUME_NONNULL_BEGIN

@interface SCImageCaptureViewController : UIViewController<AVCapturePhotoCaptureDelegate>
@property (weak, nonatomic) IBOutlet UIView *view_cameraCapture;
- (IBAction)btn_capture:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_preview;
- (IBAction)btnClose:(id)sender;

@end

NS_ASSUME_NONNULL_END
