//
//  QYAnswerView.h
//  01-QYGuessPictureDemo
//
//  Created by qingyun on 15/9/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QYAnswerViewDelegate <NSObject>

@optional
-(void)answerBtnAction:(UIButton *)answerBtn;

@end

@interface QYAnswerView : UIView
@property(nonatomic, strong)NSMutableArray *answerBtnIndexs;//需要填写的answerBtn的index集合
@property(nonatomic)NSInteger answerCount;//答案的字体个数
//@property(nonatomic,assign)id <QYAnswerViewDelegate> delegate;

@property(nonatomic, strong)void (^answerBtnAction)(UIButton *);
+(instancetype)answerViewWithCount:(NSInteger)count;


@end
