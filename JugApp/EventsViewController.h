//
//  EventsViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 25/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventsViewController : UITableViewController {
    // all events
    NSMutableArray *events;
    // upcoming event
    Event *upcoming;
}
@property (nonatomic, retain) Event *upcoming;
@property (nonatomic, retain) NSMutableArray *events;
@end
