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

#import "MasterViewController.h"
#import "AppDelegate.h"
#import "CustomView.h"

@interface MasterViewController ()
{
    NSString *minuto;
    NSString *segundos;
    int machine1[11];
    int machine2[11];
    int machine3[11];
    int machine4[11];
    int machine5[11];
    int machine6[11];
    int machine7[11];
    
    int segundosInt;
    int minutosInt;
    UIBarButtonItem *time;
    //Inicializar precios de cada material
    int prodPrice[3];
    
    int numMachine;
}
    
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;

-(void)didReceiveDataWithNotification:(NSNotification *)notification;


@end

@implementation MasterViewController

-(void)initMachines
{
 
    for (int x =0; x<11; x++)
    {
        machine1[x] =0;
        machine2[x] =0;
        machine3[x] =0;
        machine4[x] =0;
        machine5[x] =0;
        machine6[x] =0;
        machine7[x] =0;

    }
    [self pauseAll];
    
    machine1[1] =100000;
    machine2[1] =100000;
    machine3[1] =100000;
    machine4[1] =100000;
    machine5[1] =100000;
    machine6[1] =100000;
    machine7[1] =100000;
}

-(void)decodeStringReceived:(NSString *)receivedInfo
{
    /*
     Pos0 = @"state" 1=Play; 2=Pause; 3=Stop,
     Pos1 =@"money",
     Pos2 =@"machine",
     Pos3 =@"currentMaterial" 1=Circulo; 2=Cuadrado; 3=Triangulo,
     Pos4 =@"power" 1=Off; 2=On; 3=Adjusting,
     Pos5 =@"materialInCirculo1",
     Pos6 =@"materialInCuadrado2",
     Pos7 =@"materialInTriangulo3",
     Pos8 =@"materialOutCirculo1",
     Pos9 =@"materialOutCuadrado2",
     Pos10 =@"materialOutTriangulo3",
     */
    
    
    NSArray *myReceivedInfo= [receivedInfo componentsSeparatedByString:@"_"];
    int receivedInfoInt[11];
    
    for (int x=0; x < 11; x++)
        receivedInfoInt[x] = [myReceivedInfo[x] intValue];
    
    
    switch (receivedInfoInt[2]) {
        case 1:
            for (int x =1; x<11; x++)
            {
                machine1[x] =receivedInfoInt[x];
            }
            //Actualizar los materiales de entrada de la maquina siguiente con los materiales de salida de la maquina actual
            if (machine1[8]!=0) machine2[5] = machine2[5] + 1;
            if (machine1[9]!=0) machine2[6] = machine2[6] + 1;
            if (machine1[10]!=0) machine2[7] = machine2[7] + 1;
            //Actualiza dinero de todas las maquinas
            machine2[1]=machine1[1];
            machine3[1]=machine1[1];
            machine4[1]=machine1[1];
            machine5[1]=machine1[1];
            machine6[1]=machine1[1];
            machine7[1]=machine1[1];
            break;
        case 2:
            for (int x =1; x<11; x++)
            {
                machine2[x] =receivedInfoInt[x];
            }
            //Actualizar los materiales de entrada de la maquina siguiente con los materiales de salida de la maquina actual
            if (machine2[8]!=0) machine3[5] = machine3[5] + 1;
            if (machine2[9]!=0) machine3[6] = machine3[6] + 1;
            if (machine2[10]!=0) machine3[7] = machine3[7] + 1;
            break;
        case 3:
            for (int x =1; x<11; x++)
            {
                machine3[x] =receivedInfoInt[x];
            }
            //Actualizar los materiales de entrada de la maquina siguiente con los materiales de salida de la maquina actual
            if (machine3[8]!=0) machine4[5] = machine4[5] + 1;
            if (machine3[9]!=0) machine4[6] = machine4[6] + 1;
            if (machine3[10]!=0) machine4[7] = machine4[7] + 1;
            break;
        case 4:
            for (int x =1; x<11; x++)
            {
                machine4[x] =receivedInfoInt[x];
            }
            //Actualizar los materiales de entrada de la maquina siguiente con los materiales de salida de la maquina actual
            if (machine4[8]!=0) machine5[5] = machine5[5] + 1;
            if (machine4[9]!=0) machine5[6] = machine5[6] + 1;
            if (machine4[10]!=0) machine5[7] = machine5[7] + 1;
            break;
        case 5:
            for (int x =1; x<11; x++)
            {
                machine5[x] =receivedInfoInt[x];
            }
            //Actualizar los materiales de entrada de la maquina siguiente con los materiales de salida de la maquina actual
            if (machine5[8]!=0) machine6[5] = machine6[5] + 1;
            if (machine5[9]!=0) machine6[6] = machine6[6] + 1;
            if (machine5[10]!=0) machine6[7] = machine6[7] + 1;
            break;
        case 6:
            for (int x =1; x<11; x++)
            {
                machine6[x] =receivedInfoInt[x];
            }
            //Actualizar los materiales de entrada de la maquina siguiente con los materiales de salida de la maquina actual
            if (machine6[8]!=0) machine7[5] = machine7[5] + 1;
            if (machine6[9]!=0) machine7[6] = machine7[6] + 1;
            if (machine6[10]!=0) machine7[7] = machine7[7] + 1;
            break;
        case 7:
            for (int x =1; x<11; x++)
            {
                machine7[x] =receivedInfoInt[x];
            }
            machine1[1] += (machine7[8] * prodPrice[0]) + (machine7[9] * prodPrice[1]) + (machine7[10] * prodPrice[1]);
            break;
            
            
    }
    
    machine2[1]=machine1[1];
    machine3[1]=machine1[1];
    machine4[1]=machine1[1];
    machine5[1]=machine1[1];
    machine6[1]=machine1[1];
    machine7[1]=machine1[1];
    
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //Inicializar precios de cada material
    prodPrice[0]=7000;
    prodPrice[1]=4000;
    prodPrice[2]=10000;
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    

    
    minuto = @"00";
    segundos = @"00";
    
    minutosInt = 0;
    segundosInt = 0;

    NSString *tiempo = [NSString stringWithFormat: @"%@:%@", minuto, segundos];
    UIBarButtonItem *play = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playAll)];
    
    UIBarButtonItem *pause = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(pauseAll)];
    
    time = [[UIBarButtonItem alloc]initWithTitle:tiempo
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:nil];
    
        // asi se actualiza tiempo
    time.title = @"00:00";
    
    self.navigationItem.rightBarButtonItems =
    [NSArray arrayWithObjects:pause, play, time, nil];
    
    [self initMachines];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateMachines:) userInfo:nil repeats:YES];
    
    [self createTimer];
    numMachine =0;
    self.estadosMaquinas = [[NSArray alloc] initWithObjects:@"",@"powerRed.png",@"powerGreen.png",@"powerYellow.png", nil];
    
   
}

- (NSTimer*)createTimer {
    // create timer on run loop
    return [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
    
}

- (void)timerTicked:(NSTimer*)timer {
    if (machine1[0] == 1) {
        segundosInt ++;
        
        if (segundosInt >= 60) {
            segundosInt = 0;
            minutosInt ++;
        }
        if (segundosInt <= 9)
            segundos = [NSString stringWithFormat: @"0%d", segundosInt];
        else
            segundos = [@(segundosInt) stringValue];
        if (minutosInt <= 9)
            minuto = [NSString stringWithFormat: @"0%d", minutosInt];
        else
            minuto = [@ (minutosInt) stringValue];
        
        NSString *tiempo = [NSString stringWithFormat: @"%@:%@", minuto, segundos];
        

        time.title = tiempo;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 7;
}

-(IBAction)unWindMasterController:(UIStoryboardSegue *)segue
{
    
}

-(void) playAll{
    machine1[0] =1;
    machine2[0] =1;
    machine3[0] =1;
    machine4[0] =1;
    machine5[0] =1;
    machine6[0] =1;
    machine7[0] =1;
    NSData *dataToSend;
    NSArray *allPeers = _appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    
    for (int i = 0; i < [_arrConnectedDevices count]; i++)
    {
        NSArray *arreglo = @[allPeers[i]];
        NSString *numMaquina = [NSString stringWithFormat:@"%d", i+1];
        dataToSend  = [numMaquina dataUsingEncoding:NSUTF8StringEncoding];
        [_appDelegate.mcManager.session sendData:dataToSend
                                         toPeers:arreglo
                                        withMode:MCSessionSendDataReliable
                                           error:&error];
    }
    
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    CGRect applicationFrame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height - self.navigationController.navigationBar.frame.size.height);

    
    [self.tableView removeFromSuperview];
    CustomView *contentView = [[CustomView alloc] initWithFrame:applicationFrame];
    [contentView setBackgroundColor:[UIColor blueColor]];
    [contentView setProcess:[[Process alloc] initDemo]];
    [contentView setNeedsDisplay];
    [self.navigationController.view insertSubview:contentView belowSubview:self.navigationController.navigationBar];
    
    //TODO
    
    
    
    
    

}

-(void) pauseAll {
    machine1[0]=2;
    machine2[0] =2;
    machine3[0] =2;
    machine4[0] =2;
    machine5[0] =2;
    machine6[0] =2;
    machine7[0] =2;
    
}

- (void)updateMachines:(NSTimer*)timer {

    /*
     Pos0 = @"state" 1=Play; 2=Pause; 3=Stop,
     Pos1 =@"money",
     Pos2 =@"machine",
     Pos3 =@"materialActual" 1=Circulo; 2=Cuadrado; 3=Triangulo,
     Pos4 =@"power" 1=Off; 2=On; 3=Adjusting,
     Pos5 =@"materialInCirculo1",
     Pos6 =@"materialInCuadrado2",
     Pos7 =@"materialInTriangulo3",
     Pos8 =@"materialOutCirculo1",
     Pos9 =@"materialOutCuadrado2",
     Pos10 =@"materialOutTriangulo3",
     */
    
    self.estadoMaquina1.image = [UIImage imageNamed:[self.estadosMaquinas objectAtIndex:machine1[4]]];
    self.estadoMaquina2.image = [UIImage imageNamed:[self.estadosMaquinas objectAtIndex:machine2[4]]];
    self.estadoMaquina3.image = [UIImage imageNamed:[self.estadosMaquinas objectAtIndex:machine3[4]]];
    self.estadoMaquina4.image = [UIImage imageNamed:[self.estadosMaquinas objectAtIndex:machine4[4]]];
    self.estadoMaquina5.image = [UIImage imageNamed:[self.estadosMaquinas objectAtIndex:machine5[4]]];
    self.estadoMaquina6.image = [UIImage imageNamed:[self.estadosMaquinas objectAtIndex:machine6[4]]];
    self.estadoMaquina7.image = [UIImage imageNamed:[self.estadosMaquinas objectAtIndex:machine7[4]]];
    
    [self encodeStringToSend];
}

-(void)encodeStringToSend
{
    NSString *myInfoStr;
    NSString *encodedString1= @"";
    NSString *encodedString2= @"";
    NSString *encodedString3= @"";
    NSString *encodedString4= @"";
    NSString *encodedString5= @"";
    NSString *encodedString6= @"";
    NSString *encodedString7= @"";

    for (int x=0; x < 11; x++)
    {
        myInfoStr = [NSString stringWithFormat:@"%d", machine1[x]];
        encodedString1 = [encodedString1 stringByAppendingString:myInfoStr];
        if(x!=10)
            encodedString1 = [encodedString1 stringByAppendingString:@"_"];
    }
    for (int x=0; x < 11; x++)
    {
        myInfoStr = [NSString stringWithFormat:@"%d", machine2[x]];
        encodedString2 = [encodedString2 stringByAppendingString:myInfoStr];
        if(x!=10)
            encodedString2 = [encodedString2 stringByAppendingString:@"_"];
    }

    for (int x=0; x < 11; x++)
    {
        myInfoStr = [NSString stringWithFormat:@"%d", machine3[x]];
        encodedString3 = [encodedString3 stringByAppendingString:myInfoStr];
        if(x!=10)
            encodedString3 = [encodedString3 stringByAppendingString:@"_"];
    }

    for (int x=0; x < 11; x++)
    {
        myInfoStr = [NSString stringWithFormat:@"%d", machine4[x]];
        encodedString4 = [encodedString4 stringByAppendingString:myInfoStr];
        if(x!=10)
            encodedString4 = [encodedString4 stringByAppendingString:@"_"];
    }

    for (int x=0; x < 11; x++)
    {
        myInfoStr = [NSString stringWithFormat:@"%d", machine5[x]];
        encodedString5 = [encodedString5 stringByAppendingString:myInfoStr];
        if(x!=10)
            encodedString5 = [encodedString5 stringByAppendingString:@"_"];
    }

    for (int x=0; x < 11; x++)
    {
        myInfoStr = [NSString stringWithFormat:@"%d", machine6[x]];
        encodedString6 = [encodedString6 stringByAppendingString:myInfoStr];
        if(x!=10)
            encodedString6 = [encodedString6 stringByAppendingString:@"_"];
    }

    for (int x=0; x < 11; x++)
    {
        myInfoStr = [NSString stringWithFormat:@"%d", machine7[x]];
        encodedString7 = [encodedString7 stringByAppendingString:myInfoStr];
        if(x!=10)
            encodedString7 = [encodedString7 stringByAppendingString:@"_"];
    }
    
    NSString *encodedStringFinal =@"";
    encodedStringFinal = [encodedStringFinal stringByAppendingString:encodedString1];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:@"/"];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:encodedString2];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:@"/"];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:encodedString3];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:@"/"];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:encodedString4];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:@"/"];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:encodedString5];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:@"/"];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:encodedString6];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:@"/"];
    encodedStringFinal = [encodedStringFinal stringByAppendingString:encodedString7];
    [self sendMyMessage:encodedStringFinal];
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

    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    [self decodeStringReceived:receivedText];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)stopAll:(id)sender {
    machine1[0] =3;
    machine2[0] =3;
    machine3[0] =3;
    machine4[0] =3;
    machine5[0] =3;
    machine6[0] =3;
    machine7[0] =3;
    
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self encodeStringToSend];
        [self performSegueWithIdentifier: @"VerResultados" sender: self];
    });
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *tiempo = @"";
    tiempo = [tiempo stringByAppendingString:minuto];
    tiempo = [tiempo stringByAppendingString:@":"];
    tiempo = [tiempo stringByAppendingString:segundos];
    
    if ([[segue identifier] isEqualToString:@"adminAMaquina"]) {
        
        NSDictionary *toDetail = [[NSDictionary alloc] initWithObjectsAndKeys:[@(numMachine) stringValue],@"numMachine",[@(minutosInt) stringValue], @"minutosInt",[@(segundosInt) stringValue],@"segundosInt", nil];
        [[segue destinationViewController] setDatos:toDetail];

    }
    
    if ([[segue identifier] isEqualToString:@"VerResultados"]) {
        
        NSDictionary *toResults = [[NSDictionary alloc] initWithObjectsAndKeys:[@(100000) stringValue],@"presupuestoInicial",[@(machine1[1]) stringValue], @"presupuestoFinal",[@(7) stringValue],@"participantes",[@(machine7[8] + machine7[9] + machine7[10]) stringValue],@"productosProcesados",tiempo,@"tiempoTotal", nil];
        [[segue destinationViewController] setDatos:toResults];
        
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.arrUsers[row];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.arrUsers count];
}
@end
