//
//  Polygon.h
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Shape.h"


@interface Polygon :  Shape  
{
}

@property (nonatomic, retain) NSSet* vertices;

+ (Polygon *)polygonAtPoint:(CGPoint)origin inContext:(NSManagedObjectContext *)context;

@end


@interface Polygon (CoreDataGeneratedAccessors)
- (void)addVerticesObject:(NSManagedObject *)value;
- (void)removeVerticesObject:(NSManagedObject *)value;
- (void)addVertices:(NSSet *)value;
- (void)removeVertices:(NSSet *)value;

@end

