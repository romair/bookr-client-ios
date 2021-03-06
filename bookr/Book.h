//
//  Book.h
//  bookr
//
//  Created by Steve Maahs on 16.01.14.
//  Copyright (c) 2014 WSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Author, ISBN, Thumbnail;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * publisher;
@property (nonatomic, retain) NSNumber * quality;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * superBook;
@property (nonatomic, retain) NSString * textSnippet;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSSet *authors;
@property (nonatomic, retain) ISBN *isbn;
@property (nonatomic, retain) Thumbnail *thumbnail;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addAuthorsObject:(Author *)value;
- (void)removeAuthorsObject:(Author *)value;
- (void)addAuthors:(NSSet *)values;
- (void)removeAuthors:(NSSet *)values;

@end
