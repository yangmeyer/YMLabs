
//  Created by Yang Meyer on 21.06.12.
//  Copyright (c) 2012 Yang Meyer. All rights reserved.

#import "YMKeyValueCodingTests.h"
#import "YMSampleObject.h"

@implementation YMKeyValueCodingTests

- (void) setUp {
	[super setUp];
	
}

- (void) tearDown {
	
	[super tearDown];
}

- (void) testValueForKey {
	YMSampleObject* sample = [[YMSampleObject alloc] initWithIdentifier:@"123"];
	STAssertEquals([sample valueForKey:@"identifier"], @"123",
				   @"Incorrect identifier when accessed by KVC");
}

- (void) testNumbers {
	NSNumber* number0 = [NSNumber numberWithInt:100];
	NSNumber* number1 = [NSNumber numberWithInt:200];
	NSNumber* number2 = [NSNumber numberWithInt:250];
	NSArray* array = [NSArray arrayWithObjects:number0, number1, number2, nil];
	int actual = [[array valueForKeyPath:@"@sum.intValue"] intValue];
	STAssertEqualsWithAccuracy(actual, 100+200+250, 0.01,
							   @"Incorrect KVC @sum: %d", actual);
}

- (void) testAggregatingArrayOfCustomObjects {
	YMSampleObject* sample0 = [[YMSampleObject alloc] initWithIdentifier:@"100"];
	YMSampleObject* sample1 = [[YMSampleObject alloc] initWithIdentifier:@"200"];
	YMSampleObject* sample2 = [[YMSampleObject alloc] initWithIdentifier:@"250"];
	
	NSArray* array = [NSArray arrayWithObjects:sample0, sample1, sample2, nil];
	STAssertEquals([array valueForKeyPath:@"@count"], [NSNumber numberWithInt:3],
				   @"Incorrect KVC @count");
	
	int sum = [[array valueForKeyPath:@"@sum.identifier.intValue"] intValue];
	STAssertEqualsWithAccuracy(sum, 100+200+250, 0.01,
				   @"Incorrect KVC @sum: %d", sum);
	
	int max = [[array valueForKeyPath:@"@max.identifier.intValue"] intValue];
	STAssertEqualsWithAccuracy(max, 250, 0.01,
							   @"Incorrect KVC @max: %d", max);
	
	YMSampleObject* legacyObject0 = [[YMSampleObject alloc] initWithIdentifier:@"2012-06-04_16:29:47_+0000"];
	YMSampleObject* legacyObject1 = [[YMSampleObject alloc] initWithIdentifier:@"2012-06-07_15:00:47_+0000"];
	NSArray* legacyArray = [NSArray arrayWithObjects:legacyObject0, legacyObject1, nil];
	NSArray* mixedArray = [array arrayByAddingObjectsFromArray:legacyArray];
	int maxWithLegacyObjectPresent = [[mixedArray valueForKeyPath:@"@max.identifier.intValue"] intValue];
	STAssertEqualsWithAccuracy(maxWithLegacyObjectPresent, 2012, 0.01,
							   @"Incorrect KVC @max: %d in the presence of legacy objects", max);
	
	YMSampleObject* largerNewSchemeObject = [[YMSampleObject alloc] initWithIdentifier:@"2400"];
	NSArray* mixedArrayWithLargerNewScheme = [mixedArray arrayByAddingObject:largerNewSchemeObject];
	int maxWithLargerNewSchemeObject = [[mixedArrayWithLargerNewScheme valueForKeyPath:@"@max.identifier.intValue"] intValue];
	STAssertEqualsWithAccuracy(maxWithLargerNewSchemeObject, 2400, 0.01,
							   @"Incorrect KVC @max: %d in the presence of legacy objects AND an even larger new-scheme object", max);
}

- (void) testAggregatingDictionaryOfCustomObjects {
	NSDictionary* dict = @{ @"100" : @"Hello World",
							@"200" : @"How are you?",
							@"250" : @"You look nice tonight",
							@"2012-06-04_16:29:47_+0000" : @"Let's see how KVC copes with legacy objects" };
	
	STAssertEquals([dict valueForKeyPath:@"@count"], [NSNumber numberWithInt:4],
				   @"Incorrect KVC @count");
	
	int max = [[[dict allKeys] valueForKeyPath:@"@max.intValue"] intValue];
	STAssertEqualsWithAccuracy(max, 2012, 0.01,
							   @"Incorrect KVC @max: %d", max);
	
}
@end
