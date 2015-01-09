//
//  ABCCartTableViewCell.h
//  abc-wine
//
//  Created by Kurt Guenther on 1/9/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABCCartTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* nameLabel;

@property (nonatomic, strong) IBOutlet UIButton* subtractButton;
@property (nonatomic, strong) IBOutlet UIButton* addButton;

@end
