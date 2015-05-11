//
//  MCManager.h
//  Prototipo para simulador de procesos de manufactura
//  Juan Paulo Lara, Manuel Calzado y Andrés López De León
//
//  Fecha de creación: 10/24/14
//  Fecha de última actualización: 11/17/14
//  Descripción general: Archivo que se encarga de manejar las conexiones
//  a traves de multipeer connectivity
//
//  Copyright (c) 2014 ITESM. All rights reserved.
//
//  This file is part of "Prototipo para simulador de procesos de manufactura".
//
//  "Prototipo para simulador de procesos de manufactura" is free software:
//  you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  "Prototipo para simulador de procesos de manufactura" is distributed in
//  the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
//
// Code retrived from Gabriel Theodoropoulos tutorial
// <http://www.appcoda.com/intro-multipeer-connectivity-framework-ios-programming/>
//
//  Authors:
//
//  ITESM representatives
//  Ing. Martha Sordia Salinas  <msordia@itesm.mx>
//  Ing. Mario de la Fuente     <mario.delafuente@itesm.mx>
//
//  ITESM students
//  Juan Paulo Lara Rodríguez   <jplarar@gmail.com>
//  Manuel Calzado              <mcm_maycod@hotmail.com>
//  Andrés López De León        <agldeleon@gmail.com>
//

#import "MachineViewController.h"

@interface MachineViewController ()
{
    
}
@property NSMutableArray *arrMaterias;

@property NSInteger maquinaSeleccionada;
@end

@implementation MachineViewController

-(void) setNumMachine:(int)num {
    _numMachine = num;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];

    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    
    
    [self createTimer];
    [_vista setProcess:[[Process alloc] initDemo]];
    [_vista setNeedsDisplay];
    self.comCommunicationManager = [[CommunicationManager alloc] initWithProcess: _vista.process asAdmin: NO];
    for(int i=0; i <=5; i++) {
        [self.comCommunicationManager showMachinesWithType:i];
    }
    
    
}



-(NSString *)convertIntTimeToStringTime: (int) intTime
{
    NSString *strTime;
    if(intTime <10)
    {
        strTime=[NSString stringWithFormat:@"0%d", intTime];
    }
    else
    {
       strTime=[NSString stringWithFormat:@"%d", intTime];
    }
    return strTime;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSTimer*)createTimer {
    // create timer on run loop
    return [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
    
}

- (void)timerTicked:(NSTimer*)timer {
    [_vista setNeedsDisplay];
}




-(void)sendMyMessage:(NSString *)stringToSend
{
    NSData *dataToSend = [stringToSend dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *allPeers = self.appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    
    
    [self.appDelegate.mcManager.session sendData:dataToSend
                                         toPeers:allPeers
                                        withMode:MCSessionSendDataReliable
                                           error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}
-(void)didReceiveDataWithNotification:(NSNotification *)notification{

    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];

    [self.comCommunicationManager receiveInformation:receivedText];

    if(!_vista.process.activo) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self performSegueWithIdentifier: @"finJuego" sender: self];
            });
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    NSString *info = [self.comCommunicationManager getGeneralProcessStatus];
    NSArray *myReceivedInfo= [info componentsSeparatedByString:@"_"];
    

    NSString *tiempo = [NSString stringWithFormat:@"%@:%@", myReceivedInfo[2], myReceivedInfo[3]];
    //NSLog(info);
    if ([[segue identifier] isEqualToString:@"finJuego"]) {

        NSDictionary *toResults = [[NSDictionary alloc] initWithObjectsAndKeys:[@(self.comCommunicationManager.process.presupuestoInicial) stringValue],@"presupuestoInicial",myReceivedInfo[1], @"presupuestoFinal",tiempo,@"tiempoTotal", nil];
        [[segue destinationViewController] setDatos:toResults];
    }
}

- (IBAction)comprarMaterialUno:(id)sender {
    NSString *datos = [self.comCommunicationManager buyMaterial:0 quantity:1];
    [self sendMyMessage:datos];
}

- (IBAction)comprarMaterialDos:(id)sender {
    NSString *datos = [self.comCommunicationManager buyMaterial:1 quantity:1];
    [self sendMyMessage:datos];
}

- (IBAction)comprarMaterialTres:(id)sender {
    NSString *datos = [self.comCommunicationManager buyMaterial:2 quantity:1];
    [self sendMyMessage:datos];
}

- (IBAction)comprarMaterialCuatro:(id)sender {
    NSString *datos = [self.comCommunicationManager buyMaterial:3 quantity:1];
    [self sendMyMessage:datos];
}

- (IBAction)comprarMaterialCinco:(id)sender {
    NSString *datos = [self.comCommunicationManager buyMaterial:4 quantity:1];
    [self sendMyMessage:datos];
}

- (IBAction)encenderMaquina:(id)sender {
    NSString *datos = [self.comCommunicationManager turnOnMachine:self.maquinaSeleccionada];
    [self sendMyMessage:datos];

}

- (IBAction)apagarMaquina:(id)sender {

    NSString *datos = [self.comCommunicationManager turnOffMachine:self.maquinaSeleccionada];
    [self sendMyMessage:datos];
    
}

- (NSString *)pickerView: (UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent :(NSInteger)component {
    
    return [NSString stringWithFormat:@"Maquina %ld", (long)row];
    
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_vista.process.maquinas count];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.maquinaSeleccionada = row;
}

@end
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */