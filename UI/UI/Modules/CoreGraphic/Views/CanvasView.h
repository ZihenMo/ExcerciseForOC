//
//  BGView.h
//  UI
//
//  Created by gshopper on 2019/5/14.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ShapeType) {
    ShapeTypeTriangle,
    ShapeTypeCircle,
    ShapeTypePie,
    ShapeTypeString,
    ShapeTypeImage,
    ShapeTypeGradient
};
typedef NS_ENUM(NSUInteger, DrawType) {
    DrawTypeUIKit,
    DrawTypeCoreGraphic
};


@interface CanvasView : UIView
@property (nonatomic, assign) ShapeType shapeType;
@property (nonatomic, assign) DrawType drawType;
@end

NS_ASSUME_NONNULL_END
