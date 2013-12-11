//
//  FirstViewCont.h
//  bookr
//
//  Created by Steve Maahs on 11.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookrConnection.h"

@interface BookSearchListVC : UITableViewController <ObjectLoadDelegate>
{
    BookrConnection *conn;
}

@property NSMutableArray *bookArray;

@end
