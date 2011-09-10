//
//  ProgressView.h
//  JugApp
//
//  Created by Christophe Hamerling on 05/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WordPressAppDelegate.h"

@interface ProgressView : UIAlertView {
    UIActivityIndicatorView *activityIndicator;
    UILabel *progressMessage;
	UIImageView *backgroundImageView;
    
//    WordPressAppDelegate *appDelegate;
}

@property (nonatomic, assign) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UILabel *progressMessage;
@property (nonatomic, assign) UIImageView *backgroundImageView;
//@property (nonatomic, assign) WordPressAppDelegate *appDelegate;

- (id)initWithLabel:(NSString *)text;
- (void)dismiss;

@end
