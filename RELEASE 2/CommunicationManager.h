//
//  CommunicationManager.h
//  DibujarProceso
//
//  Created by alumno on 22/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Process.h"

@interface CommunicationManager : NSObject

@property (strong, nonatomic) Process *process;
@property BOOL admin;

-(id)initWithProcess:(Process *)process asAdmin:(BOOL)admin;

-(NSString *)getGeneralProcessStatus;
-(void)receiveInformation:(NSString *)info;
-(NSString *)endProcess;
-(NSString *)turnOnMachine:(NSInteger)numMachine;
-(NSString *)turnOffMachine:(NSInteger)numMachine;
-(NSString *)buyMaterial:(NSInteger)numMaterial quantity:(NSInteger)q;
-(void)showMachinesWithType:(NSInteger)type;
-(void)hideMachines;

@end
