//
//  Vertex.h
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Polygon;

@interface Vertex :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) Polygon * polygon;

@end



