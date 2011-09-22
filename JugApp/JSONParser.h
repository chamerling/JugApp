//
//  JSONParser.h
//  JugApp
//
//  Created by Christophe Hamerling on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParser : NSObject

- (NSMutableArray*) getJugs:(NSString*) jsonString;
- (NSMutableArray*) getMembers:(NSString*) jsonString;
- (NSMutableArray*) getNews:(NSString*) jsonString;
- (NSMutableArray*) getEvents:(NSString*) jsonString;
- (NSMutableArray*) getNextEvent:(NSString*) jsonString;

@end
