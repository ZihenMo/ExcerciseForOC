//
//  BGView.m
//  UI
//
//  Created by gshopper on 2019/5/14.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.hidden = YES;
}

// 自定义绘制View
- (void)drawRect:(CGRect)rect {
    switch (self.type) {
        case ShapeTypeTriangle:
            [self drawTriangle];
            break;
            
        default:
            break;
    }
    
//    [self drawConcentricCircle];
//    [self drawTriangle];
//    [self drawImage:[UIImage imageNamed:@"timg"]];
    
//    [self cg_drawConcentricCircle];
//    [self cg_drawImageAndShadow:[UIImage imageNamed:@"timg"]];
//    [self cg_drawGradientColor];
    [self cg_drawGradientPath];
}
/**
 绘制三角形
 */
- (void)drawTriangle {
    UIBezierPath *bp = [UIBezierPath bezierPath];
    CGPoint center = self.center;
    CGPoint point1 = CGPointMake(center.x, center.y - 150);
    CGPoint point2 = CGPointMake(center.x - 150, center.y + 150);
    CGPoint point3 = CGPointMake(center.x + 150, center.y + 150);
    [[UIColor orangeColor] setStroke];
    [bp moveToPoint:point1];
    [bp addLineToPoint:point2]; // 线的终点是下次绘制的起点
    [bp addLineToPoint:point3];
    //    [bp addLineToPoint:point1];
    [bp closePath];
    [bp stroke];
}


/**
 绘制同心圆
 */
- (void)drawConcentricCircle {
    UIBezierPath *bp = [UIBezierPath bezierPath];
    CGFloat radius = self.bounds.size.height / 2.0;
    CGPoint center = self.center;
    // 设置线色、线宽、线型   setStroke: 线色， setFill:填充色
    [[UIColor lightGrayColor] set];
    [bp setLineWidth:10.0];
    [bp setLineCapStyle:kCGLineCapRound];   // 圆头
    while (radius > 0) {
        // 抬笔   注意第二个参数为center.y即可
        [bp moveToPoint:CGPointMake(center.x + radius, center.y)];
        // 绘圆
        [bp addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        // 移动到下个圆边的间距
        radius -= 20.0;
    }
    [bp stroke];
}



/**
 Core Graphic方式绘制同心圆
 */
- (void)cg_drawConcentricCircle {
    // 获取当前上下文  最奇葩的获取方式
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetLineWidth(context, 10.f);
    CGPoint center = self.center;
    CGMutablePathRef mp = CGPathCreateMutable();   // 创建绘制路径（画笔）
    for (CGFloat radius = self.bounds.size.height; radius > 0; radius -= 20.0f) {
        // 移动画笔
        CGPathMoveToPoint(mp, NULL, center.x + radius, center.y);
        // 与UIBizerPath不同的是，这里的起角与终角若为0, 2π，则什么也不画。画圆需反过来，起为2π,终为0.
        CGPathAddArc(mp, NULL, center.x, center.y, radius, M_PI * 2, 0, YES);
    }
    CGContextAddPath(context, mp);
    CGContextStrokePath(context);   // 停笔
    CGPathRelease(mp);  // create对应的C对象指针需要手动释放
}


/**
 绘制图片 OC方式
 */
- (void)drawImage: (UIImage *)image {
    CGPoint center = self.center;
    [image drawInRect:CGRectMake(center.x - image.size.width, center.y - image.size.height / 2, image.size.width, image.size.height)];
}


/**
 绘制阴影 图片 CG方式
 */
- (void)cg_drawImageAndShadow: (UIImage *)image {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 保存无阴影状态
    CGContextSaveGState(context);
    // 绘制阴影 阴影大小， 模糊指数
    CGContextSetShadow(context, CGSizeMake(0, 5), 0.1);
    // UIKit 与 Core Graphic的坐标系相关， 0点在左上角与0点在左下角
    // 通过矩阵垂直翻转可进行坐标转换
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(self.center.x - image.size.width, self.center.y - image.size.height / 2, image.size.width, image.size.height), image.CGImage);
    // 恢复无阴影状态
    CGContextRestoreGState(context);
}


/**
  绘制渐变色 Core Grahpic
    渐变填充会直接铺满整个上下文，如需渐变填充路径（线），只能采用剪切路径的方式。
 */
- (void)cg_drawGradientColor {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[8] = {1, 0, 1, 1,         // 渐变起止颜色值， RGBA
        0, 1, 1, 1};
    CGFloat locations[2] = {0.0, 1.0};  // 渐变值范围
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 20.f);
    CGPoint startPoint = CGPointMake(10, 0);    // y值没有作用，会直接铺满垂直方向
    CGPoint endPoint = CGPointMake(self.bounds.size.width - 20,0);
    // 最后一个参数指绘制渐变起止点以外的填充方式：
    // kCGGradientDrawsBeforeStartLocation  // 使用渐变开始颜色填充渐变之前的位置
    // kCGGradientDrawsAfterEndLocation // 使用渐变之后的颜色填充渐变之后的位置
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}


/**
 绘制渐变三角形
 */
- (void)cg_drawGradientPath {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint startPoint = CGPointMake(self.center.x, self.center.y - 200);
    CGPoint midPoint = CGPointMake(10, self.center.y + 200);
    CGPoint endPoint = CGPointMake(self.bounds.size.width - 20, self.center.y + 200);
    CGPathMoveToPoint(path, 0, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, 0, midPoint.x, midPoint.y);
    CGPathAddLineToPoint(path, 0, endPoint.x, endPoint.y);
    CGPathCloseSubpath(path);   // 自动连接起止点
    [self drawLinearGradient:context path:path startColor:UIColor.greenColor.CGColor endColor:UIColor.yellowColor.CGColor];

}

/**
 绘制渐变路径（必须是封闭路径）

 @param context 上下文
 @param path 路径
 @param startColor 起始颜色
 @param endColor 结束颜色
 */
- (void)drawLinearGradient:(CGContextRef)context path:(CGPathRef)path startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);//具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);CGColorSpaceRelease(colorSpace);
}
    
@end
