//
//  JugsController.h
//  JugApp
//
//  Created by Christophe Hamerling on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JugsController : UITableViewController {
    NSMutableArray *jugs;
}
@property (nonatomic, retain) NSMutableArray *jugs;

#pragma mark - loading data
- (void)loadDataFromURL:(NSString*)url;
- (void)launchLoadData;
- (void)loadData;

#pragma mark - actions
- (void) settingsAction;
- (void) addAction;
- (void) editAction;

@end
