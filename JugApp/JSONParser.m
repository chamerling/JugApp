//
//  JSONParser.m
//  JugApp
//
//  Created by Christophe Hamerling on 22/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSONParser.h"
#import "JugInformation.h"
#import "Member.h"
#import "News.h"
#import "Event.h"

#import "SBJsonParser.h"

@implementation JSONParser

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSMutableArray *)getJugs:(NSString*)jsonString {
    NSLog(@"Getting JUG informtation from '%@'", jsonString);
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *jugs = [parser objectWithString:jsonString error:nil];
    
    for (NSDictionary *jug in jugs)
    {
        NSLog(@"Loading a JUG...");
        JugInformation *info = [[JugInformation alloc] init];
        info.name = [NSString stringWithFormat:@"%@", [jug objectForKey:@"name"]];
        info.description = [NSString stringWithFormat:@"%@", [jug objectForKey:@"description"]];
        info.city = [NSString stringWithFormat:@"%@", [jug objectForKey:@"city"]];
        info.country = [NSString stringWithFormat:@"%@", [jug objectForKey:@"country"]];
        info.website = [NSString stringWithFormat:@"%@", [jug objectForKey:@"website"]];
        info.email = [NSString stringWithFormat:@"%@", [jug objectForKey:@"email"]];
        info.twitter = [NSString stringWithFormat:@"%@", [jug objectForKey:@"twitter"]];
        info.apiURL = [NSString stringWithFormat:@"%@", [jug objectForKey:@"api"]];
        info.apiVersion = [NSString stringWithFormat:@"%@", [jug objectForKey:@"apiVersion"]];
        info.longitude = [NSString stringWithFormat:@"%@", [jug objectForKey:@"long"]];
        info.latitude = [NSString stringWithFormat:@"%@", [jug objectForKey:@"lat"]];
        [result addObject:info];
    }
    
    return result;
}

- (NSMutableArray*) getMembers:(NSString*) jsonString {
    NSLog(@"Getting Members information from '%@'", jsonString);
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *members = [parser objectWithString:jsonString error:nil];
    
    for (NSDictionary *member in members)
    {
        NSLog(@"Loading member...");
        Member *m = [[Member alloc] init];
        m.name = [NSString stringWithFormat:@"%@", [member objectForKey:@"fullName"]];
        m.company = [NSString stringWithFormat:@"%@", [member objectForKey:@"company"]];
        m.companyURL = [NSString stringWithFormat:@"%@", [member objectForKey:@"url"]];
        m.role = [NSString stringWithFormat:@"%@", [member objectForKey:@"activity"]];
        m.web = [NSString stringWithFormat:@"%@", [member objectForKey:@"personalUrl"]];
        m.email = [NSString stringWithFormat:@"%@", [member objectForKey:@"email"]];
        //m.twitter = 
        m.bio = [NSString stringWithFormat:@"%@", [member objectForKey:@"bio"]];
        [result addObject:m];
    }
    return result;
}

- (NSMutableArray*) getNews:(NSString*) jsonString {
    NSLog(@"Getting News information from '%@'", jsonString);
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *news = [parser objectWithString:jsonString error:nil];
    
    for (NSDictionary *new in news)
    {
        NSLog(@"Loading news...");
        News *n = [[News alloc] init];
        n.title = [NSString stringWithFormat:@"%@", [new objectForKey:@"title"]];
        n.date = [NSString stringWithFormat:@"%@", [new objectForKey:@"date"]];
        n.content = [NSString stringWithFormat:@"%@", [new objectForKey:@"content"]];
        [result addObject:n];
    }
    return result;
}

- (NSMutableArray*) getEvents:(NSString*) jsonString {
    NSLog(@"Getting Events information from '%@'", jsonString);
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *events = [parser objectWithString:jsonString error:nil];
    
    for (NSDictionary *event in events)
    {
        NSLog(@"Loading event...");
        Event *e = [[Event alloc] init];
        e.title = [NSString stringWithFormat:@"%@", [event objectForKey:@"title"]];
        e.date = [NSString stringWithFormat:@"%@", [event objectForKey:@"date"]];
        e.description = [NSString stringWithFormat:@"%@", [event objectForKey:@"description"]];
        [result addObject:e];
    }
    return result;
}

- (NSMutableArray*) getNextEvent:(NSString*) jsonString {
    return nil;
}

@end
