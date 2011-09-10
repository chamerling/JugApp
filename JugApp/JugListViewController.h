//
//  AccountsViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 26/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JugListViewController : UITableViewController {
    NSMutableArray *accounts;
    //UIActivityIndicatorView *activity;
    
    UIAlertView *progressAlert;
    
    UIBarButtonItem *refreshButton;
    UIBarButtonItem *activityButton;
    BOOL dataLoaded;
}
@property (nonatomic, retain) NSMutableArray *accounts;
//@property (nonatomic, retain) UIActivityIndicatorView *activity;

- (IBAction)refresh:(id)sender;
- (void)loadDataFromURL:(NSString*)url;

// spinner to show activity...
- (void)launchLoadData;
- (void)loadData;
- (void)initSpinner;
- (void)spinBegin;
- (void)spinEnd;
@end
