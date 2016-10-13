//
//  BNRSelectDateViewController.h
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-10-13.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;

@interface BNRSelectDateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *dateSelected;

@property (nonatomic, strong) BNRItem *item;

@end
