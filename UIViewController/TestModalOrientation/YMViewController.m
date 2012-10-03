//
//  YMViewController.m
//  TestModalOrientation
//
//  Created by YangMeyer on 03.10.12.
//  Copyright (c) 2012 Yang Meyer. All rights reserved.
//

#import "YMViewController.h"

@implementation YMViewController

- (IBAction)unwindPresentModal:(UIStoryboardSegue *)segue
{
	if (self.presentedViewController) {
		[self dismissViewControllerAnimated:YES completion:nil];
	} else {
		[self.navigationController popToViewController:self animated:YES];
	}
}

@end
