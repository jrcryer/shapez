//
//  Shape.h
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Canvas;

@interface Shape :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * colour;
@property (nonatomic, retain) NSSet* canvases;

@end


@interface Shape (CoreDataGeneratedAccessors)
- (void)addCanvasesObject:(Canvas *)value;
- (void)removeCanvasesObject:(Canvas *)value;
- (void)addCanvases:(NSSet *)value;
- (void)removeCanvases:(NSSet *)value;

@end

