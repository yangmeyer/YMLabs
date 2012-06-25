
//  Created by Yang Meyer on 21.06.12.
//  Copyright (c) 2012 Yang Meyer. Some rights reserved.

#import "YMSampleObject.h"

@implementation YMSampleObject

@synthesize identifier;

- (id) initWithIdentifier:(NSString*)theIdentifier {
	self = [super init];
	if (self) {
		self.identifier = theIdentifier;
	}
	return self;
}

@end
