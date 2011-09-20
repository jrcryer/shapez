//
//  Canvas.h
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Transform.h"


@interface Canvas :  NSManagedObject  
{
}

@property (nonatomic, retain) NSSet* shapes;
@property (nonatomic, retain) Transform * transform;

+ (Canvas *)initWithTranform:(Transform *)transform inContext:(NSManagedObjectContext *)context;

@end


@interface Canvas (CoreDataGeneratedAccessors)
- (void)addShapesObject:(NSManagedObject *)value;
- (void)removeShapesObject:(NSManagedObject *)value;
- (void)addShapes:(NSSet *)value;
- (void)removeShapes:(NSSet *)value;

@end

