//
//  BasicCanvasView.m
//  Shapez
//
//  Created by James Cryer on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "BasicCanvasView.h"
#import "Transform.h"
#import "Shape.h"
#import "Circle.h"
#import "Vertex.h"
#import "Polygon.h"

@implementation BasicCanvasView

@synthesize canvas;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (float)scale {
	return [canvas.transform.scale floatValue];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
	if (canvas == nil) {
		return;
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	float scale = [self scale];
	
	CGContextScaleCTM(context, scale, scale);
	
	NSSet* shapes = canvas.shapes;
	
	for (Shape *shape in shapes) {
		NSString *entityName = [[shape entity] name];
		
		NSString *colourCode = shape.colour;
		NSArray *colourCodes= [colourCode componentsSeparatedByString:@","];
		
		CGContextSetRGBFillColor(context, 
								 [[colourCodes objectAtIndex:0] floatValue], 
								 [[colourCodes objectAtIndex:1] floatValue], 
								 [[colourCodes objectAtIndex:2] floatValue], 1);
		
		if ([entityName compare:@"Circle"] == NSOrderedSame) {
			Circle *circle = (Circle *)shape;
			float x = [circle.x floatValue];
			float y = [circle.y floatValue];
			float radius = [circle.radius floatValue];
			
			CGContextFillEllipseInRect(context, CGRectMake(x, y, 2*radius, 2*radius));
		}
		else {
			Polygon *polygon = (Polygon *)shape;
			NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
			NSArray *sortDesc = [NSArray arrayWithObject:sort];
			NSArray *vertices = [[polygon.vertices allObjects] sortedArrayUsingDescriptors:sortDesc];
			
			CGContextBeginPath(context);
			
			Vertex *lastVertex = [vertices lastObject];
			
			CGContextMoveToPoint(context, [lastVertex.x floatValue], [lastVertex.y floatValue]);
			
			for (Vertex *vertex in vertices) {
				CGContextAddLineToPoint(context, [vertex.x floatValue], [vertex.y floatValue]);
			}
			CGContextFillPath(context);
			
			[sort release];	
		}

	}
}

- (void)dealloc {
	[canvas release];
    [super dealloc];
}


@end
