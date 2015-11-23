//
//  TSPAddToDoViewController.h
//  Done
//
//  Created by sozinov.com
//  Copyright (c) 2015 Tuts+. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface TSPAddToDoViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
