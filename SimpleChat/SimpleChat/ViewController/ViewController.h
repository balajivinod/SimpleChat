//
//  ViewController.h
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txt_message;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_attach;
- (IBAction)txtDidBeginEditing:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tbl_messages;
- (IBAction)btn_chooseImage:(id)sender;

@end

