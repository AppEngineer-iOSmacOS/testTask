//
//  TSPItem+CoreDataProperties.h
//  Done
//
//  Created by Nikolay Sozinov on 20.11.15.
//  Copyright © 2015 Tuts+. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TSPItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSPItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *autorCoreData;
@property (nullable, nonatomic, retain) NSString *songCoreData;
@property (nullable, nonatomic, retain) NSString *idCoreData;

@end

NS_ASSUME_NONNULL_END
