// 
//  Canvas.m
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "Canvas.h"


@implementation Canvas 

@dynamic shapes;
@dynamic transform;

+ (Canvas *)initWithTranform:(Transform *)transform inContext:(NSManagedObjectContext *)context {

	Canvas *canvas = [NSEntityDescription insertNewObjectForEntityForName:@"Canvas" inManagedObjectContext:context];
	canvas.transform = transform;
	return canvas;
}

@end
