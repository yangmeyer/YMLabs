//
//  YMViewController.m
//  LocalNotifications
//
//  Created by YangMeyer on 18.08.12.
//  Copyright (c) 2012 Yang Meyer. All rights reserved.
//

#import "YMViewController.h"

@interface YMViewController ()

@end

@implementation YMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fireDelayedLocalNotification:(id)sender {
	UILocalNotification* localNotif = [[UILocalNotification alloc] init];
	localNotif.alertBody = @"This is a local notification";
	localNotif.alertAction = @"Show app";
	localNotif.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0]; // seconds
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

@end
