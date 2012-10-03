//
//  YMAppDelegate.m
//  LocalNotifications
//
//  Created by YangMeyer on 18.08.12.
//  Copyright (c) 2012 Yang Meyer. All rights reserved.
//

#import "YMAppDelegate.h"
#import "YMViewController.h"
#import "UIAlertView+MKBlockAdditions.h"

@implementation YMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	self.viewController = [[YMViewController alloc] initWithNibName:@"YMViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
	NSLog(@"didFinishLaunchingWithOptions:");
	UILocalNotification* localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
	if (localNotif) {
		NSLog(@"localNotif key was set");
		[self userDidActOnLocalNotification:localNotif];
	}
	
    return YES;
}


- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)localNotif
{
	NSLog(@"didReceiveLocalNotification:");
	NSLog(@"[UIApplication sharedApplication].applicationState: %d", [UIApplication sharedApplication].applicationState);

	
	if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
	{
	// If the app is active, iOS does not show a notification (and no sound is played etc).
	// Instead, we show an alert view notifying the user about the venue's offers
	[UIAlertView alertViewWithTitle:@"Notification received"
							message:@"Got a notification! Do something?"
				  cancelButtonTitle:@"Not Now"
				  otherButtonTitles:[NSArray arrayWithObject:@"Do It!"]
						  onDismiss:^(int buttonIndex) {
							  [self userDidActOnLocalNotification:localNotif];
						  } onCancel:nil];
	}
	else {
		[self userDidActOnLocalNotification:localNotif];
	}
}

- (void) userDidActOnLocalNotification:(UILocalNotification*)localNotif
{
	[[[UIAlertView alloc] initWithTitle:@"User acted"
							   message:@"User did act on notification"
							   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
