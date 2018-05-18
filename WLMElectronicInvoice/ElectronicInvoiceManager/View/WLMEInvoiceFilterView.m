//
//  WLMEInvoiceFilterView.m
//  WLMElectronicInvoice
//
//  Created by Qianbao on 2018/5/15.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMEInvoiceFilterView.h"

@interface WLMEInvoiceFilterView ()

@property (nonatomic, strong) UIView *blurView;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIView *stateBgView;
@property (nonatomic, strong) UIView *actionBgView;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, copy) NSArray *stateDatas;
@property (nonatomic, strong) WLMEInvoiceCustomFilterButton *tempState;
@property (nonatomic, strong) WLMEInvoiceCustomFilterButton *tempType;

@end

@implementation WLMEInvoiceFilterView

- (id)init {
    self = [super init];
    if (self) {
        [self dataInit];
        [self setUpViews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self dataInit];
        [self setUpViews];
    }
    return self;
}

- (void)dataInit {
    self.stateDatas = @[@{@"title":@"全部",@"tag":@(1)},
                       @{@"title":@"已开票",@"tag":@(2)},
                       @{@"title":@"作废中",@"tag":@(3)},
                       @{@"title":@"已作废",@"tag":@(4)},
                       @{@"title":@"作废失败",@"tag":@(5)},
                       @{@"title":@"开票失败",@"tag":@(6)},
                       ];
}

- (void)setUpViews {
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.4];
    self.frame = CGRectMake(0, 64+0.5, SCREEN_WIDTH, SCREEN_HEIGHT);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.blurView];
    [self addFilterSubviews:@[self.stateLabel, self.stateBgView, self.line, self.actionBgView] bgType:@"base"];
    [self addFilterSubviews:@[self.cancelBtn, self.confirmBtn] bgType:@"action"];
    
    WLMEInvoiceCustomFilterButton *tempStateBtn = [WLMEInvoiceCustomFilterButton buttonWithType:UIButtonTypeCustom];
    for (int i = 0; i < self.stateDatas.count; i ++) {
        NSDictionary *dic = self.stateDatas[i];
        WLMEInvoiceCustomFilterButton *button = [WLMEInvoiceCustomFilterButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = [dic[@"tag"] integerValue];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(stateItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat tempBtnTailWidth = tempStateBtn.frame.origin.x + tempStateBtn.frame.size.width;
        CGFloat tempBtnTailHeight = tempStateBtn.frame.origin.y + tempStateBtn.frame.size.height;
        
        BOOL anotherRow = (tempBtnTailWidth + button.frame.size.width + 8 > SCREEN_WIDTH);
        CGPoint point = CGPointZero;
        
        if (anotherRow) {
            point = CGPointMake(8, tempBtnTailHeight + 8);
        } else {
            if (i == 0) {
                point = CGPointMake(8, tempStateBtn.frame.origin.y);
            } else {
                point = CGPointMake(tempBtnTailWidth + 8, tempStateBtn.frame.origin.y);
            }
        }
        
        CGFloat btnWidth = (SCREEN_WIDTH - 48) / 4;
        button.frame = CGRectMake(point.x, point.y, btnWidth, 28);
        [self.stateBgView addSubview:button];
        
        tempStateBtn = button;
    }
}

- (void)show {
    self.isShowing = YES;
    [[UIApplication sharedApplication].delegate.window addSubview:self];
//    [[APPManager keyWindow] addSubview:self];
}

- (void)dismiss {
    self.isShowing = NO;
    [self removeFromSuperview];
}

- (void)stateItemClick:(WLMEInvoiceCustomFilterButton *)sender {
    self.tempState.selected = NO;
    sender.selected = YES;
    self.tempState = sender;
}

- (void)cancelItemClick:(UIButton *)sender {
    [self dismiss];
}

- (void)confirmItemClick:(UIButton *)sender {
    [self dismiss];
    if (self.clickedItemCallback) {
        self.clickedItemCallback(122);
    }
}

#pragma mark - set get

- (UIView *)blurView {
    if (_blurView == nil) {
        _blurView = [[UIView alloc] init];
        _blurView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        _blurView.backgroundColor = [UIColor whiteColor];
    }
    return _blurView;
}

- (UILabel *)stateLabel {
    if (_stateLabel == nil) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.frame = CGRectMake(16, 24, 56, 18);
        _stateLabel.textColor = RGB(67, 67, 67);
        _stateLabel.font = FONT_PingFang_Light(14);
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        _stateLabel.text = @"开票状态";
    }
    return _stateLabel;
}

- (UIView *)stateBgView {
    if (_stateBgView == nil) {
        _stateBgView = [[UIView alloc] init];
        _stateBgView.frame = CGRectMake(4, 50, SCREEN_WIDTH - 8, 85);
        _stateBgView.backgroundColor = RGB(141, 255, 157);
        _stateBgView.backgroundColor = white_color;
    }
    return _stateBgView;
}

- (UIView *)actionBgView {
    if (_actionBgView == nil) {
        _actionBgView = [[UIView alloc] init];
        _actionBgView.frame = CGRectMake(0, 136, SCREEN_WIDTH, 44);
        _actionBgView.backgroundColor = white_color;
    }
    return _actionBgView;
}

- (UILabel *)line {
    if (_line == nil) {
        _line = [[UILabel alloc] init];
        _line.frame = CGRectMake(0, 135, SCREEN_WIDTH, 1);
        _line.backgroundColor = RGB(238, 238, 238);
    }
    return _line;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 44);
        [_cancelBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = FONT_PingFang_Light(16);
        [_cancelBtn whenTapped:^{
            [self dismiss];
        }];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (_confirmBtn == nil) {
        _confirmBtn = [[UIButton alloc] init];
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 44);
        [_confirmBtn setTitleColor:white_color forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = FONT_PingFang_Light(16);
        [_confirmBtn createGradientButtonWithSize:CGSizeMake(SCREEN_WIDTH, 44) colorArray:@[HexRGB(0xFF7E4A), HexRGB(0xFF4A4A)] gradientType:GradientFromLeftToRight];
        [_confirmBtn addTarget:self action:@selector(confirmItemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

#pragma mark - funciton

- (void)addFilterSubviews:(NSArray *)subviews bgType:(NSString *)type{
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ([view isKindOfClass:[UIView class]]) {
            if ([type isEqualToString:@"action"]) {
                [self.actionBgView addSubview:view];
            } else if ([type isEqualToString:@"base"]) {
                [self.blurView addSubview:view];
            }
        }
    }];
}

@end


@implementation WLMEInvoiceCustomFilterButton : UIButton

+ (id)buttonWithType:(UIButtonType)buttonType {
    WLMEInvoiceCustomFilterButton *button = [super buttonWithType:buttonType];
    CGFloat btnWidth = (SCREEN_WIDTH - 48) / 4;
    button.frame = CGRectMake(0, 0, btnWidth, 28);
    button.backgroundColor = clear_color;
    [button setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    button.titleLabel.font = FONT_PingFang_Light(14);
    [button setBackgroundImage:UIImageName(@"filter_state_normal") forState:UIControlStateNormal];
    return button;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    UIColor *titleColor = selected ? RGB(255, 75, 74) : RGB(153, 153, 153);
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    UIImage *image = selected ? UIImageName(@"filter_state_selected") : UIImageName(@"filter_state_normal");
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

@end
