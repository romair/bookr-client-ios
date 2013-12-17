//
//  BookrConnection.h
//  bookr
//
//  Created by Steve Maahs on 10.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import <RestKit/RestKit.h>

@protocol ObjectLoadDelegate <NSObject>

@required -(void)objectDidLoad:(NSArray *)array;

@end

@interface BookrConnection : NSObject
{
    RKObjectManager* objectManager;
}

@property (strong, nonatomic) NSManagedObjectContext *moContext;
@property (strong, nonatomic) NSArray *booooks;
@property (weak, nonatomic) id <ObjectLoadDelegate> delegate;

+(BookrConnection *)sharedInstance;

-(void)makeSuperBookRequest:(NSString *)searchPath;
-(void)makeVersionRequest:(NSString *)searchPath;

@end
