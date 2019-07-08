//
//  DynamicInputView.m
//  UI
//
//  Created by gshopper on 2019/6/27.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "DynamicInputView.h"

@interface DynamicInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) UILabel *placeholderLabel;


@end

@implementation DynamicInputView

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.line.backgroundColor = self.lineColor;
    self.textfield.delegate = self;
    self.placeholderLabel.textColor = UIColor.lightGrayColor;
    [self addSubview:self.textfield];
    [self addSubview:self.line];
    [self addSubview:self.placeholderLabel];
    [self makeConstraints];
}
- (void)makeConstraints {
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-15);
        make.height.equalTo(1);
    }];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.line);
        make.top.equalTo(self).offset(5);
    }];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.textfield);
        make.centerY.equalTo(self.textfield);
    }];
}

/**
 设置密码框隐藏/可见按钮
 */
- (void)setSecurityRightView {
    BaseButton *rightView = [[BaseButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [rightView setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [rightView setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
    [rightView addTarget:self action:@selector(securityRightViewAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightView = rightView;
    self.textfield.rightViewMode = UITextFieldViewModeAlways;
    self.textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
}
- (void)setRightView:(UIView *)rightView {
    _rightView = rightView;
    self.textfield.rightView = rightView;
}
#pragma mark - Public
- (void)showWarning {
    [self lineFocus];
}
- (void)hideWarning {
    [self lineBlur];
}
#pragma mark - Action

/**
  激活时，提示线动画（标红）
 */
- (void)lineFocus {
    [UIView animateWithDuration:0.2 animations:^{
        self.line.backgroundColor = self.lineFocusColor;
    }];
}

/**
 离开时，正常颜色
 */
- (void)lineBlur {
    [UIView animateWithDuration:0.2 animations:^{
        self.line.backgroundColor = self.lineColor;
    }];
}

/**
 占位符上升为标题并缩小
 */
- (void)placeholderRising {
    [UIView animateWithDuration:0.2 animations:^{
        [self.placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.textfield).offset(-(self.textfield.frame.size.height/4));
        }];
        self.placeholderLabel.transform = CGAffineTransformMake(0.75, 0, 0, 0.75, -(self.placeholderLabel.frame.size.width/2*0.25), -(self.placeholderLabel.frame.size.height/2*0.75));
        [self layoutIfNeeded];
    }];
}
- (void)placeholderFalling {

    [UIView animateWithDuration:0.2 animations:^{
        [self.placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.textfield);
        }];
        self.placeholderLabel.transform = CGAffineTransformMake(1.0, 0, 0, 1.0, 0, 0);
        [self layoutIfNeeded];
    }];
}

/**
 密码隐藏/可见
 */
- (void)securityRightViewAction: (UIButton *)sender {
    sender.selected = !sender.selected;
    self.textfield.secureTextEntry = !sender.selected;
}
- (void)rightViewAction: (id)sender {
    
}
#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self lineFocus];
    if (textField.text == nil || textField.text.length == 0) {
        [self placeholderRising];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicInputViewDidBeginEditing:)]) {
        [self.delegate dynamicInputViewDidBeginEditing:self];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self lineBlur];
    if (textField.text == nil || textField.text.length == 0) {
        [self placeholderFalling];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicInputViewDidEndEditing:)]) {
        [self.delegate dynamicInputViewDidEndEditing:self];
    }
}

#pragma mark - Getter & Setter
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
    }
    return _line;
}
- (UITextField *)textfield {
    if (_textfield == nil) {
        _textfield = [[UITextField alloc] init];
    }
    return _textfield;
}
- (NSString *)text {
    return self.textfield.text;
}
- (void)setPlaceholder:(NSString *)placeholder {
//    self.textfield.placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
}
- (void)setType:(DynamicInputType)type {
    switch (type) {
        case DynamicInputTypeSecurity:
            self.textfield.secureTextEntry = YES;   // 默认开启密文输入
            [self setSecurityRightView];    // 密文/明文开关按钮
            break;
            
        default:
            break;
    }
}
- (UIColor *)lineColor {
    if (_lineColor) {
        return _lineColor;
    }
    return UIColor.lightGrayColor;
}
- (UIColor *)lineFocusColor {
    if (_lineFocusColor) {
        return _lineFocusColor;
    }
    return UIColor.redColor;
}
- (UILabel *)placeholderLabel {
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc] init];
    }
    return _placeholderLabel;
}
@end
