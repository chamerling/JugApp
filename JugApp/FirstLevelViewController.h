//
//  FirstLevelViewController.h
//  JugApp
//  
//  The first level view controller is in charge of handling all the controllers of the application
//
//  Created by Christophe Hamerling on 21/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstLevelViewController : UITableViewController {
    // All the controllers will be stored here
    NSArray *controllers;
}
@property (nonatomic, retain) NSArray *controllers;
- (IBAction)info:(id)sender;
@end
