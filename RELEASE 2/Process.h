//
//  Proceso.h
//  release 2
//
//  Created by alumno on 15/04/15.
//  Copyright (c) 2015 JuanPauloLara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Process : NSObject

@property NSMutableArray *maquinas;
@property NSMutableArray *conecciones;
@property NSMutableArray *numDestino;
@property NSMutableArray *materiasPrima;

-(id)init;
-(id)initDemo;
-(void)procesar;
-(void)comprarMateriaPrima:(NSInteger)index cantidad:(NSInteger)cantidad;
-(void)encenderMaquina:(NSInteger)index;
-(void)apagarMaquina:(NSInteger)index;
-(NSString *)exportToString;
-(void)importFromString:(NSString *)receivedInfo;

@end
