//
//  Proceso.m
//  release 2
//
//  Created by alumno on 15/04/15.
//  Copyright (c) 2015 JuanPauloLara. All rights reserved.
//

#import "Process.h"
#import "Stage.h"
#import "MateriaPrima.h"

@implementation Process

-(id)init {
    self = [super init];
    _maquinas = [[NSMutableArray alloc] init];
    _conecciones = [[NSMutableArray alloc] init];
    _numDestino = [[NSMutableArray alloc] init];
    _materiasPrima = [[NSMutableArray alloc] init];
    _activo = YES;
    return self;
}

-(id)initDemo {
    self = [super init];
    _maquinas = [[NSMutableArray alloc] init];
    _conecciones = [[NSMutableArray alloc] init];
    _numDestino = [[NSMutableArray alloc] init];
    _materiasPrima = [[NSMutableArray alloc] init];
    _activo = YES;
    _dinero = 3000;
    _minutos = 0;
    _segundos = 0;
    
    [_materiasPrima addObject:[[MateriaPrima alloc] initWithPrecio:1 posicion:0]];
    [_materiasPrima addObject:[[MateriaPrima alloc] initWithPrecio:1 posicion:1]];
    [_materiasPrima addObject:[[MateriaPrima alloc] initWithPrecio:1 posicion:4]];
    [_materiasPrima addObject:[[MateriaPrima alloc] initWithPrecio:1 posicion:5]];
    [_materiasPrima addObject:[[MateriaPrima alloc] initWithPrecio:1 posicion:6]];

    [_maquinas addObject:[[Stage alloc] initWithRow:0 col:0 type:0 tiempo:3]];
    [_maquinas addObject:[[Stage alloc] initWithRow:0 col:1 type:0 tiempo:8]];
    [_maquinas addObject:[[Stage alloc] initWithRow:0 col:4 type:1 tiempo:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:0 col:5 type:0 tiempo:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:0 col:6 type:0 tiempo:5]];
    [_maquinas addObject:[[Stage alloc] initWithRow:2 col:1 type:2 tiempo:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:2 col:5 type:1 tiempo:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:2 col:6 type:2 tiempo:9]];
    [_maquinas addObject:[[Stage alloc] initWithRow:4 col:0 type:1 tiempo:12]];
    [_maquinas addObject:[[Stage alloc] initWithRow:4 col:1 type:1 tiempo:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:4 col:2 type:3 tiempo:6]];
    [_maquinas addObject:[[Stage alloc] initWithRow:4 col:4 type:3 tiempo:8]];
    [_maquinas addObject:[[Stage alloc] initWithRow:4 col:5 type:4 tiempo:10]];
    [_maquinas addObject:[[Stage alloc] initWithRow:6 col:0 type:4 tiempo:5]];
    [_maquinas addObject:[[Stage alloc] initWithRow:6 col:3 type:4 tiempo:5]];
    [_maquinas addObject:[[Stage alloc] initWithRow:8 col:0 type:5 tiempo:3]];
    [_maquinas addObject:[[Stage alloc] initWithRow:8 col:2 type:5 tiempo:1]];
    [_maquinas addObject:[[Stage alloc] initWithRow:8 col:4 type:5 tiempo:7]];
    [_maquinas addObject:[[Stage alloc] initWithRow:7 col:5 type:3 tiempo:7]];
    [_maquinas addObject:[[Stage alloc] initWithRow:8 col:5 type:5 tiempo:8]];
    
    for (int i = 0; i < [_maquinas count]; i++) {
        [_conecciones addObject:[[NSMutableArray alloc] init]];
        [_numDestino addObject:@(0)];
    }
    
    [self asignarAMaquina:0 materia:0];
    [self asignarAMaquina:1 materia:1];
    [self asignarAMaquina:2 materia:2];
    [self asignarAMaquina:3 materia:3];
    [self asignarAMaquina:4 materia:4];
    
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
    [self conectarMaquina:19 conMaquina:18];
    
    return self;
}

-(void)asignarAMaquina:(NSInteger)numMaquina materia:(NSInteger)numMateria {
    [_maquinas[numMaquina] setMateriaPrima:numMateria];
}

-(void)conectarMaquina:(NSInteger)origen conMaquina:(NSInteger)destino {
    [_conecciones[origen] addObject:@(destino)];
    _numDestino[destino] = @([_numDestino[destino] integerValue] + 1);
}

-(void)procesar {
    _segundos++;
    if (_segundos == 60) {
        _segundos = 0;
        _minutos++;
    }
    for (int i = 0; i < _maquinas.count; i++) {
        Stage *maquina = _maquinas[i];
        if (maquina.encendida && (maquina.tiempoDeEspera != maquina.tiempoInterno || [self tieneMaterialSuficiente:i])) {
            [maquina procesar];
        }
    }
}

-(void)comprarMateriaPrima:(NSInteger)index cantidad:(NSInteger)cantidad {
    MateriaPrima *mp = _materiasPrima[index];
    NSInteger costo = mp.precio*cantidad;
    if (costo <= _dinero) {
        mp.count += cantidad;
        _dinero -= costo;
    }
}

-(BOOL)tieneMaterialSuficiente:(NSInteger)index {
    Stage *maquina = _maquinas[index];
    if (maquina.materiaPrima == -1) {
        BOOL posible = YES;
        NSMutableArray *con = _conecciones[index];
        for (int i = 0; i < con.count; i++) {
            Stage *destino = _maquinas[[con[i] integerValue]];
            if (destino.producto <= 0) {
                posible = NO;
            }
        }
        if (posible) {
            for (int i = 0; i < con.count; i++) {
                Stage *destino = _maquinas[[con[i] integerValue]];
                destino.producto = destino.producto - 1;
            }
            return YES;
        } else {
            return NO;
        }
    } else {
        MateriaPrima *mp = _materiasPrima[maquina.materiaPrima];
        if (mp.count > 0) {
            mp.count = mp.count - 1;
            return YES;
        } else {
            return NO;
        }
    }
}

-(void)encenderMaquina:(NSInteger)index {
    [_maquinas[index] setEncendida:YES];
}
-(void)apagarMaquina:(NSInteger)index {
    [_maquinas[index] setEncendida:NO];
}

-(NSString *)exportToString {
    NSString *info = [NSString stringWithFormat:@"%d_%d_%d_", _dinero, _minutos, _segundos];
    for (int i = 0; i < _materiasPrima.count; i++) {
        NSString *infoToAppend = [NSString stringWithFormat:@"%d_", [_materiasPrima[i] count]];
        info = [info stringByAppendingString:infoToAppend];
    }
    for (int i = 0; i < _maquinas.count; i++) {
        Stage *maquina = _maquinas[i];
        NSString *infoToAppend;
        infoToAppend = [NSString stringWithFormat:@"%@_", maquina.encendida ? @"1" : @"0"];
        info = [info stringByAppendingString:infoToAppend];
        infoToAppend = [NSString stringWithFormat:@"%d_", maquina.producto];
        info = [info stringByAppendingString:infoToAppend];
    }
    return info;
}

-(void)importFromString:(NSString *)receivedInfo {
    NSArray *myReceivedInfo= [receivedInfo componentsSeparatedByString:@"_"];
    _dinero = [myReceivedInfo[1] integerValue];
    _minutos = [myReceivedInfo[2] integerValue];
    _segundos = [myReceivedInfo[3] integerValue];
    for (int i = 0; i < _materiasPrima.count; i++) {
        [_materiasPrima[i] setCount:[myReceivedInfo[i+4] integerValue]];
    }
    for (int i = 0; i < _maquinas.count; i++) {
        int j = 2*i + _materiasPrima.count + 4;
        Stage *maquina = _maquinas[i];
        //NSLog([myReceivedInfo[j] stringValue]);
        maquina.encendida = ([myReceivedInfo[j] integerValue] == 1);
        maquina.producto = [myReceivedInfo[j+1] integerValue];
    }
}


@end
