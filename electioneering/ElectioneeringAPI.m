//
//  ElectioneeringAPI.m
//  electioneering
//
//  Created by Jeff Grimes on 9/14/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import "ElectioneeringAPI.h"

static ElectioneeringAPI *sharedInstance = nil;

@implementation ElectioneeringAPI

+ (id)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[ElectioneeringAPI alloc] init];
    }
    return sharedInstance;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"connection error");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *error = nil;
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        [self performSelector:self.failureSelector];
        return;
    }
    
    if ([jsonObjects isKindOfClass:[NSArray class]]) {
        self.responseArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [jsonObjects count]; i++) {
            [self.responseArray addObject:[jsonObjects objectAtIndex:i]];
        }
    } else {
        NSArray *keys = [jsonObjects allKeys];
        NSMutableArray *values = [[NSMutableArray alloc] init];
        for (NSString *key in keys) {
            [values addObject:[jsonObjects objectForKey:key]];
        }
        self.responseDict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    }
    
    [self performSelector:self.successSelector];
}

- (void)getDataForActorOne:(NSString *)actorOne actorTwo:(NSString *)actorTwo {
    self.successSelector = @selector(callGotData);
    self.failureSelector = @selector(callGotDataError);
    
    self.responseData = [[NSMutableData data] retain];
    NSString *urlString = [NSString stringWithFormat:@"http://electioneering.us/api/v1/politicians/?names[white]=%@&names[black]=%@&names[auth]=lZvqvJZgXVsYVB43siOl0jsAYNhJXR3Qhnyh4tQlEgSxRi1qxuG7qtXDqjOTk4KN", [actorOne stringByReplacingOccurrencesOfString:@" " withString:@"%20"] , [actorTwo stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    NSLog(@"%@", urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)getAllActors {
    self.successSelector = @selector(callGotAllActors);
    self.failureSelector = @selector(callGotAllActorsError);
    
    self.responseData = [[NSMutableData data] retain];
    NSString *urlString = @"http://electioneering.us/api/v1/politicians/?names[auth]=lZvqvJZgXVsYVB43siOl0jsAYNhJXR3Qhnyh4tQlEgSxRi1qxuG7qtXDqjOTk4KN";
    NSLog(@"%@", urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)callGotAllActors {
    [self.actorDelegate gotAllActors];
}

- (void)callGotAllActorsError {
    [self.actorDelegate gotAllActorsError];
}

- (void)callGotData {
    [self.dataDelegate gotData];
}

- (void)callGotDataError {
    [self.dataDelegate gotDataError];
}

@end