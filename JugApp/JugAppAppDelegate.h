//
//  JugAppAppDelegate.h
//  JugApp
//
//  Created by Christophe Hamerling on 20/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JugAppAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    IBOutlet UINavigationController *navController;
    
    BOOL isLoadingData;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

+ (JugAppAppDelegate*) sharedAppDelegate;

@property (nonatomic, assign) BOOL isLoadingData;

- (void)showNetworkActivity:(BOOL)active;


@end
