//
//  UIColorTransformer.m
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "UIColourTransformer.h"


@implementation UIColourTransformer

+ (BOOL)allowsReverseTransformation {
	return YES;
}

+ (Class)transformedValueClass {
	return [NSData class];
}

- (id)transformedValue:(id)value {
	
	UIColor *colour = (UIColor *)value;
	const CGFloat *components = CGColorGetComponents(colour.CGColor);
	
	NSString *result = [NSString stringWithFormat:@"%f,%f,%f", components[0], components[1], components[2]];
	
	return [result dataUsingEncoding:[NSString defaultCStringEncoding]];
}

- (id)reverseTransformedValue:(id)value {

	NSString *colourString = [[NSString alloc] initWithData:value encoding:[NSString defaultCStringEncoding]];
	
	NSArray *components = [colourString componentsSeparatedByString:@","];
	CGFloat red = [[components objectAtIndex:0] floatValue];
	CGFloat green = [[components objectAtIndex:1] floatValue];
	CGFloat blue = [[components objectAtIndex:2] floatValue];
	[colourString release];
	
	return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

@end
