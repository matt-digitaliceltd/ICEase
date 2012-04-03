//
//  NSObject+LoggingAdditions.m
//  ICEase
//
//  Created by Matthew Casey on 03/04/2012.
//  Copyright (c) 2012 iOSConsultancy.co.uk. All rights reserved.
//

#import "NSObject+LoggingAdditions.h"
#import "ICEaseLogCentre.h"
@implementation NSObject (LoggingAdditions)
-(void)logDebug {
    ICEaseDebugFormat(@"%@ - %@", NSStringFromClass([self class]),[self description]);
}
-(void)logError {
    ICEaseErrorFormat(@"%@ - %@", NSStringFromClass([self class]),[self description]);
}
-(void)logWarn {
    ICEaseWarnFormat(@"%@ - %@", NSStringFromClass([self class]),[self description]);
}
@end
