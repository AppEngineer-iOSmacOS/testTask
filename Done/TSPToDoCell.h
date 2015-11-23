//
//  TSPToDoCell.h
//  Done
//
//  Created by sozinov.com
//  Copyright (c) 2015 Tuts+. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TSPToDoCellDidTapButtonBlock)();

@interface TSPToDoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;


@property (copy, nonatomic) TSPToDoCellDidTapButtonBlock didTapButtonBlock;

@end
