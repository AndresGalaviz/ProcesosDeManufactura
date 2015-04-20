//
//  Stage.h
//  release 2
//
//  Created by alumno on 15/04/15.
//  Copyright (c) 2015 JuanPauloLara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stage : NSObject

@property NSInteger row;
@property NSInteger col;
@property NSInteger type;
@property NSInteger entrada;
@property NSInteger salida;

-(id)initWithRow:(NSInteger)r col:(NSInteger)c type:(NSInteger)t;
-(id)initWithRow:(NSInteger)r col:(NSInteger)c type:(NSInteger)t entrada:(NSInteger)e;

@end
