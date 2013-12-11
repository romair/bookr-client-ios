//
//  ViewController.h
//  bookr
//
//  Created by Steve Maahs on 10.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookrConnection.h"

@interface ViewController : UITableViewController <ObjectLoadDelegate>
{
    BookrConnection *conn;
}

@property NSMutableArray *bookArray;


@end
