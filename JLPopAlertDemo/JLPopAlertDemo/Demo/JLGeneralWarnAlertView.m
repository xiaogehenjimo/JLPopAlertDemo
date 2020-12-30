//
//  JLGeneralWarnAlertView.m
//  JLIMProject
//
//  Created by xuqinqiang on 2020/4/10.
//  Copyright © 2020 Qiju. All rights reserved.
//

#import "JLGeneralWarnAlertView.h"

#define kBtnH getAutoSize(43)
#define kBtnW getAutoSize(110)
#define kBottomSpace getAutoSize(25) //底部间距

@interface JLGeneralWarnAlertView () {
    NSString *title;                //标题
    NSString *content;              //内容
    NSString *cancelTitle;          //取消按钮标题
    NSString *determineBtnTitle;    //确定按钮标题
}
/** 背景 */
@property (nonatomic, strong) UIView *bgView;
/** 标题 */
@property (nonatomic, strong) YYLabel *titleLabel;
/** 内容 */
@property (nonatomic, strong) YYLabel *contentLabel;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *determineBtn;
/** 取消 */
@property (nonatomic, strong) UIButton *cancelBtn;
/** 右上角关闭按钮 */
@property (nonatomic, strong) UIImageView *closeImageView;
/** 右上角关闭按钮点击回调 */
@property (nonatomic, strong) UIButton *rightTopCloseBtn;
/** 取消回调 */
@property (nonatomic, copy) dispatch_block_t cancelBlock;
/** 确定回调 */
@property (nonatomic, copy) dispatch_block_t determineBlock;
/** 是否有按钮 */
@property (nonatomic, assign) BOOL isHaveBtn;
/** 是否有标题 */
@property (nonatomic, assign) BOOL isHaveTitle;
/** 是否有内容 */
@property (nonatomic, assign) BOOL isHaveContent;
@end

@implementation JLGeneralWarnAlertView

/// 创建通用弹窗
/// @param title 标题 可不传
/// @param content 内容 可不传
/// @param cancelBtnTitle 取消按钮标题 可不传
/// @param determineBtnTitle 确定按钮标题 可不传
/// @param cancelBlock 取消回调
/// @param determineBlock 确定回调
- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content
               cancelBtnTitle:(NSString *)cancelBtnTitle
            determineBtnTitle:(NSString *)determineBtnTitle
                  cancelBlock:(dispatch_block_t)cancelBlock
               determineBlock:(dispatch_block_t)determineBlock {
    if (self = [super init]) {
        self->title = title;
        self->content = content;
        self->cancelTitle = cancelBtnTitle;
        self->determineBtnTitle = determineBtnTitle;
        self.cancelBlock = cancelBlock;
        self.determineBlock = determineBlock;
        _contentAlignment = NSTextAlignmentCenter;
        _contentFont = [UIFont systemFontOfSize:13];
        _contentColor = kJLColor999;
        
        _titleAlignment = NSTextAlignmentCenter;
        _titleFont = [UIFont systemFontOfSize:16];
        _titleColor = kJLColor333;
                
        _isHaveBtn = cancelBtnTitle.length || determineBtnTitle.length;
        _isHaveTitle = title.length;
        _isHaveContent = content.length;
        self.tapBlankDismiss = !_isHaveBtn;//如果不传按钮点击空白区域关闭弹窗
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)prepareUI {
    self.jl_disableInteractivePop = YES;
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"000000" andAlpha:.3];
    
    [self.contentView addSubview:self.bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREENWIDTH - kMostAlertWidth) * .5);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(kMostAlertWidth);
    }];
    
    [self.bgView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JLSafeBorder);
        make.right.mas_equalTo(-JLSafeBorder);
        make.top.mas_equalTo(JLSafeBorder * 2);
        if (!self.isHaveBtn && !self.isHaveContent) {//没按钮 没内容
            make.bottom.mas_equalTo(-kBottomSpace);
        }
    }];
    
    [self.bgView addSubview:self.contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JLSafeBorder);
        make.right.mas_equalTo(-JLSafeBorder);
        if (self.isHaveTitle) {
            make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(getAutoSize(20));
        } else {
            make.top.mas_equalTo(getAutoSize(24));
        }
        if (!self.isHaveBtn) {
            make.bottom.mas_equalTo(-kBottomSpace);
        }
    }];
    
    [self.bgView addSubview:self.determineBtn];
    BOOL isHaveCancel = self->cancelTitle.length;
    [_determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kBtnH);
        make.width.mas_equalTo(kBtnW);
        make.bottom.mas_equalTo(-kBottomSpace);
        if (isHaveCancel) {
            make.left.equalTo(self.bgView.mas_centerX).mas_offset(getAutoSize(5));
        } else {
            make.centerX.equalTo(self.bgView);
        }
        
        if (self.isHaveContent) {
            make.top.equalTo(self.contentLabel.mas_bottom).mas_offset(getAutoSize(24));
        } else if (self.isHaveTitle) {
            make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(JLSafeBorder * 2);
        } else {
            make.top.mas_equalTo(JLSafeBorder * 3);
        }
    }];
    
    [self.bgView addSubview:self.cancelBtn];
    BOOL isHaveDeter = self->determineBtnTitle.length;
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isHaveDeter) {
            make.right.equalTo(self.bgView.mas_centerX).mas_offset(-getAutoSize(5));
        } else {
            make.centerX.equalTo(self.bgView);
        }
        make.width.and.height.and.bottom.and.top.equalTo(self.determineBtn);
    }];
    
    if (self.showImageCloseBtn) {
        [self.bgView addSubview:self.closeImageView];
        [_closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-JLSafeBorder);
            make.top.mas_equalTo(JLSafeBorder * .7);
            make.width.and.height.mas_equalTo(JLSafeBorder);
        }];
        
        [self.bgView addSubview:self.rightTopCloseBtn];
        [_rightTopCloseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.closeImageView);
            make.width.and.height.equalTo(self.closeImageView).multipliedBy(2);
        }];
    }
}

#pragma mark - action

//确定按钮点击
- (void)determineBtnPress {
    if (self.determineBlock) {
        self.determineBlock();
    }
    [self dismiss];
}

//取消按钮点击
- (void)cancelBtnPress {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismiss];
}

/// 右上角关闭按钮点击回调
- (void)jl_rightCloseBtnPress {
    [self dismiss];
}

#pragma mark - get

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.shadowColor = [UIColor colorFromHexRGB:@"000000" andAlpha:.3].CGColor;
        _bgView.layer.shadowRadius = 10;
        _bgView.layer.shadowOffset = CGSizeZero;
        _bgView.layer.shadowOpacity = .3;
    }
    return _bgView;
}

- (YYLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[YYLabel alloc] init];
        _titleLabel.preferredMaxLayoutWidth = kMostAlertWidth - JLSafeBorder * 2;
        _titleLabel.numberOfLines = 0;
        NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self->title]];
        attM.yy_font = _titleFont;
        attM.yy_color = _titleColor;
        attM.yy_alignment = _titleAlignment;
        attM.yy_lineSpacing = getAutoSize(6);
        _titleLabel.attributedText = attM;
        _titleLabel.hidden = !self.isHaveTitle;
    }
    return _titleLabel;
}

- (YYLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.hidden = !self.isHaveContent;
        _contentLabel.preferredMaxLayoutWidth = kMostAlertWidth - JLSafeBorder * 2;
        NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self->content]];
        attM.yy_font = _contentFont;
        attM.yy_color = _contentColor;
        attM.yy_alignment = _contentAlignment;
        attM.yy_lineSpacing = getAutoSize(6);
        _contentLabel.attributedText = attM;
    }
    return _contentLabel;
}

- (UIButton *)determineBtn {
    if (!_determineBtn) {
        _determineBtn = [[UIButton alloc] init];
        _determineBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_determineBtn setTitleColor:kJLColor333 forState:UIControlStateNormal];
        [_determineBtn setTitle:[NSString stringWithFormat:@"%@", self->determineBtnTitle] forState:UIControlStateNormal];
        _determineBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _determineBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _determineBtn.layer.cornerRadius = kBtnH * .5;
        _determineBtn.layer.masksToBounds = YES;
        [_determineBtn addTarget:self action:@selector(determineBtnPress) forControlEvents:UIControlEventTouchUpInside];
        CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
        gradientLayer.colors = @[(__bridge id)[UIColor colorFromHexRGB:@"FFD400"].CGColor, (__bridge id)[UIColor colorFromHexRGB:@"FFE76E"].CGColor];
        gradientLayer.locations = @[@0, @1];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.frame = CGRectMake(0, 0, kBtnW, kBtnH);
        [_determineBtn.layer insertSublayer:gradientLayer atIndex:0];
        _determineBtn.hidden = !self->determineBtnTitle.length;
    }
    return _determineBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn setTitleColor:kJLColor999 forState:UIControlStateNormal];
        [_cancelBtn setTitle:[NSString stringWithFormat:@"%@", self->cancelTitle] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cancelBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _cancelBtn.layer.cornerRadius = kBtnH * .5;
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.backgroundColor = kJLColorF1;
        _cancelBtn.hidden = !self->cancelTitle.length;
        [_cancelBtn addTarget:self action:@selector(cancelBtnPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIImageView *)closeImageView {
    if (!_closeImageView) {
        _closeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_alert_close_black"]];
        _closeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _closeImageView;
}

- (UIButton *)rightTopCloseBtn {
    if (!_rightTopCloseBtn) {
        _rightTopCloseBtn = [[UIButton alloc] init];
        _rightTopCloseBtn.backgroundColor = [UIColor clearColor];
        [_rightTopCloseBtn addTarget:self action:@selector(jl_rightCloseBtnPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightTopCloseBtn;
}

@end
