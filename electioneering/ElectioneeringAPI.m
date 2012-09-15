//
//  ElectioneeringAPI.m
//  electioneering
//
//  Created by Jeff Grimes on 9/14/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import "ElectioneeringAPI.h"

@implementation ElectioneeringAPI

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Show error
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

- (void)getDataForActorOne:(NSString *)actorOneId actorTwo:(NSString *)actorTwoId {
    self.successSelector = @selector(callGotData);
    self.failureSelector = @selector(callGotDataError);
    
    self.responseData = [[NSMutableData data] retain];
    NSString *urlString = [NSString stringWithFormat:@"endpoint here %@ %@", @"actorOne", @"actorTwo"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)callGotData {
    [self.actorDelegate gotData];
}

- (void)callGotUserError {
    [self.actorDelegate gotDataError];
}

@end