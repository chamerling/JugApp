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

- (void)loadDataFromURL:(NSString*)url;
- (void)launchLoadData;
- (void)loadData;

- (IBAction)info:(id)sender;

@end
