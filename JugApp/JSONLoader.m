//
//  JSONLoader.m
//  JugApp
//
//  Created by Christophe Hamerling on 26/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSONLoader.h"
#import "SBJson.h"
#import "JugInformation.h"
#import "Member.h"
#import "Event.h"
#import "News.h"

@implementation JSONLoader


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

/* TODO : Add listener from parsing problems */
- (NSMutableArray *)getJugsFromURL:(NSString*)url {
    NSLog(@"Getting JUG informtation from '%@'", url);
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    // parse the JSON response into an object
    // Here we're using NSArray since we're parsing an array of JSON status objects
    NSArray *jugs = [parser objectWithString:json_string error:nil];
    
    // Each element in jugs is a single jug
    // represented as a NSDictionary
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
        [result addObject:info];
    }

    return result;
}

- (NSMutableArray*) getMembersFromURL:(NSString*) url {
    NSLog(@"Getting Members information from '%@'", url);
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    // parse the JSON response into an object
    // Here we're using NSArray since we're parsing an array of JSON status objects
    NSArray *members = [parser objectWithString:json_string error:nil];
    
    // Each element in jugs is a single jug
    // represented as a NSDictionary
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

- (NSMutableArray*) getNewsFromURL:(NSString*) url {
    NSLog(@"Getting News information from '%@'", url);
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    // parse the JSON response into an object
    // Here we're using NSArray since we're parsing an array of JSON status objects
    NSArray *news = [parser objectWithString:json_string error:nil];
    
    // Each element in jugs is a single jug
    // represented as a NSDictionary
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

- (NSMutableArray*) getEventsFromURL:(NSString*) url {
    NSLog(@"Getting Events information from '%@'", url);
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    // parse the JSON response into an object
    // Here we're using NSArray since we're parsing an array of JSON status objects
    NSArray *events = [parser objectWithString:json_string error:nil];
    
    // Each element in jugs is a single jug
    // represented as a NSDictionary
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

- (NSMutableArray*) getNextEventFromURL:(NSString*) url {
    return nil;
}



@end
