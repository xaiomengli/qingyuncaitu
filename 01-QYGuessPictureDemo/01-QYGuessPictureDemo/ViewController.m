 //
//  ViewController.m
//  01-QYGuessPictureDemo
//
//  Created by qingyun on 15/9/1.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYQuestion.h"
#import "QYAnswerView.h"
#import "QYOptionView.h"
#import "common.h"
@interface ViewController ()<UIAlertViewDelegate,QYOptionViewDelegate>
{
    NSInteger index;
}
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong)NSArray *questions;
@property (weak, nonatomic) IBOutlet UIButton *coin;

@property (nonatomic, strong)QYAnswerView *answerView;
@property (nonatomic, strong)QYOptionView *optionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateQuestions];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1://提示
        {
            [self hint:sender];
        }
            break;
        case 2://大图
        {
            [self big:sender];
        }
            break;
        case 3://帮助
        {
            
        }
            break;
        case 4://下一题
        {
            [self next];
        }
            break;
            
        default:
            break;
    }
}
//更新主界面
-(void)updateQuestions{
    if (index >= self.questions.count) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"恭喜你过关了，是否要再来一次" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
        return;
        //问题循环
        //index = 0;
    }
    //从self.questions中取出数据字典dict
    //NSDictionary *dict = [self.questions objectAtIndex:index];
    
    [_answerView removeFromSuperview];
    [_optionView removeFromSuperview];
    
    QYQuestion *question = (QYQuestion *)[self.questions objectAtIndex:index];
    
    //添加answerView
    _answerView = [QYAnswerView answerViewWithCount:question.answerCount];
    _answerView.frame = CGRectMake(0, 370, QYScreenW, 0);
    [self.view addSubview:_answerView];
    //_answerView.backgroundColor = [UIColor redColor];
    //_answerView.delegate = self;
    
    //block块
    
    __weak ViewController *weakSelf = self;
    _answerView.answerBtnAction = ^(UIButton *btn){
        [weakSelf answerBtnAction:btn];
    };
    
    //添加optionView
    _optionView = [QYOptionView optionView];
    _optionView.frame = CGRectMake(0, 450, QYScreenW, 160);
    [self.view addSubview:_optionView];
    _optionView.delegate = self;
    [_optionView setOptionBtnTitleWith:question];
    
    
    //更改 _num、_desc、_imageView;
    _num.text = [NSString stringWithFormat:@"%ld/%lu",index + 1,self.questions.count];
    _imageView.image = [UIImage imageNamed:question.icon];
    _desc.text = question.title;
}

//提示
-(void)hint:(UIButton *)btn{
    
    if ([self.coin.currentTitle isEqualToString:@"0"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"没有钱了，请充值，推荐使用青云支付，尊享8折优惠！" delegate:self cancelButtonTitle:@"立即支付" otherButtonTitles:@"马上支付", nil];
        [alert show ];
        return;
    }
   
    QYQuestion *question = [self.questions objectAtIndex:index];
    //取出当前题目的答案
    NSString *answerString = question.answer;
    
    //获取当前需要填充的answerBtn 的index
    NSInteger rangIndex = [[_answerView.answerBtnIndexs firstObject] integerValue];
    
    NSRange range = NSMakeRange(rangIndex, 1);
    //当前需要填充的answerBtn 的正确答案
    NSString *btnString = [answerString substringWithRange:range];
    
    //
//    UIButton *answerBtn = (UIButton *)_answerView.subviews[rangIndex];
//    [answerBtn setTitle:btnString forState:UIControlStateNormal];
    for (UIButton *btn in _optionView.subviews) {
        //找到与当前btnString相同的optionBtn
        if ([btn.currentTitle isEqualToString:btnString]) {
            //模拟点击optionBtn
            //[self optionBtnAction:btn];
            [self optionBtnAction:btn isHint:YES];
            [self changeScore:-1000];
            break;
        }
    }
}

-(void)changeScore:(NSInteger)score{
    //获取当前的金币
    NSString *currentTitle = self.coin.currentTitle;
    
    NSInteger s = [currentTitle integerValue] + score;
    
    NSString *title = [NSString stringWithFormat:@"%ld",s];
    
    [self.coin setTitle:title forState:UIControlStateNormal];
}

//下一题
-(void)next{
    index++;
    [self updateQuestions];
}


//点击answerBtn
-(void)answerBtnAction:(UIButton *)answerBtn{
    //当answerBtn的标题为空的时候，不做任何操作
    if (answerBtn.currentTitle == nil) return;
    
    //在optionView上显示相对应的optionBtn
    for (UIButton *btn in _optionView.subviews) {
        if ([answerBtn.currentTitle isEqualToString:btn.currentTitle]) {
            //找到需要取消隐藏的optionBtn
            btn.hidden = NO;
        }
    }
    
    //清除当前answerBtn的标题
    [answerBtn setTitle:nil forState:UIControlStateNormal];
    
    //获取当前answerBtn的index
    NSInteger answerBtnIndex = [_answerView.subviews indexOfObject:answerBtn];
    [_answerView.answerBtnIndexs addObject:[NSNumber numberWithInteger:answerBtnIndex]];
    
    //对answerBtnIndexs进行排序
    NSArray *array = [_answerView.answerBtnIndexs sortedArrayUsingSelector:@selector(compare:)];
    _answerView.answerBtnIndexs = [NSMutableArray arrayWithArray:array];
}
#pragma mark QYOptionViewDelegate

//点击optionBtn 选择答案
-(void)optionBtnAction:(UIButton *)optionBtn isHint:(BOOL)isHint{
    
    //有需要填充的answerBtn
    if (_answerView.answerBtnIndexs.count > 0) {
        //获取需要填充的answerbtn的index
        NSInteger answerBtnIndex = [[_answerView.answerBtnIndexs firstObject] integerValue];
        //取出将要填出的answerBtn
        UIButton *answerBtn = (UIButton *)_answerView.subviews[answerBtnIndex];
        //获取optionBtn的标题
        NSString *optionBtnTitle = optionBtn.currentTitle;
        //设置answerBtn的标题
        [answerBtn setTitle:optionBtnTitle forState:UIControlStateNormal];
        //隐藏optionBtn
        optionBtn.hidden = YES;
        //把当前的answerBtn从需要填充的answerBtnIndexs中删除
        [_answerView.answerBtnIndexs removeObjectAtIndex:0];
        
    }
    
    //答案已经填充完毕
    if (_answerView.answerBtnIndexs.count == 0) {
        NSMutableString *answerString = [NSMutableString string];
        for (UIButton *btn in _answerView.subviews) {
            //取出遍历中当前btn的title
            [answerString appendString:btn.currentTitle];
        }
        
        QYQuestion *question = (QYQuestion *)[self.questions objectAtIndex:index];
        
        if ([question.answer isEqualToString:answerString]) {
            //回答正确
            [self changeAnserBtnTitleColor:[UIColor greenColor]];
            
            //时隔0.5s跳转下一题
            [self performSelector:@selector(next) withObject:nil afterDelay:.3];
            
            //加金币
            if (!isHint) {
                [self changeScore:1000];
            }
        }else{
            //回答错误
            [self changeAnserBtnTitleColor:[UIColor redColor]];
        }
    }
    
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        index = 0;
        [self updateQuestions];
    }
}

//设置answerView上所有的Btn的标题颜色
-(void)changeAnserBtnTitleColor:(UIColor *)color{
    //遍历answerView的子视图subviews
    for (UIButton *btn in _answerView.subviews) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
}

//缩小
-(void)small:(UIButton *)btn{
    [UIView animateWithDuration:1 animations:^{
        self.imageView.transform = CGAffineTransformIdentity;
        btn.alpha = 0.0;
    } completion:^(BOOL finished) {
        [btn removeFromSuperview];
    }];
}
//放大
-(void)big:(UIButton *)button{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.view.frame;
    btn.alpha = 0.0;
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(small:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view bringSubviewToFront:self.imageView];
    
    [UIView animateWithDuration:1 animations:^{
        btn.alpha = 0.5;
        self.imageView.transform = CGAffineTransformScale(self.imageView.transform, 1.5, 1.5);
    }];

}

//懒加载数据模型
-(NSArray *)questions{
    if (_questions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
        
        //创建一个可变数组，存放字典转化后的数据模型
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in dicArray) {
            QYQuestion *question = [QYQuestion questionWithDictionary:dic];
            [array addObject:question];
        }
        _questions = array;
    }
    return _questions;
}

@end
