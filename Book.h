//
//  Book.h
//  bookr
//
//  Created by Steve Maahs on 10.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Author, ISBN, Thumbnail;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * publisher;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * superBook;
@property (nonatomic, retain) NSString * textSnippet;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSSet *authors;
@property (nonatomic, retain) NSSet *isbn;
@property (nonatomic, retain) Thumbnail *thumbnail;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addAuthorsObject:(Author *)value;
- (void)removeAuthorsObject:(Author *)value;
- (void)addAuthors:(NSSet *)values;
- (void)removeAuthors:(NSSet *)values;

- (void)addIsbnObject:(ISBN *)value;
- (void)removeIsbnObject:(ISBN *)value;
- (void)addIsbn:(NSSet *)values;
- (void)removeIsbn:(NSSet *)values;

@end
