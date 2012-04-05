//
//  ICEaseLogCentre.h
//  ICEase
//
//  Created by Matthew Casey on 03/04/2012.
//  Copyright (c) 2012 iOSConsultancy.co.uk. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum ICEaseLogLevel {
    ICEaseLogLevelUndefined = 0,
    ICEaseLogLevelError,
    ICEaseLogLevelWarning,
    ICEaseLogLevelDebug
    
} ICEaseLogLevel;
@interface ICEaseLogCentre : NSObject
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
+(ICEaseLogCentre *)logCentre;
+(void)setLogLevel:(ICEaseLogLevel)level;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

-(void)logAtLevel:(ICEaseLogLevel)level string:(NSString *)string;
-(void)logAtLevel:(ICEaseLogLevel)level format:(NSString *)format, ... NS_FORMAT_FUNCTION(2,3);

+(void)debug:(NSString *)string;
+(void)debugFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(2,3);

+(void)warn:(NSString *)string;
+(void)warnFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(2, 3);

+(void)error:(NSString *)string;
+(void)errorFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(2, 3);

void ICEaseSetLogLevel(ICEaseLogLevel level);

void ICEaseLog(ICEaseLogLevel level, NSString *string);
void ICEaseLogFormat(ICEaseLogLevel level, NSString *format, ...) NS_FORMAT_FUNCTION(2,3);

void ICEaseDebug(NSString *string);
void ICEaseDebugFormat(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

void ICEaseWarn(NSString *string);
void ICEaseWarnFormat(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

void ICEaseError(NSString *string);
void ICEaseErrorFormat(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

@end
