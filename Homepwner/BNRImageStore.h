//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-10-13.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRImageStore : NSObject

// Singelton sharedStore
+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key; // Setter
- (UIImage *)imageForKey:(NSString *)key; // Getter
- (void)deleteImageForKey:(NSString *)key; // Delete
- (NSString *)imagePathForKey:(NSString *)key;


@end
