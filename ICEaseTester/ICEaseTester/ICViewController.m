//
//  ICViewController.m
//  ICEaseTester
//
//  Created by Matthew Casey on 03/04/2012.
//  Copyright (c) 2012 iOSConsultancy.co.uk. All rights reserved.
//

#import "ICViewController.h"

#import <ICEase/ICEase.h>
@interface ICViewController ()

@end

@implementation ICViewController

- (void)viewDidLoad
{
    ICEaseSetLogLevel(ICEaseLogLevelDebug);
    ICEaseDebug(@"Debug Output");
    ICEaseWarn(@"Warn Output");
    ICEaseError(@"Error Output");
    [self logDebug];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
