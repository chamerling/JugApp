//
//  NewsDetaiksViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 19/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsDetaiksViewController : UIViewController {
    UILabel *newTitle;
    IBOutlet UILabel *newsDate;
    IBOutlet UILabel *newsTags;
    IBOutlet UITextView *newsDetails;
    
    News *news;
}

@property (nonatomic, retain) IBOutlet UILabel *newTitle;
@property (nonatomic, retain) News *news;

- (void)showNews:(News *)news;


@end
