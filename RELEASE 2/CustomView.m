//
//  CustomView.m
//  DibujarProceso
//
//  Created by alumno on 15/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "CustomView.h"
#import "Stage.h"

@implementation CustomView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    CGContextRef contexto = UIGraphicsGetCurrentContext();
    CGFloat width = self.frame.size.width/20;
    CGFloat height = self.frame.size.height/20;
    
    NSString *titulo = @"Manufactura";
    UIFont *font = [UIFont systemFontOfSize:(1.5*height)];
    UIFont *font2 = [UIFont systemFontOfSize:(height*3/4)];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:font2, NSFontAttributeName, nil];
    [titulo drawAtPoint:CGPointMake(13*width, 4*height) withAttributes:dict];
    
    NSMutableArray *countDestino = [[NSMutableArray alloc] init];
    
    CGContextSetLineWidth(contexto, 3);
    
    for (int i = 0; i < _process.maquinas.count; i++) {
        Stage *stage = _process.maquinas[i];
        NSInteger relX, relY;
        relX = 2*stage.col*width;
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
        
        
        NSString *entrada, *salida;
        entrada = @(stage.entrada).stringValue;
        salida = @(stage.salida).stringValue;
        if (![entrada isEqualToString:@"0"]) {
            //[entrada drawAtPoint:CGPointMake(relX, relY) withAttributes:dict2];
            entrada = [[NSString alloc] initWithFormat:@" %@", entrada];
            [entrada drawInRect:theRect withAttributes:dict2];
        }
        if (![salida isEqualToString:@"0"]) {
            //[salida drawAtPoint:CGPointMake(relX, relY - height) withAttributes:dict2];
            [salida drawInRect:theRect2 withAttributes:dict2];
        }
        
        [countDestino addObject:@(0)];
    }
    CGContextSetLineWidth(contexto, 1.0);
    CGContextSetStrokeColorWithColor(contexto, [UIColor blackColor].CGColor);
    
    
    for (int i = 0; i < _process.conecciones.count; i++) {
        NSMutableArray *destinos = _process.conecciones[i];
        Stage *origen = _process.maquinas[i];
        NSInteger inicioX, inicioY, primeraVueltaX, primeraVueltaY, segundaVueltaX, segundaVueltaY, finX, finY;
        NSInteger relXorigen, relYorigen, relXdestino, relYdestino;
        relXorigen = 2*origen.col*width;
        relYorigen = (20 - 2*origen.row)*height;
        for (int j = 0; j < destinos.count; j++) {
            NSInteger numMaquina = [destinos[j] integerValue];
            Stage *destino = _process.maquinas[numMaquina];
            NSInteger indexDestino = [countDestino[numMaquina] integerValue] + 1;
            countDestino[numMaquina] = @(indexDestino);
            
            relXdestino = 2*destino.col*width;
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
            CGContextStrokePath(contexto);
        }
    }
}

- (UIColor *)colorEnIndice:(NSInteger)ind {
    NSArray *colores = [[NSArray alloc] initWithObjects:[UIColor brownColor], [UIColor magentaColor], [UIColor redColor], [UIColor blueColor], [UIColor orangeColor], [UIColor greenColor], nil];
    return (UIColor *)colores[ind-1];
}

@end
