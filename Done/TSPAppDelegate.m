//
//  TSPAppDelegate.m
//  Done
//
//  Created by sozinov.com
//  Copyright (c) 2015 Tuts+. All rights reserved.
//

#import "TSPAppDelegate.h"

#import <CoreData/CoreData.h>

#import "TSPViewController.h"
#import "TSPItem+CoreDataProperties.h"


@interface TSPAppDelegate ()





@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSMutableArray *myObject;
@property (strong, nonatomic) NSDictionary *dictionary;
@property (strong, nonatomic) NSDictionary *dictionaryCD;

@property (strong, nonatomic) NSString * json_autorSong;
@property (strong, nonatomic) NSString * json_labelSong;
@property (strong, nonatomic) NSNumber * json_idSong;



@end

@implementation TSPAppDelegate




#pragma mark -
#pragma mark Application Did Finish Launching
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NSURL *scriptUrl = [NSURL URLWithString:@"http://tomcat.kilograpp.com/songs/api/songs"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data) {
        
        [self populateDatabase];
        [self saveCoreData];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Внимание!" message:@"Отсутсвует подключение \nк сети интернет!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    }
    
    [self populateDatabase];
    
    // выбор Main Storyboard
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    // Instantiate Root Navigation Controller
    UINavigationController *rootNavigationController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"rootNavigationController"];
    
    // Configure View Controller
    TSPViewController *viewController = (TSPViewController *)[rootNavigationController topViewController];
    
    if ([viewController isKindOfClass:[TSPViewController class]]) {
        [viewController setManagedObjectContext:self.managedObjectContext];
    }
    
    // Configure Window
    [self.window setRootViewController:rootNavigationController];

    
    return YES;
}

#pragma mark -
#pragma mark Application Life Cycle
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Save Managed Object Context
    [self saveContext];
    
    /*
    NSError *error = nil;
    
    if (![self.managedObjectContext save:&error]) {
        if (error) {
            NSLog(@"Unable to save changes.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
    }
    */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Save Managed Object Context
    [self saveContext];
    /*
    NSError *error = nil;
    
    if (![self.managedObjectContext save:&error]) {
        if (error) {
            NSLog(@"Unable to save changes.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
    }
    */

}


#pragma mark -  парсим JSON

- (void) jsonPars {
    //    http://tomcat.kilograpp.com/songs/api/songs
    
    NSString *jsonAutorSongKey = @"jsonAutorSongKey";
    NSString *jsonLabelSongKey = @"jsonLabelSongKey";
    NSString *jsonIdSongKey = @"jsonIdSongKey";
    
    
    self.myObject = [[NSMutableArray alloc] init];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://tomcat.kilograpp.com/songs/api/songs"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonSource
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
    
    
    for (NSDictionary *dataDict in jsonObjects) {
        self.json_autorSong = [dataDict objectForKey:@"author"];
        self.json_labelSong = [dataDict objectForKey:@"label"];
        self.json_idSong = [dataDict objectForKey:@"id"];

        NSLog(@"NAME_SONG %@",self.json_autorSong);
        NSLog(@"AUTOR: %@",self.json_labelSong);
        NSLog(@"ID: %@",self.json_idSong);
        
        
        self.dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.json_autorSong, jsonAutorSongKey,
                           self.json_labelSong, jsonLabelSongKey,
                           self.json_idSong, jsonIdSongKey,       nil];
        [self.myObject addObject:self.dictionary];
    }
    
    
}


#pragma mark -
#pragma mark Core Data Stack
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;

    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Done" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Done.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }
    
    return _persistentStoreCoordinator;
}
#pragma mark - Application's Documents directory
// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
#pragma mark -
#pragma mark Helper Methods
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
        }
    }
}


#pragma mark - save CoreData
- (void)populateDatabase {
    
    
    // Helpers
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:@"didPopulateDatabase10"]) return;
    
    [self jsonPars];

    // Update User Defaults
    
    NSLog(@"База данных дополнилась данными");
    [ud setBool:YES forKey:@"didPopulateDatabase10"];
}

-(void) saveCoreData {

   for (_dictionaryCD in self.myObject){
    
    NSManagedObject* record = [NSEntityDescription insertNewObjectForEntityForName:@"TSPItem"
       
                                                            inManagedObjectContext:self.managedObjectContext];
  
      
    [record setValue:[_dictionaryCD objectForKey:@"jsonAutorSongKey"] forKey:@"autorCoreData"];
    [record setValue:[_dictionaryCD objectForKey:@"jsonLabelSongKey"] forKey:@"songCoreData"];
    [record setValue:[NSString stringWithFormat:@"%@", [_dictionaryCD objectForKey:@"jsonIdSongKey"]] forKey:@"idCoreData"];
  }
    
    NSError *error = nil;
    if(error){
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Поздавляем!" message:@"База успешно загружена" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

@end
