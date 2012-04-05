//
//  ICEaseSelectOneTVD.m
//  ICEase
//
//  Created by Matthew Casey on 03/04/2012.
//  Copyright (c) 2012 iOSConsultancy.co.uk. All rights reserved.
//

#import "ICEaseSelectOneTVD.h"
#import "Logging.h"

@interface ICEaseSelectOneTVD()

@property (nonatomic, strong) NSNumber *internalGap;
@end

@implementation ICEaseSelectOneTVD
@synthesize choices = _choices;
@synthesize customObjectUIMappings = _customObjectUIMappings;
@synthesize displayMode = _displayMode;
@synthesize delegate = _delegate;
-(float)gapBetweenSections {
    return [self.internalGap floatValue];
}
-(void)setGapBetweenSections:(CGFloat)gapBetweenSections {
    self.internalGap = [NSNumber numberWithFloat:gapBetweenSections];
}
@synthesize internalGap = _internalGap;
@synthesize chosenObject = _chosenObject;
-(id)initWithChoices:(NSArray *)choices {
    self = [super init];
    if (self) {
        self.choices = choices;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.displayMode == ICEaseSelectOneDisplayOnePerSection) {
        return self.choices.count;
    } else {
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.displayMode == ICEaseSelectOneDisplayOnePerRow) {
        return self.choices.count;
    } else {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    } else {
        return self.gapBetweenSections;        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.choices objectAtIndex:(self.displayMode == ICEaseSelectOneDisplayOnePerRow)?indexPath.row:indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ICEaseSelectOneTVDReusableCellIdentifier];
    if (!cell) {
        if ([self.delegate respondsToSelector:@selector(createNewCellforTableViewDataSource)]) {
            ICEaseDebug(@"Using delegate to instantiate new UITableViewCell");
            cell = [self.delegate createNewCellforTableViewDataSource:self];
        } else {
            ICEaseDebug(@"Instantiating a new cell from factory UITableViewCell");
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ICEaseSelectOneTVDReusableCellIdentifier];
        }
    }
    
    if (self.customObjectUIMappings) {
        ICEaseDebug(@"ICEaseSelectOneTVD operating in Custom Object Mode");
        for (NSString *key in self.customObjectUIMappings) {
            @try {
                NSString *objectPropKey = [self.customObjectUIMappings objectForKey:key];
                [cell setValue:[object valueForKey:objectPropKey] forKeyPath:key];
            }
            @catch (NSException *exception) {
                ICEaseErrorFormat(@"Could not set UI element at keyPath %@", key);
            }
            
        }
    } else {
        ICEaseDebug(@"ICEaseSelectOneTVD operating in String Only Mode");
        cell.textLabel.text = object;
    }
    cell.accessoryType = [object isEqual:self.chosenObject]?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.choices objectAtIndex:(self.displayMode == ICEaseSelectOneDisplayOnePerRow)?indexPath.row:indexPath.section];
    
    NSIndexPath *existing = nil;
    NSIndexPath *new = nil;
    if (self.displayMode == ICEaseSelectOneDisplayOnePerRow) {
        existing = [NSIndexPath indexPathForRow:[self.choices indexOfObject:self.chosenObject] inSection:0];
        new = [NSIndexPath indexPathForRow:[self.choices indexOfObject:object] inSection:0];
    } else {
        existing = [NSIndexPath indexPathForRow:0 inSection:[self.choices indexOfObject:self.chosenObject]];
        new = [NSIndexPath indexPathForRow:0 inSection:[self.choices indexOfObject:object]];
    }
    
    if (self.chosenObject) {
        self.chosenObject = object;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:existing, new, nil] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        self.chosenObject = object;
        ICEaseDebugFormat(@"Selecting first object of lifecycle, no previous chosenObject set");
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:new] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(tableViewDataSource:selectedObject:)]) {
            [self.delegate tableViewDataSource:self selectedObject:self.chosenObject];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
