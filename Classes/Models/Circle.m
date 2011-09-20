// 
//  Circle.m
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "Circle.h"


@implementation Circle 

@dynamic x;
@dynamic y;
@dynamic radius;

+ (Circle *)circleAtPoint:(CGPoint)origin inContext:(NSManagedObjectContext *)context {
	
	Circle *circle = [NSEntityDescription insertNewObjectForEntityForName:@"Circle" inManagedObjectContext:context];
	
	float radius = 10 + (arc4random() % 90);
	circle.x = [NSNumber numberWithFloat:origin.x];
	circle.y = [NSNumber numberWithFloat:origin.y];
	circle.radius = [NSNumber numberWithFloat:radius];
	return circle;
}

@end
