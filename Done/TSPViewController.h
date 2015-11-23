//
//  TSPViewController.h
//  Done
//
//  Created by sozinov.com
//  Copyright (c) 2015 Tuts+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSPViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
