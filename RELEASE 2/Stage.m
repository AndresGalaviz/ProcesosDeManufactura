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
    return [self initWithRow:r col:c type:t tiempo:0];
}

-(id)initWithRow:(NSInteger)r col:(NSInteger)c type:(NSInteger)t tiempo:(NSInteger)ti {
    self = [super init];
    _row = r;
    _col = c;
    _type = t;
    _tiempoDeEspera = ti;
    _tiempoInterno = ti;
    _producto = 0;
    _materiaPrima = -1;
    _encendida = NO;
    _mostrarId = NO;
    return self;
}

-(void)procesar {
    _tiempoInterno -= 1;
    if (_tiempoInterno == 0) {
        _tiempoInterno = _tiempoDeEspera;
        _producto += 1;
    }
}

@end
