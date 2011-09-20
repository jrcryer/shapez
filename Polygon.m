// 
//  Polygon.m
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "Polygon.h"
#import "Vertex.h"


@implementation Polygon 

@dynamic vertices;

+ (Polygon *)polygonAtPoint:(CGPoint)origin inContext:(NSManagedObjectContext *)context {
	
	Polygon *polygon = [NSEntityDescription insertNewObjectForEntityForName:@"Polygon" inManagedObjectContext:context];

	int nVertices = 3 + (arc4random() % 20);
	float angleIncrement = (2 * M_PI) / nVertices;
	int index = 0;
	
	for (float i = 0 ; i < nVertices; i++) {
		float a = i * angleIncrement;
		float radius = 10 + (arc4random() % 90);
		float x = origin.x + (radius * cos(a));
		float y = origin.y + (radius * sin(a));
		
		Vertex *vertex = [NSEntityDescription insertNewObjectForEntityForName:@"Vertex" inManagedObjectContext:context];
		
		vertex.x = [NSNumber numberWithFloat:x];
		vertex.y = [NSNumber numberWithFloat:y];
		vertex.index = [NSNumber numberWithFloat:index++];
		
		[polygon addVerticesObject:vertex];
	}
	return polygon;
}

@end
