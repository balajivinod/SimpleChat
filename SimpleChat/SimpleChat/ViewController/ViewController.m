//
//  ViewController.m
//  SimpleChat
//
//  Created by BalajiMAC on 03/12/18.
//  Copyright © 2018 BalajiMAC. All rights reserved.
//

#import "ViewController.h"
#import "SCServiceManager.h"
#import "TextCell.h"
#import "TextCellTwo.h"
#import "ImageCell.h"
#import "SCMessage.h"
#import "SCMessageAttachment.h"
#import "SCConstants.h"
#import "MBProgressHUD.h"

#define kHardCodedTime @"15:18"
#define kTextCellIdentifier @"textCell"
#define kTextCellTwoIdentifier @"textCellTwo"
#define kImageCellIdentifier @"imageCell"
#define kCameraSegue @"cameraSegue"

#define FONT_SIZE 15.0f
#define CELL_CONTENT_WIDTH 375.0f
#define CELL_CONTENT_MARGIN 10.0f


CGFloat kTextCellHeight = 90.0f, kImageCellHeight = 181.0f;
@interface ViewController ()
{
    NSArray *messagesArray;
    int currentPage;
    int offsetX;
    BOOL isEnded,isUserScrolled;
    NSString *tempFrom;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isEnded=false;
    currentPage=0;
    offsetX=-1;
    self.navigationItem.title = @"Steve Jobs";
    [self setUpKeyboardShowNotificationObserver];
    
    [self getChatMessagesFromWebService:^(BOOL success) {
        
        if(success)
        {

            dispatch_async(dispatch_get_main_queue(), ^{
               
                [MBProgressHUD hideHUDForView:self.view animated:NO];
                if(self->messagesArray)
                    [self.tbl_messages reloadData];
                
            });
        }
    }];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)getChatMessagesFromWebService:(void(^)(BOOL success))successBlock
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __block BOOL kSuccess;
    
    dispatch_queue_t globalQueue;
    globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(globalQueue, ^{
        
            [[SCServiceManager sharedManager] getChatMessage:^(id  _Nonnull responseData, NSError * _Nonnull error){
                
                if(!error)
                {
                    self->messagesArray = (NSArray *)responseData;
                    kSuccess = true;
                    
                }
                else
                {
                    kSuccess = false;
                    NSLog(@"Error %@", [error localizedDescription]);
                    
                }
                
                successBlock(kSuccess);
                
            }];
    
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([messagesArray count]>0)
        return [messagesArray count];
    else
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SCMessage *message = (SCMessage *)[messagesArray objectAtIndex:indexPath.row];
    if(message)
    {
        if(indexPath.row == 0)
            tempFrom = message.messageFrom;
        
        if([message.messageType isEqualToString:@"text"])
        {
            if([tempFrom isEqualToString:message.messageFrom])
            {
                TextCell *cell = (TextCell *)[tableView dequeueReusableCellWithIdentifier:kTextCellIdentifier];
                cell.lbl_date.text = [NSString stringWithFormat:@"  %@ %@",message.senderName, kHardCodedTime];
                cell.lbl_message.text = [NSString stringWithFormat:@"  %@", message.messageText];
                cell.lbl_date.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"incoming"]];
                cell.lbl_message.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"incoming"]];
                cell.imgView_senderIcon.image = [UIImage imageNamed:@"sendericon"];
                return cell;
            }
            else
            {
                TextCellTwo *cell = (TextCellTwo *)[tableView dequeueReusableCellWithIdentifier:kTextCellTwoIdentifier];
                cell.lbl_date.text = [NSString stringWithFormat:@"  %@ %@",message.senderName, kHardCodedTime];
                cell.lbl_message.text = [NSString stringWithFormat:@"  %@", message.messageText];
                cell.lbl_date.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"outgoing"]];
                cell.lbl_message.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"outgoing"]];
                cell.imgView_senderIcon.image = [UIImage imageNamed:@"receivericon"];
                return cell;
            }
            
            
        }
        else
        {
            ImageCell *cell = (ImageCell *)[tableView dequeueReusableCellWithIdentifier:kImageCellIdentifier];
            if(message.attachments)
            {
                CGFloat scrollViewHeight = cell.scrllView_image.frame.size.height;
                CGFloat scrollViewWidth = cell.scrllView_image.frame.size.width;
                CGFloat scrollViewContentSize = 0.0;
                int incrementer = 0;
                
                for(SCMessageAttachment *objAttachment in message.attachments)
                {
                    scrollViewContentSize += scrollViewWidth;
                    CGFloat xPos = incrementer * scrollViewWidth;
                    CGRect imgFrame = CGRectMake( xPos , cell.scrllView_image.frame.origin.y
                                                 , scrollViewWidth, scrollViewHeight);
                    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:objAttachment.url]];
                    UIImageView *imgView = [[UIImageView alloc] init];
                    imgView.image = [UIImage imageWithData:imgData];
                    imgView.frame = imgFrame;
                    [cell.scrllView_image addSubview:imgView];
                    incrementer += 1;
                    
                }
                cell.pageControl.numberOfPages = [message.attachments count];
                cell.scrllView_image.contentSize = CGSizeMake(scrollViewContentSize, scrollViewHeight);
                cell.scrllView_image.delegate = self;
            }
            
            
            
            return cell;
        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCMessage *message = (SCMessage *)[messagesArray objectAtIndex:indexPath.row];
    if([message.messageType isEqualToString:@"text"])
    {
        return kTextCellHeight;
    }
    else
    {
        return kImageCellHeight;
    }
   
}

- (IBAction)txtDidBeginEditing:(id)sender {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self setSuperViewToOriginalPosition];
    return YES;
}


-(void)moveSuperViewUpwards:(CGFloat)heightConstant
{
    CGRect viewFrame = self.view.frame;
    
    viewFrame.origin.y -= heightConstant;
    
    self.view.frame = viewFrame;
}

-(void)setSuperViewToOriginalPosition
{
    CGRect viewFrame = self.view.frame;
    
    viewFrame.origin.y = 0.0;
    
    self.view.frame = viewFrame;
}

- (IBAction)btn_chooseImage:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose Image"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:@"Gallery"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                [self selectPhoto];
                                                            }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               [self takePhoto];
                                                           }];
    
    [alert addAction:galleryAction];
    [alert addAction:cameraAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
}

-(void)closeControl:(id)sender
{
    
}
-(void)sendAction:(id)sender
{
    
}

- (void)takePhoto {
    
    [self performSegueWithIdentifier:kCameraSegue sender:nil];
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [picker.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]
                                                      initWithTitle:@"Close"
                                                      style:UIBarButtonItemStylePlain
                                                      target:nil
                                                      action:@selector(closeControl:)] animated:YES];
    [picker.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]
                                                       initWithTitle:@"Send"
                                                       style:UIBarButtonItemStylePlain
                                                       target:nil
                                                       action:@selector(sendAction:)] animated:YES];
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (void)setUpKeyboardShowNotificationObserver
{
    // This could be in an init method.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShowNotificationMethod:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void)keyboardShowNotificationMethod:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    [self moveSuperViewUpwards:keyboardFrameBeginRect.size.height];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
