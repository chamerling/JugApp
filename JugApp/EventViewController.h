//
//  EventViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventViewController : UIViewController<UIWebViewDelegate> {
    Event *event;
    UIImageView *image;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UIWebView *webView;
}
@property (nonatomic, retain) Event *event;

- (void)showEvent:(Event *)event;

@end
