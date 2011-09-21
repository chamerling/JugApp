//
//  EventDetailsViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailsViewController : UIViewController<UIActionSheetDelegate> {
    IBOutlet UIView *mainView;
    UILabel *eventTitleLabel;
    IBOutlet UILabel *eventDateLabel;
    IBOutlet UILabel *tagsLbel;
    IBOutlet UITextView *eventDescriptionTextView;    
    Event *event;
}

@property (nonatomic, retain) IBOutlet UILabel *eventTitleLabel;
@property (nonatomic, retain) Event *event;

- (void)showEvent:(Event *)event;
- (void)addToCalendar;
- (void)tweet;

- (void)toolbarAction;

@end
