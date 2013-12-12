//
//  SuperBook.h
//  bookr
//
//  Created by Steve Maahs on 11.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Author, ISBN;

@interface SuperBook : NSManagedObject

@property (nonatomic, retain) NSString * ident;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) id year;
@property (nonatomic, retain) NSSet *authors;
@property (nonatomic, retain) NSSet *isbns;
@end

@interface SuperBook (CoreDataGeneratedAccessors)

- (void)addAuthorsObject:(Author *)value;
- (void)removeAuthorsObject:(Author *)value;
- (void)addAuthors:(NSSet *)values;
- (void)removeAuthors:(NSSet *)values;

- (void)addIsbnsObject:(ISBN *)value;
- (void)removeIsbnsObject:(ISBN *)value;
- (void)addIsbns:(NSSet *)values;
- (void)removeIsbns:(NSSet *)values;

@end
