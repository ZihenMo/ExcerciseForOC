//
//  BGView.h
//  UI
//
//  Created by gshopper on 2019/5/14.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    ShapeTypeTriangle,
    ShapeTypeCircle,
    ShapeTypePie,
    ShapeTypeString,
    ShapeTypeImage,
    ShapeTypeGradient
} ShapeType;

@interface CanvasView : UIView
@property (nonatomic, assign) ShapeType type;
@end

NS_ASSUME_NONNULL_END
