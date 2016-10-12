//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-10-11.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

// A class method "+"
+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;

@end
