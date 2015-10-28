//
//  QYQuestion.h
//  01-QYGuessPictureDemo
//
//  Created by qingyun on 15/9/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYQuestion : NSObject
@property(nonatomic, strong)NSString *answer;
@property(nonatomic, strong)NSString *icon;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSArray *options;

//答案的长度
@property(nonatomic)NSInteger answerCount;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
+(instancetype)questionWithDictionary:(NSDictionary *)dic;

@end
