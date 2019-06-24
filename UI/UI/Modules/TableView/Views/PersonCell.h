//
//  PersonCell.h
//  UI
//
//  Created by mozihen on 2019/5/4.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;
NS_ASSUME_NONNULL_BEGIN

@interface PersonCell : UITableViewCell

- (void)bindSource: (Person *)person;

@end

NS_ASSUME_NONNULL_END
