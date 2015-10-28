//
//  QYQuestion.m
//  01-QYGuessPictureDemo
//
//  Created by qingyun on 15/9/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYQuestion.h"

@implementation QYQuestion

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        _answer = [dic objectForKey:@"answer"];
        _icon = [dic objectForKey:@"icon"];
        _title = [dic objectForKey:@"title"];
        _options = [dic objectForKey:@"options"];
        
        _answerCount = _answer.length;
    }
    return self;
}

+(instancetype)questionWithDictionary:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}
@end
