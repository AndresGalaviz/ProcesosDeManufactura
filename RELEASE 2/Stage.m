//
//  Stage.m
//  release 2
//
//  Created by alumno on 15/04/15.
//  Copyright (c) 2015 JuanPauloLara. All rights reserved.
//

#import "Stage.h"

@implementation Stage

-(id)initWithRow:(NSInteger)r col:(NSInteger)c type:(NSInteger)t {
    return [self initWithRow:r col:c type:t entrada:0];
}

-(id)initWithRow:(NSInteger)r col:(NSInteger)c type:(NSInteger)t entrada:(NSInteger)e {
    self = [super init];
    _row = r;
    _col = c;
    _type = t;
    _entrada = e;
    _salida = 0;
    _encendida = NO;
    return self;
}

@end
