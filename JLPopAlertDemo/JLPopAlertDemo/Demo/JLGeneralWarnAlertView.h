//
//  JLGeneralWarnAlertView.h
//  JLIMProject
//
//  Created by xuqinqiang on 2020/4/10.
//  Copyright © 2020 Qiju. All rights reserved.
//  通用的警告弹窗 用此类替代系统的警告弹窗

#import "JLBaseAlertViewController.h"

@interface JLGeneralWarnAlertView : JLBaseAlertViewController
/// 标题文本对齐方式 默认居中对齐
@property (nonatomic, assign) NSTextAlignment titleAlignment;
/// 标题文本字体 默认 [UIFont systemFontOfSize:16]
@property (nonatomic, strong) UIFont *titleFont;
/// 标题文本颜色 默认 kJLColor333
@property (nonatomic, strong) UIColor *titleColor;
/// 中间文本对齐方式 默认居中对齐
@property (nonatomic, assign) NSTextAlignment contentAlignment;
/// 中间文本字体 默认 [UIFont systemFontOfSize:13]
@property (nonatomic, strong) UIFont *contentFont;
/// 中间文本颜色 默认 kJLColor999
@property (nonatomic, strong) UIColor *contentColor;
/// 显示右上角关闭按钮 默认关闭
@property (nonatomic, assign) BOOL showImageCloseBtn;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

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
               determineBlock:(dispatch_block_t)determineBlock;

@end
