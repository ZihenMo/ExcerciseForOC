//
//  MessageCell.m
//  SendbirdChat
//
//  Created by gshopper on 2019/6/11.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "MessageCell.h"
@interface MessageBubble: UIView
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UILabel *label;
@end
@implementation MessageBubble

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *label = [[UILabel alloc] initWithFrame:self.frame];
    [self addSubview:label];
    self.label = label;
}

/*
- (void)drawRect:(CGRect)rect {
    UIBezierPath *bp = [UIBezierPath bezierPath];
    CGFloat radius = 4.0;
    [self.backgroundColor set];
    [bp moveToPoint:CGPointMake(radius, 0)];
    
    [bp addLineToPoint:CGPointMake(CGRectGetMaxX(rect) - radius, 0)];
    [bp addArcWithCenter:CGPointMake((CGRectGetMaxX(rect) - radius), radius) radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    [bp addLineToPoint:CGPointMake(0, CGRectGetMaxY(rect))];
    [bp addArcWithCenter:CGPointMake(CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius) radius:radius startAngle:M_PI endAngle:-M_PI_2 clockwise:YES];
    
    [bp addLineToPoint:CGPointMake(radius, CGRectGetMaxY(rect))];
    [bp addArcWithCenter:CGPointMake(radius, CGRectGetMaxY(rect) - radius) radius:radius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    
    [bp addLineToPoint:CGPointMake(0, radius)];
    [bp addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [bp stroke];
}
 */


@end

@interface MessageCell()
@property (nonatomic, strong) MessageBubble *bubble;

@end
@implementation MessageCell


- (void)awakeFromNib {
    [super awakeFromNib];
//    MessageBubble *bubble = [[MessageBubble alloc] initWithFrame:self.frame];
//    [self addSubview:bubble];
//    self.bubble = bubble;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setMessage:(NSString *)message {
    self.bubble.text = message;
}

@end
