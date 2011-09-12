//
//  MemberDetailsViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 29/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"
#import <MessageUI/MessageUI.h>

@interface MemberDetailsViewController : UITableViewController<UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
Member *member;
}
@property (nonatomic, retain) Member *member;

//- (IBAction)back:(id)sender;

-(void)sendEmail;
-(void)confirmEmail;
-(void)openWebPage;
-(void)confirmWebPage;
-(void)showTweets;
@end
