//
//  ShapezViewController.m
//  Shapez
//
//  Created by James Cryer on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <stdlib.h>
#import "ShapezViewController.h"

@interface ShapezViewController()
- (void)createShapeAt:(CGPoint) point;
- (void)updateAllShapes;
- (void)deleteAllShapes;
- (NSString *)makeRandomColor;
- (void)saveWithViewUpdate:(BOOL)updateView;
@end


@implementation ShapezViewController

@synthesize topView, bottomView, managedObjectContext;

- (void)createShapeAt:(CGPoint)point {

	NSManagedObject *shape = nil;
	
	int type = arc4random() % 2;
	
	if (type == 0) {
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"Circle" inManagedObjectContext:self.managedObjectContext];
		NSManagedObject *circle = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
		
		shape = circle;
		
		float radius = 10 + (arc4random() % 90);
		[circle setValue:[NSNumber numberWithFloat:point.x] forKey:@"x"];
		[circle setValue:[NSNumber numberWithFloat:point.y] forKey:@"y"];
		[circle setValue:[NSNumber numberWithFloat:radius] forKey:@"radius"];
	}
	else {
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"Polygon" inManagedObjectContext:self.managedObjectContext];
		NSManagedObject *polygon = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
		
		shape = polygon;
		
		NSMutableSet *vertices = [polygon mutableSetValueForKey:@"vertices"];
		
		int nVertices = 3 + (arc4random() % 20);
		float angleIncrement = (2 * M_PI) / nVertices;
		int index = 0;
		
		for (float i = 0 ; i < nVertices; i++) {
			float a = i * angleIncrement;
			float radius = 10 + (arc4random() % 90);
			float x = point.x + (radius * cos(a));
			float y = point.y + (radius * sin(a));
			
			NSEntityDescription *vertexEntity = [NSEntityDescription entityForName:@"Vertex" inManagedObjectContext:self.managedObjectContext];
			NSManagedObject *vertex = [NSEntityDescription insertNewObjectForEntityForName:[vertexEntity name] inManagedObjectContext:self.managedObjectContext];
			
			[vertex setValue:[NSNumber numberWithFloat:x] forKey:@"x"];
			[vertex setValue:[NSNumber numberWithFloat:y] forKey:@"y"];
			[vertex setValue:[NSNumber numberWithFloat:index++] forKey:@"index"];
			
			[vertices addObject:vertex];
		}
	}
	[shape setValue:[self makeRandomColor] forKey:@"colour"];
		
	[[topView.canvas mutableSetValueForKey:@"shapes"] addObject:shape];
	[[bottomView.canvas mutableSetValueForKey:@"shapes"] addObject:shape];
	[self saveWithViewUpdate:YES];
}

- (NSString *)makeRandomColor {
	
	int red = arc4random() % 256;
	int green = arc4random() % 256;
	int blue = arc4random() % 256;

	return [NSString stringWithFormat:@"%d,%d,%d", red, green, blue];
}

- (void)updateAllShapes {

	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shape" inManagedObjectContext:self.managedObjectContext];
	
	[fetchRequest setEntity:entity];
	NSArray *shapes = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
	[fetchRequest release];
	
	for (NSManagedObject *shape in shapes) {
		[shape setValue:[self makeRandomColor] forKey:@"colour"];
	}
	[self saveWithViewUpdate:YES];
}

- (void)deleteAllShapes {
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shape" inManagedObjectContext:self.managedObjectContext];
	
	[fetchRequest setEntity:entity];
	NSArray *shapes = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
	[fetchRequest release];
	
	for (NSManagedObject *shape in shapes) {
		[self.managedObjectContext deleteObject:shape];
	}
	[self saveWithViewUpdate:YES];
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSManagedObject *canvas1 = nil;
	NSManagedObject *canvas2 = nil;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity  = [NSEntityDescription entityForName:@"Canvas" inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	NSArray *canvases = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
	[fetchRequest release];
	
	if ([canvases lastObject]) {
		canvas1 = [canvases objectAtIndex:0];
		canvas2 = [canvases	objectAtIndex:1];
	}
	else {
		canvas1 = [NSEntityDescription insertNewObjectForEntityForName:@"Canvas" inManagedObjectContext:self.managedObjectContext];
		canvas2 = [NSEntityDescription insertNewObjectForEntityForName:@"Canvas" inManagedObjectContext:self.managedObjectContext];
		
		NSManagedObject *transform1 = [NSEntityDescription insertNewObjectForEntityForName:@"Transform" inManagedObjectContext:self.managedObjectContext];
		[transform1 setValue:[NSNumber numberWithFloat:1] forKey:@"scale"];
		[canvas1 setValue:transform1 forKey:@"transform"];
		
		NSManagedObject *transform2 = [NSEntityDescription insertNewObjectForEntityForName:@"Transform" inManagedObjectContext:self.managedObjectContext];
		[transform2 setValue:[NSNumber numberWithFloat:0.5] forKey:@"scale"];
		[canvas2 setValue:transform2 forKey:@"transform"];
		
		[self saveWithViewUpdate:NO];
	}
	topView.canvas = canvas1;
	bottomView.canvas = canvas2;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self becomeFirstResponder];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self updateAllShapes];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark ManagedObjectContext

- (void)saveWithViewUpdate:(BOOL)updateView {
	NSError *error = nil;
	
	if (![self.managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	if (updateView) {
		[topView setNeedsDisplay];
		[bottomView setNeedsDisplay];
	}
}

#pragma mark -
#pragma mark UIView

- (BOOL)canBecomeFirstResponder {
	return YES;
}

#pragma mark -
#pragma mark Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

	UITouch *touch = [touches anyObject];
	
	CGPoint location = [touch locationInView:touch.view];
	
	float scale = [(BasicCanvasView *)touch.view scale];
	location = CGPointMake(location.x / scale, location.y / scale);
	
	[self createShapeAt:location];
}

#pragma mark -
#pragma mark Shake event

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {

	if (event.subtype == UIEventSubtypeMotionShake) {
		[self deleteAllShapes];
	}
}

- (void)dealloc {
    [super dealloc];
}

@end
