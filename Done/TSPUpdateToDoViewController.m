//
//  TSPUpdateToDoViewController.m
//  Done
//
//  Created by sozinov.com
//  Copyright (c) 2015 Tuts+. All rights reserved.
//

#import "TSPUpdateToDoViewController.h"

@implementation TSPUpdateToDoViewController

#pragma mark -
#pragma mark View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.record) {
        // Update Text Field
        [self.textField setText:[self.record valueForKey:@"autorCoreData"]];
    }
}

#pragma mark -
#pragma mark Actions
- (IBAction)cancel:(id)sender {
    // Pop View Controller
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender {
    // Helpers
    NSString *name = self.textField.text;
    
    if (name && name.length) {
        // Populate Record
        [self.record setValue:name forKey:@"autorCoreData"];
        
        // Save Record
        NSError *error = nil;
        
        if ([self.managedObjectContext save:&error]) {
            // Pop View Controller
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            if (error) {
                NSLog(@"Unable to save record.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            
            // Show Alert View
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do could not be saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
    } else {
        // Show Alert View
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do needs a name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

@end
