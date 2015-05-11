//
//  CommunicationManager.m
//  DibujarProceso
//
//  Created by alumno on 22/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "CommunicationManager.h"
#import "Stage.h"

@implementation CommunicationManager

-(id)initWithProcess:(Process *)process asAdmin:(BOOL)admin {
    _process = process;
    _admin = admin;
    return self;
}

/*
 info[0]: sender
 info[1]: activo
 info[2]: accion
 */

-(NSString *)getGeneralProcessStatus {
    NSString *info = @"01_";
    info = [info stringByAppendingString:[_process exportToString]];
    return info;
}
-(NSString *)endProcess {
    return @"00";
}
-(NSString *)turnOnMachine:(NSInteger)numMachine {
    NSString *info = [NSString stringWithFormat:@"110_%d", numMachine];
    return info;
}
-(NSString *)turnOffMachine:(NSInteger)numMachine {
    NSString *info = [NSString stringWithFormat:@"111_%d", numMachine];
    return info;
}
-(NSString *)buyMaterial:(NSInteger)numMaterial quantity:(NSInteger)q {
    NSString *info = [NSString stringWithFormat:@"112_%d_%d", numMaterial, q];
    return info;
}
-(void)receiveInformation:(NSString *)info {
    if (_admin) {
        NSArray *myReceivedInfo= [info componentsSeparatedByString:@"_"];
        if ([info characterAtIndex:2] == '0') {
            NSInteger numMachine = [myReceivedInfo[1] integerValue];
            [_process encenderMaquina:numMachine];
        } else if ([info characterAtIndex:2] == '1') {
            NSInteger numMachine = [myReceivedInfo[1] integerValue];
            [_process apagarMaquina:numMachine];
        }  else if ([info characterAtIndex:2] == '2') {
            NSInteger numMaterial = [myReceivedInfo[1] integerValue];
            NSInteger quantity = [myReceivedInfo[2] integerValue];
            [_process comprarMateriaPrima:numMaterial cantidad:quantity];
        }
    } else if ([info characterAtIndex:0] == '0') {
        if ([info characterAtIndex:1] == '0') {
            _process.activo = NO;
        } else {
            [_process importFromString:info];
        }
    }
}
-(void)showMachinesWithType:(NSInteger)type {
    for (int i = 0; i < _process.maquinas.count; i++) {
        Stage *stage = _process.maquinas[i];
        if (stage.type == type) {
            stage.mostrarId = YES;
        }
    }
}
-(void)hideMachines {
    for (int i = 0; i < _process.maquinas.count; i++) {
        Stage *stage = _process.maquinas[i];
        stage.mostrarId = NO;
    }
}

@end
