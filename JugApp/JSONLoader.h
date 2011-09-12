//
//  JSONLoader.h
//  JugApp
//
//  Created by Christophe Hamerling on 26/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONLoader : NSObject {
    
}
- (NSMutableArray*) getJugsFromURL:(NSString*) url;
- (NSMutableArray*) getMembersFromURL:(NSString*) url;
- (NSMutableArray*) getNewsFromURL:(NSString*) url;
- (NSMutableArray*) getEventsFromURL:(NSString*) url;
- (NSMutableArray*) getNextEventFromURL:(NSString*) url;

@end
