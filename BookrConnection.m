//
//  BookrConnection.m
//  bookr
//
//  Created by Steve Maahs on 10.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import "BookrConnection.h"

#import "SuperBookWrapper.h"
#import "AppDelegate.h"

@implementation BookrConnection

static BookrConnection  *sharedInstance = nil;

@synthesize moContext;

+(BookrConnection *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[BookrConnection alloc] init];
    }
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setupContext];
        [self setupManager];
    }
    return self;
}

-(void)setupManager
{
    objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://54.217.229.167"]];
    //objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://172.20.10.4:3000"]];
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
}

-(void)setupContext
{
    moContext = [[NSManagedObjectContext alloc] init];
    
    NSPersistentStoreCoordinator *persistantStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Book" withExtension:@"momd"]]];
    [moContext setPersistentStoreCoordinator:persistantStoreCoordinator];
    if (moContext == nil)
    {
        //managedObjectContext = [[[UIApplication sharedApplication] delegate] man];
        NSLog(@"After managedObjectContext: %@",  moContext);
    }
}

-(void)makeSuperBookRequest:(NSString *)searchPath more:(Boolean)isMore
{
    RKObjectMapping *objMapping = [RKObjectMapping mappingForClass:[SuperBookWrapper class]];
    [objMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil toKeyPath:@"superBookDict"]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:objMapping method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    NSString *moreString = @"";
    if (isMore) {
        moreString = @"/more";
    }
    
    
    [objectManager getObjectsAtPath:[NSString stringWithFormat:@"/search/%@%@",searchPath,moreString]
                         parameters:nil
                            success:^(RKObjectRequestOperation * operaton, RKMappingResult *mappingResult)
     {
         NSLog(@"success: mappings: %@", mappingResult);
         _booooks = [self mappingSuperBook:[mappingResult array]];
         [_delegate objectDidLoad:_booooks];
         
     }
                            failure:^(RKObjectRequestOperation * operaton, NSError * error)
     {
         NSLog (@"failure: operation: %@ \n\nerror: %@", operaton, error);
         //NSLog(@"%@",operaton.HTTPRequestOperation.response);
     }];
}

-(void)makeVersionRequest:(NSString *)searchPath
{
    RKObjectMapping *objMapping = [RKObjectMapping mappingForClass:[SuperBookWrapper class]];
    [objMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil toKeyPath:@"superBookDict"]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:objMapping method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    
    [objectManager getObjectsAtPath:[NSString stringWithFormat:@"/book/version/%@",searchPath]
                         parameters:nil
                            success:^(RKObjectRequestOperation * operaton, RKMappingResult *mappingResult)
     {
         NSLog(@"success: mappings: %@", mappingResult);
         NSLog(@"%@",[[mappingResult.array objectAtIndex:0] superBookDict]);
        // NSLog(@"%@",[self mappingBook:[mappingResult array]]);
         //_booooks = [self mappingSuperBook:[mappingResult array]];
         [_delegate objectDidLoad:[self mappingBook:[mappingResult array]]];
         
     }
                            failure:^(RKObjectRequestOperation * operaton, NSError * error)
     {
         NSLog (@"failure: operation: %@ \n\nerror: %@", operaton, error);
         //NSLog(@"%@",operaton.HTTPRequestOperation.response);
     }];
}


-(NSArray *)mappingSuperBook:(NSArray *)superbooks
{
    NSDictionary *dic;
    NSMutableArray *bookArray = [NSMutableArray array];
    for (SuperBookWrapper *wrappedBook in superbooks) {
        dic = [wrappedBook superBookDict];
        
        SuperBook *book = [NSEntityDescription insertNewObjectForEntityForName:@"SuperBook" inManagedObjectContext:moContext];
        
        [book setTitle:[dic objectForKey:@"title"]];
        [book setSubtitle:[dic objectForKey:@"subTitle"]];
        [book setIdent:[dic objectForKey:@"_id"]];
        [book setYear:[dic objectForKey:@"year"]];
        [book setAuthors:[self mappingAuthors:[dic objectForKey:@"authors"]]];
        [book setIsbns:[self mappingISBNs:[dic objectForKey:@"isbns"]]];
        [bookArray addObject:book];
    }
    
    return bookArray;
}

-(NSArray *)mappingBook:(NSArray *)superbooks
{
    NSDictionary *dic;
    NSMutableArray *bookArray = [NSMutableArray array];
    for (SuperBookWrapper *wrappedBook in superbooks) {
        dic = [wrappedBook superBookDict];
        
        Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:moContext];
        
        [book setTitle:[dic objectForKey:@"title"]];
        [book setSubtitle:[dic objectForKey:@"subTitle"]];
        [book setPublisher:[dic objectForKey:@"publisher"]];
        [book setSuperBook:[dic objectForKey:@"superBook"]];
        [book setYear:[dic objectForKey:@"year"]];
        [book setAuthors:[self mappingAuthors:[dic objectForKey:@"authors"]]];
        [book setIsbn:[self mappingISBN:[dic objectForKey:@"isbn"]]];
        [book setThumbnail:[self mappingthumbnail:[dic objectForKey:@"thumbnail"]]];
        [book setTextSnippet:[dic objectForKey:@"textSnippet"]];
        [book setQuality:[NSNumber numberWithInt:[(NSString *)[dic objectForKey:@"quality"] intValue]]];
        [bookArray addObject:book];
    }
    
    return bookArray;
}

-(NSSet *)mappingAuthors:(NSArray *)authors
{
    NSMutableSet *authorSet = [NSMutableSet set];
    
    for (NSString *name in authors) {
        Author *author = [NSEntityDescription insertNewObjectForEntityForName:@"Author" inManagedObjectContext:moContext];
        [author setName:name];
        [authorSet addObject:author];
    }
    
    return authorSet;
}

-(ISBN *)mappingISBN:(NSDictionary *)isbns
{
    ISBN *isbn = [NSEntityDescription insertNewObjectForEntityForName:@"ISBN" inManagedObjectContext:moContext];
    [isbn setIsbn10:[isbns objectForKey:@"isbn10"]];
    [isbn setIsbn13:[isbns objectForKey:@"isbn13"]];
    
    return isbn;
}

-(NSSet *)mappingISBNs:(NSArray *)isbns
{
    NSMutableSet *isbnSet = [[NSMutableSet alloc] init];
    for (NSArray *bothISBN in isbns) {
        ISBN *isbn = [NSEntityDescription insertNewObjectForEntityForName:@"ISBN" inManagedObjectContext:moContext];
        [isbn setIsbn10:[bothISBN objectAtIndex:0]];
        [isbn setIsbn13:[bothISBN objectAtIndex:1]];
        [isbnSet addObject:isbn];
    }
    
    return isbnSet;
}

-(Thumbnail *)mappingthumbnail:(NSDictionary *)thumbnails
{
    Thumbnail *thumbnail = [NSEntityDescription insertNewObjectForEntityForName:@"Thumbnail" inManagedObjectContext:moContext];
    [thumbnail setSmall:[thumbnails objectForKey:@"small"]];
    [thumbnail setNormal:[thumbnails objectForKey:@"normal"]];
    
    return thumbnail;
}

@end
