//
//  JUGAddViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

@interface JUGAddViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource> {
}

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSArray *jugs;

#pragma mark - actions
-(void) map:(id)sender;

@end
