//
//  JugDetailsViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 26/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  Display a JUG

#import <UIKit/UIKit.h>
#import "JugInformation.h"
#import <MessageUI/MessageUI.h>

@interface JugDetailsViewController : UITableViewController<UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    JugInformation *jug;
}
@property (nonatomic, retain) JugInformation *jug;

-(void)sendEmail;
-(void)confirmEmail;
-(void)openWebPage;
-(void)confirmWebPage;
-(void)showTweets;
-(void)showMap;
@end
