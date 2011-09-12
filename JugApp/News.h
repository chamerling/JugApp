//
//  News.h
//  JugApp
//
//  Created by Christophe Hamerling on 02/08/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject {
    NSString *title;
    NSString *date;
    NSString *content;
}
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *date;
@property (nonatomic,retain) NSString *content;

@end
