//
//  QYAnswerView.m
//  01-QYGuessPictureDemo
//
//  Created by qingyun on 15/9/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYAnswerView.h"
#import "common.h"
@implementation QYAnswerView

+(instancetype)answerViewWithCount:(NSInteger)count{
    QYAnswerView *answerView = [[self alloc] initWithFrame:CGRectMake(0, 0, QYScreenW, 40)];
    answerView.answerCount = count;
    //根据count添加答案按钮
    for (int i = 0; i < count; i++) {
        //answerButton之间的间隔
        CGFloat space = 10;
        
        CGFloat answerBtnW = 40;
        CGFloat answerBtnH = 40;
        
        //answerBtn 距离左边屏幕边缘的间隔
        CGFloat baseX = (QYScreenW - count * answerBtnW - (count - 1) * space) / 2;
        
        //answerBtn 的位置
        
        CGFloat answerBtnX = baseX + (space + answerBtnW) * i;
        CGFloat answerBtnY = 0;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(answerBtnX, answerBtnY, answerBtnW, answerBtnH);
        [answerView addSubview:btn];
        
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:answerView action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return answerView;
}

-(NSMutableArray *)answerBtnIndexs{
    if (_answerBtnIndexs == nil) {
        _answerBtnIndexs = [NSMutableArray array];
        for (int i = 0; i < self.answerCount; i++) {
            [_answerBtnIndexs addObject:[NSNumber numberWithInteger:i]];
        }
    }
    return _answerBtnIndexs;
}

-(void)setFrame:(CGRect)frame{
    CGRect originFrame = self.frame;
    originFrame.origin = frame.origin;
    //下面这种写法会造成循环调用，最终死掉（在setFrame:方法里面调用setFrame:方法）
    //self.frame = originFrame;
    //正确写法，调用父类的setFrame:方法，父类的setFrame:就是直接赋值。
    [super setFrame:originFrame];
}

-(void)btnClick:(UIButton *)btn{
    if (_answerBtnAction) {
        _answerBtnAction(btn);
    }
}
@end
