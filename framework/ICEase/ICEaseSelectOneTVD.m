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

@property (nonatomic, strong) id chosenObject;
@property (nonatomic, strong) NSNumber *internalGap;
@end

@implementation ICEaseSelectOneTVD
@synthesize choices = _choices;
@synthesize customObjectUIMappings = _customObjectUIMappings;
@synthesize templateCell = _templateCell;
@synthesize displayMode = _displayMode;
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
}/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.displayMode == ICEaseSelectOneDisplayOnePerSection) {
        ICEaseDebugFormat(@"Header view being shown with gap of - %2.0f", self.gapBetweenSections); 
        UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];        
        return blankView;
    } else {
        ICEaseDebug(@"No header view being shown");
        return nil;
    }
}*//*
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ICEaseDebug(NSStringFromSelector(_cmd));
    return @"Test";
}*/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ICEaseSelectOneTVDReusableCellIdentifier];
    if (!cell) {
        if (self.templateCell) {
            ICEaseDebug(@"Using templateCell to instantiate new UITableViewCell");
            cell = self.templateCell;
        } else {
            ICEaseDebug(@"Instantiating a new cell from factory UITableViewCell");
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ICEaseSelectOneTVDReusableCellIdentifier];
        }
    }
    id object = [self.choices objectAtIndex:(self.displayMode == ICEaseSelectOneDisplayOnePerRow)?indexPath.row:indexPath.section];
    if (self.customObjectUIMappings) {
        ICEaseDebug(@"ICEaseSelectOneTVD operating in Custom Object Mode");
        for (NSString *key in self.customObjectUIMappings) {
            UIView *propertyView = [cell valueForKey:key];
            NSString *objectPropKey = [self.customObjectUIMappings objectForKey:key];
            
            if ([propertyView isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)propertyView;
                label.text = [object valueForKey:objectPropKey];
            } else if ([propertyView isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)propertyView;
                imageView.image = [object valueForKey:objectPropKey];
            } else {
                ICEaseWarnFormat(@"Unsupported UIView Subclass for key %@ on table view cell", key);
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
    self.chosenObject = object;
    if (self.chosenObject) {
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:existing, new, nil] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        ICEaseDebugFormat(@"Selecting first object of lifecycle, no previous chosenObject set");
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:new] withRowAnimation:UITableViewRowAnimationFade];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
