//
//  MemberViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 25/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//
// TODO : should be removed...

#import <UIKit/UIKit.h>
#import "Member.h"

@interface MemberViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
    IBOutlet UITableView *_tableView;
	IBOutlet UINavigationBar *_navBar;
    Member *member;
}
@property (nonatomic, retain) Member *member;

//- (IBAction)back:(id)sender;

-(void)sendEmail;
-(void)confirmEmail;
-(void)openWebPage;

@end

