//
//  ICEaseSelectOneTVD.h
//  ICEase
//
//  Created by Matthew Casey on 03/04/2012.
//  Copyright (c) 2012 iOSConsultancy.co.uk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define ICEaseSelectOneTVDReusableCellIdentifier @"CellIdentifier"
typedef enum ICEaseSelectOneDisplayMode {
    ICEaseSelectOneDisplayOnePerRow = 0,
    ICEaseSelectOneDisplayOnePerSection
} ICEaseSelectOneDisplayMode;
@interface ICEaseSelectOneTVD : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, strong) NSDictionary *customObjectUIMappings;
@property (nonatomic, strong) UITableViewCell *templateCell;
@property (nonatomic) ICEaseSelectOneDisplayMode displayMode;
@property (nonatomic) float gapBetweenSections;

-(id)initWithChoices:(NSArray *)choices;
@end
