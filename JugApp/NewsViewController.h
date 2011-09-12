//
//  NewsViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 02/08/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UITableViewController {
    NSMutableArray *news;
}
@property (nonatomic, retain) NSMutableArray *news;

@end
