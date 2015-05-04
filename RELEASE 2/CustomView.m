//
//  CustomView.m
//  DibujarProceso
//
//  Created by alumno on 15/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "CustomView.h"
#import "Stage.h"
#import "MateriaPrima.h"

@implementation CustomView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef contexto = UIGraphicsGetCurrentContext();

    CGFloat width = self.frame.size.width/17;
    CGFloat height = self.frame.size.height/23;
    UIFont *font = [UIFont systemFontOfSize:(height*3/4)];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];

    
    [self drawConecciones:contexto width:width height:height];
    [self drawMateriaPrima:contexto withDict:dict width:width height:height];
    [self drawMaquinas:contexto withDict:dict width:width height:height];
    [self drawIdMaquinas:contexto width:width height:height];
    [self drawInformacion:contexto width:width height:height];
}

- (void)drawConecciones:(CGContextRef)contexto width:(NSInteger)width height:(NSInteger)height {
    CGContextSetLineWidth(contexto, 1.0);
    NSMutableArray *countDestino = [[NSMutableArray alloc] init];
    for (int i = 0; i < _process.maquinas.count; i++) {
        [countDestino addObject:@(0)];
    }
    for (int i = 0; i < _process.conecciones.count; i++) {
        NSMutableArray *destinos = _process.conecciones[i];
        Stage *origen = _process.maquinas[i];
        NSInteger inicioX, inicioY, primeraVueltaX, primeraVueltaY, segundaVueltaX, segundaVueltaY, finX, finY;
        NSInteger relXorigen, relYorigen, relXdestino, relYdestino;
        relXorigen = 2*(origen.col+1)*width;
        relYorigen = (20 - 2*origen.row)*height;
        for (int j = 0; j < destinos.count; j++) {
            NSInteger numMaquina = [destinos[j] integerValue];
            Stage *destino = _process.maquinas[numMaquina];
            NSInteger indexDestino = [countDestino[numMaquina] integerValue] + 1;
            countDestino[numMaquina] = @(indexDestino);
            
            relXdestino = 2*(destino.col+1)*width;
            relYdestino = (20 - 2*destino.row)*height - height + 1;
            inicioY = relYorigen + height;
            inicioX = relXorigen + width*(j+1)/(destinos.count+1);
            primeraVueltaX = inicioX;
            primeraVueltaY = (relYdestino + inicioY)/2;
            segundaVueltaX = relXdestino + width*indexDestino/([_process.numDestino[numMaquina] integerValue] + 1);
            segundaVueltaY = primeraVueltaY;
            finX = segundaVueltaX;
            finY = relYdestino;
            CGContextMoveToPoint(contexto, inicioX, inicioY);
            CGContextAddLineToPoint(contexto, primeraVueltaX, primeraVueltaY);
            CGContextAddLineToPoint(contexto, segundaVueltaX, segundaVueltaY);
            CGContextAddLineToPoint(contexto, finX, finY);
            CGContextSetStrokeColorWithColor(contexto, [self colorEnIndice:origen.type].CGColor);
            CGContextStrokePath(contexto);
        }
    }
}

- (void)drawMateriaPrima:(CGContextRef)contexto withDict:(NSDictionary *)dict width:(NSInteger)width height:(NSInteger)height{
    for (int i = 0; i < _process.materiasPrima.count; i++) {
        MateriaPrima *mp = _process.materiasPrima[i];
        NSInteger relX, relY;
        relX = 2*(mp.posicion+1)*width;
        relY = 21*height;
        CGRect theRect = CGRectMake(relX, relY, width, height);
        CGContextSetFillColorWithColor(contexto, [UIColor lightGrayColor].CGColor);
        CGContextFillRect(contexto, theRect);
        
        NSString *cantidad = [NSString stringWithFormat:@" %d", mp.count];
        [cantidad drawInRect:theRect withAttributes:dict];
    }
}

- (void)drawMaquinas:(CGContextRef)contexto withDict:(NSDictionary *)dict width:(NSInteger)width height:(NSInteger)height{
    CGContextSetLineWidth(contexto, 3);
    for (int i = 0; i < _process.maquinas.count; i++) {
        Stage *stage = _process.maquinas[i];
        NSInteger relX, relY;
        relX = 2*(stage.col+1)*width;
        relY = (20 - 2*stage.row)*height;
        CGRect theRect = CGRectMake(relX, relY, width, height);
        CGContextSetFillColorWithColor(contexto, [self colorEnIndice:stage.type].CGColor);
        CGContextFillRect(contexto, theRect);
        CGRect theRect2 = CGRectMake(relX, relY-height, width, height);
        CGContextSetFillColorWithColor(contexto, [UIColor lightGrayColor].CGColor);
        CGContextFillRect(contexto, theRect2);
        
        if (stage.encendida) {
            CGRect theRect3 = CGRectMake(relX, relY-height, width, 2*height);
            CGContextSetStrokeColorWithColor(contexto, [UIColor yellowColor].CGColor);
            CGContextStrokeRect(contexto, theRect3);
        }
        
        NSString *tiempo, *producto;
        //tiempo = [@(stage.tiempoDeEspera) stringValue];
        //producto = [@(stage.producto) stringValue];
        tiempo = [NSString stringWithFormat:@" %d", stage.tiempoDeEspera];
        producto = [NSString stringWithFormat:@" %d", stage.producto];
        [tiempo drawInRect:theRect withAttributes:dict];
        if (stage.encendida || ![producto isEqualToString:@"0"]) {
            [producto drawInRect:theRect2 withAttributes:dict];
        }
        
    }
}

- (void)drawIdMaquinas:(CGContextRef)contexto width:(NSInteger)width height:(NSInteger)height {
    UIFont *font = [UIFont systemFontOfSize:(height*5/8)]; // change to white text
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    for (int i = 0; i < _process.maquinas.count; i++) {
        Stage *stage = _process.maquinas[i];
        NSInteger relX, relY;
        relX = 2*(stage.col+1)*width;
        relY = (20 - 2*stage.row)*height;
        if (stage.mostrarId) {
            CGRect theRect = CGRectMake(relX + width, relY, width, height*3/4);
            NSString *idMaquina = [@(i) stringValue];
            [idMaquina drawInRect:theRect withAttributes:dict];
        }
    }
}

- (void)drawInformacion:(CGContextRef)contexto width:(NSInteger)width height:(NSInteger)height {
    UIFont *font = [UIFont systemFontOfSize:(height*3/2)];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, style, NSParagraphStyleAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    CGRect rectTiempo = CGRectMake(4*width, height/2, width*4, height*2);
    CGRect rectDinero = CGRectMake(10*width, height/2, width*4, height*2);
    NSString *tiempo = [NSString stringWithFormat:@"%d:%02d", _process.minutos, _process.segundos];
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *dinero = [NSString stringWithFormat:@"$%@", [formatter stringFromNumber:[NSNumber numberWithInteger:_process.dinero]]];
    [tiempo drawInRect:rectTiempo withAttributes:dict];
    [dinero drawInRect:rectDinero withAttributes:dict];
}

- (UIColor *)colorEnIndice:(NSInteger)ind {
    NSArray *colores = [[NSArray alloc] initWithObjects:[UIColor brownColor], [UIColor magentaColor], [UIColor redColor], [UIColor blueColor], [UIColor orangeColor], [UIColor greenColor], nil];
    return (UIColor *)colores[ind];
}

@end
