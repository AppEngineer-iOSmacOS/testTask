//
//  TSPUpdateToDoViewController.h
//  Done
//
//  Created by sozinov.com
//  Copyright (c) 2015 Tuts+. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface TSPUpdateToDoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSManagedObject *record;

@end
