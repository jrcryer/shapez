//
//  BasicCanvasView.m
//  Shapez
//
//  Created by James Cryer on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "BasicCanvasView.h"


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
	NSManagedObject *transform = [canvas valueForKey:@"transform"];
	return [[transform valueForKey:@"scale"] floatValue];
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
	
	NSSet* shapes = [canvas valueForKey:@"shapes"];
	
	for (NSManagedObject *shape in shapes) {
		NSString *entityName = [[shape entity] name];
		
		NSString *colourCode = [shape valueForKey:@"colour"];
		NSArray *colourCodes= [colourCode componentsSeparatedByString:@","];
		
		CGContextSetRGBFillColor(context, 
								 [[colourCodes objectAtIndex:0] floatValue], 
								 [[colourCodes objectAtIndex:1] floatValue], 
								 [[colourCodes objectAtIndex:2] floatValue], 1);
		
		if ([entityName compare:@"Circle"] == NSOrderedSame) {
			float x = [[shape valueForKey:@"x"] floatValue];
			float y = [[shape valueForKey:@"y"] floatValue];
			float radius = [[shape valueForKey:@"radius"] floatValue];
			
			CGContextFillEllipseInRect(context, CGRectMake(x, y, 2*radius, 2*radius));
		}
		else {
			NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
			NSArray *sortDesc = [NSArray arrayWithObject:sort];
			NSArray *vertices = [[[shape mutableSetValueForKey:@"vertices"] allObjects] sortedArrayUsingDescriptors:sortDesc];
			
			CGContextBeginPath(context);
			
			NSManagedObject *lastVertex = [vertices lastObject];
			
			CGContextMoveToPoint(context, [[lastVertex valueForKey:@"x"] floatValue], [[lastVertex valueForKey:@"y"] floatValue]);
			
			for (NSManagedObject *vertex in vertices) {
				CGContextAddLineToPoint(context, [[vertex valueForKey:@"x"] floatValue], [[vertex valueForKey:@"y"] floatValue]);
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
