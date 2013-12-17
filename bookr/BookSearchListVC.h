//
//  FirstViewCont.h
//  bookr
//
//  Created by Steve Maahs on 11.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookrConnection.h"

@interface BookSearchListVC : UITableViewController <ObjectLoadDelegate,UISearchBarDelegate>
{
    BookrConnection *conn;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBarView;

@property (strong,nonatomic) NSMutableArray * bookArray;

@end
