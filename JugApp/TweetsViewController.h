//
//  TweetsViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface TweetsViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource> {
    NSString *tag;
}

@property (nonatomic, retain) IBOutlet UITableView* table;
@property (nonatomic, retain) NSArray* results;

@property (nonatomic, retain) NSString *tag;

- (IBAction)openInBrowser:(id)sender;

@end
