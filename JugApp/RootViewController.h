//
//  RootViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
    UITableView *tableView;
    IBOutlet UIActivityIndicatorView *spinner;
}
- (IBAction)refresh:(id)sender;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
