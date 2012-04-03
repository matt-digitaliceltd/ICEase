//
//  ICEaseLogCentre.m
//  ICEase
//
//  Created by Matthew Casey on 03/04/2012.
//  Copyright (c) 2012 iOSConsultancy.co.uk. All rights reserved.
//

#import "ICEaseLogCentre.h"
@interface ICEaseLogCentre()
-(void)setInternalLogLevel:(ICEaseLogLevel)level;

@property (nonatomic) ICEaseLogLevel logLevel;
@end
static ICEaseLogCentre *mainCentre = nil;
@implementation ICEaseLogCentre
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
+(ICEaseLogCentre *)logCentre {
    @synchronized(self) {
        if (!mainCentre) {
            mainCentre = [[ICEaseLogCentre alloc] init];
        }
    }
    return mainCentre;
}
+(void)setLogLevel:(ICEaseLogLevel)level {
    [[ICEaseLogCentre logCentre] setInternalLogLevel:level];
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@synthesize logLevel = _logLevel;
-(void)setInternalLogLevel:(ICEaseLogLevel)level {
    self.logLevel = level;    
}
-(void)logAtLevel:(ICEaseLogLevel)level string:(NSString *)string {
    if (self.logLevel >= level) {
        NSLog(@"%@", string);
    }
}
-(void)logAtLevel:(ICEaseLogLevel)level format:(NSString *)format, ... {
    va_list argumentList;
    if (format) {
        va_start(argumentList, format);
        [self logAtLevel:level string:[[NSString alloc] initWithFormat:format arguments:argumentList]];
        va_end(argumentList);
    }
}


void ICEaseSetLogLevel(ICEaseLogLevel level) {
    [ICEaseLogCentre setLogLevel:level];
}


void ICEaseLog(ICEaseLogLevel level, NSString *string) {
    [[ICEaseLogCentre logCentre] logAtLevel:level string:string];
}
void ICEaseLogFormat(ICEaseLogLevel level, NSString *format, ...) {
    va_list argumentList;
    if (format) {
        va_start(argumentList, format);
        [[ICEaseLogCentre logCentre] logAtLevel:level string:[[NSString alloc] initWithFormat:format arguments:argumentList]];
        va_end(argumentList);
    }
}

void ICEaseDebug(NSString *string) {
    ICEaseLog(ICEaseLogLevelDebug, string);
}
void ICEaseDebugFormat(NSString *format, ...) {
    va_list argumentList;
    if (format) {
        va_start(argumentList, format);
        [[ICEaseLogCentre logCentre] logAtLevel:ICEaseLogLevelDebug string:[[NSString alloc] initWithFormat:format arguments:argumentList]];
        va_end(argumentList);
    }
}

void ICEaseWarn(NSString *string) {
    ICEaseLog(ICEaseLogLevelWarning, string);
}
void ICEaseWarnFormat(NSString *format, ...) {
    va_list argumentList;
    if (format) {
        va_start(argumentList, format);
        [[ICEaseLogCentre logCentre] logAtLevel:ICEaseLogLevelWarning string:[[NSString alloc] initWithFormat:format arguments:argumentList]];
        va_end(argumentList);
    }
}

void ICEaseError(NSString *string) {
    ICEaseLog(ICEaseLogLevelError, string);
}
void ICEaseErrorFormat(NSString *format, ...) {
    va_list argumentList;
    if (format) {
        va_start(argumentList, format);
        [[ICEaseLogCentre logCentre] logAtLevel:ICEaseLogLevelError string:[[NSString alloc] initWithFormat:format arguments:argumentList]];
        va_end(argumentList);
    }
}
@end
