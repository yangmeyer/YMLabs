//
//  YMFrameDisplayViewController.m
//  TestModalOrientation
//
//  Created by YangMeyer on 03.10.12.
//  Copyright (c) 2012 Yang Meyer. All rights reserved.
//

#import "YMFrameDisplayViewController.h"

@implementation YMFrameDisplayViewController

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self printFrame];
}

- (void)printFrame
{
	self.frameLabel.text = NSStringFromCGRect(self.view.frame);
}

@end
