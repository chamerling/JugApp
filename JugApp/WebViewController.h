//
//  WebViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 03/08/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate> {
    UIWebView	*webView;
    NSString    *url;
    UIActivityIndicatorView	*spinner;
}

@property (nonatomic, retain) NSString *url;
@end
