//
//  MembersViewController.h
//  JugApp
//
//  Created by Christophe Hamerling on 25/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MembersViewController : UITableViewController {
    NSMutableArray *members;
}
@property (nonatomic, retain) NSMutableArray *members;
@end
