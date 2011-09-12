//
//  NewViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 05/09/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewViewController : UIViewController<UIWebViewDelegate>
{
    //News *news;
    IBOutlet UIWebView *newsBody;
    IBOutlet UIToolbar *actionButton;
    IBOutlet UILabel *publishedLabel;
    IBOutlet UIView *contentView;
    IBOutlet UIImageView *imageNews;
}

@property (nonatomic, retain) News *news;

- (void)showNews:(News *)news;

@end
