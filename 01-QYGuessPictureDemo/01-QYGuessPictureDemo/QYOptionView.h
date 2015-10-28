//
//  QYOptionView.h
//  01-QYGuessPictureDemo
//
//  Created by qingyun on 15/9/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QYOptionViewDelegate <NSObject>

@optional
-(void)optionBtnAction:(UIButton *)optionBtn;
//
-(void)optionBtnAction:(UIButton *)optionBtn isHint:(BOOL)isHint;

@end

@class QYQuestion;
@interface QYOptionView : UIView

@property(nonatomic,assign)id <QYOptionViewDelegate> delegate;
+(instancetype)optionView;
//设置每一个optionBtn的标题
-(void)setOptionBtnTitleWith:(QYQuestion *)question;
@end
