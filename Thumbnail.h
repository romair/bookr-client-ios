//
//  Thumbnail.h
//  bookr
//
//  Created by Steve Maahs on 17.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Thumbnail : NSManagedObject

@property (nonatomic, retain) NSString * normal;
@property (nonatomic, retain) NSString * small;

@end
