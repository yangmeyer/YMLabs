
//  Created by Yang Meyer on 23.06.12.
//  Copyright (c) 2012 Yang Meyer. Some rights reserved.

#import "YMViewController.h"

@implementation YMViewController

@synthesize tableView;

- (void) viewDidLoad {
	[super viewDidLoad];
	UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 88)];
	header.backgroundColor = [UIColor redColor];
	self.tableView.tableHeaderView = header;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UITableView data source / delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [NSString stringWithFormat:@"Section %d", section];
}

- (UITableViewCell*) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = [tv dequeueReusableCellWithIdentifier:@"DefaultCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
	}
	cell.textLabel.text = [NSString stringWithFormat:@"Cell %d.%d", indexPath.section, indexPath.row];
	return cell;
}

- (void) tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat y = [self tableView:tv yOriginOfCellAtIndexPath:indexPath];
	CGRect frame = CGRectMake(0, y, 70, tv.rowHeight);
	
	UIView* debug = [[UIView alloc] initWithFrame:frame];
	debug.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.4];
	[self.view addSubview:debug];
}

#pragma mark - The gist of it

- (CGFloat) tableView:(UITableView*)tv yOriginOfCellAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat cumulativeY = tv.tableHeaderView.frame.size.height;
	for (NSInteger i = 0; i <= indexPath.section; i++) {
		cumulativeY += tv.sectionHeaderHeight;
		cumulativeY += tv.rowHeight * (i == indexPath.section
									   ? indexPath.row
									   : [self tableView:tv numberOfRowsInSection:i]);
	}
	return cumulativeY - tv.contentOffset.y;
}

@end
