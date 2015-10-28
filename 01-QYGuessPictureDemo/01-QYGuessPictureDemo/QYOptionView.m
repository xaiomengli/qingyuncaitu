//
//  QYOptionView.m
//  01-QYGuessPictureDemo
//
//  Created by qingyun on 15/9/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYOptionView.h"
#import "QYQuestion.h"
@implementation QYOptionView

+(instancetype)optionView{
    //从mainBundle中加载xib  来构建optionView
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"QYOptionView" owner:nil options:nil];
    
    return views[0];
}
- (IBAction)optionBtnClick:(UIButton *)sender {
    //[self.delegate optionBtnAction:sender];
    [self.delegate optionBtnAction:sender isHint:NO];
}
//设置optionBtn的标题
-(void)setOptionBtnTitleWith:(QYQuestion *)question{
    for (int i = 0; i < question.options.count; i++) {
        UIButton *btn = (UIButton *)self.subviews[i];
        
        [btn setTitle:question.options[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void)setFrame:(CGRect)frame{
    CGRect originFrame = self.frame;
    originFrame.origin = frame.origin;
    //下面这种写法会造成循环调用，最终死掉（在setFrame:方法里面调用setFrame:方法）
    //self.frame = originFrame;
    //正确写法，调用父类的setFrame:方法，父类的setFrame:就是直接赋值。
    [super setFrame:originFrame];
}
@end
