//
//  ISBN.h
//  bookr
//
//  Created by Steve Maahs on 16.01.14.
//  Copyright (c) 2014 WSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ISBN : NSManagedObject

@property (nonatomic, retain) NSString * isbn10;
@property (nonatomic, retain) NSString * isbn13;

@end
