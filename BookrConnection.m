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

@synthesize moContext;

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
    objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://192.168.178.14:1337"]];
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

-(void)makeSuperBookRequest:(NSString *)searchPath
{
    RKObjectMapping *objMapping = [RKObjectMapping mappingForClass:[SuperBookWrapper class]];
    [objMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil toKeyPath:@"superBookDict"]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:objMapping method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    
    [objectManager getObjectsAtPath:[NSString stringWithFormat:@"/search/%@/more",searchPath]
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

@end
