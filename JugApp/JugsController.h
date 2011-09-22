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

#pragma mark - actions
- (void) settingsAction;
- (void) addAction;
- (void) editAction;

@end
