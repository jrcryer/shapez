// 
//  Transform.m
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "Transform.h"

#import "Canvas.h"

@implementation Transform 

@dynamic scale;
@dynamic canvas;

+ (Transform *)initWithScale:(float)scale inContext:(NSManagedObjectContext *)context {

	Transform *transform = [NSEntityDescription insertNewObjectForEntityForName:@"Transform" inManagedObjectContext:context];
	transform.scale = [NSNumber numberWithFloat:scale];
	return transform;
}

@end
