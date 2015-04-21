//
//  Proceso.m
//  release 2
//
//  Created by alumno on 15/04/15.
//  Copyright (c) 2015 JuanPauloLara. All rights reserved.
//

#import "Process.h"
#import "Stage.h"

@implementation Process

-(id)init {
    self = [super init];
    _maquinas = [[NSMutableArray alloc] init];
    return self;
}

-(id)initDemo {
    self = [super init];
    _maquinas = [[NSMutableArray alloc] init];
    _conecciones = [[NSMutableArray alloc] init];
    _numDestino = [[NSMutableArray alloc] init];
    
    [_maquinas addObject:[[Stage alloc] initWithRow:1 col:1 type:1 entrada:3]];
    [_maquinas addObject:[[Stage alloc] initWithRow:1 col:2 type:1 entrada:8]];
    [_maquinas addObject:[[Stage alloc] initWithRow:1 col:5 type:2 entrada:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:1 col:6 type:1 entrada:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:1 col:7 type:1 entrada:5]];
    [_maquinas addObject:[[Stage alloc] initWithRow:3 col:2 type:3]];
    [_maquinas addObject:[[Stage alloc] initWithRow:3 col:6 type:2]];
    [_maquinas addObject:[[Stage alloc] initWithRow:3 col:7 type:3]];
    [_maquinas addObject:[[Stage alloc] initWithRow:5 col:1 type:2]];
    [_maquinas addObject:[[Stage alloc] initWithRow:5 col:2 type:2]];
    [_maquinas addObject:[[Stage alloc] initWithRow:5 col:3 type:4]];
    [_maquinas addObject:[[Stage alloc] initWithRow:5 col:5 type:4]];
    [_maquinas addObject:[[Stage alloc] initWithRow:5 col:6 type:5]];
    [_maquinas addObject:[[Stage alloc] initWithRow:7 col:1 type:5]];
    [_maquinas addObject:[[Stage alloc] initWithRow:7 col:4 type:5]];
    [_maquinas addObject:[[Stage alloc] initWithRow:9 col:1 type:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:9 col:3 type:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:9 col:5 type:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:9 col:6 type:6]];
    
    for (int i = 0; i < [_maquinas count]; i++) {
        [_conecciones addObject:[[NSMutableArray alloc] init]];
        [_numDestino addObject:@(0)];
    }
    
    [self conectarMaquina:5 conMaquina:1];
    [self conectarMaquina:6 conMaquina:3];
    [self conectarMaquina:7 conMaquina:4];
    [self conectarMaquina:8 conMaquina:0];
    [self conectarMaquina:9 conMaquina:5];
    [self conectarMaquina:10 conMaquina:5];
    [self conectarMaquina:11 conMaquina:2];
    [self conectarMaquina:12 conMaquina:6];
    [self conectarMaquina:12 conMaquina:7];
    [self conectarMaquina:13 conMaquina:8];
    [self conectarMaquina:13 conMaquina:9];
    [self conectarMaquina:14 conMaquina:10];
    [self conectarMaquina:14 conMaquina:11];
    [self conectarMaquina:15 conMaquina:13];
    [self conectarMaquina:16 conMaquina:14];
    [self conectarMaquina:17 conMaquina:14];
    [self conectarMaquina:18 conMaquina:12];
    return self;
}

-(void)conectarMaquina:(NSInteger)origen conMaquina:(NSInteger)destino {
    [_conecciones[origen] addObject:@(destino)];
    _numDestino[destino] = @([_numDestino[destino] integerValue] + 1);
}

-(NSString *)exportToString {
    return @"";
}

-(void)importFromString:(NSString *)str {}


@end
