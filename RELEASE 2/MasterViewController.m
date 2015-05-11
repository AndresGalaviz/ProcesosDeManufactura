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
@interface MasterViewController ()
{
    NSString *minuto;
    NSString *segundos;
    Boolean isPlaying;
    
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



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //Inicializar precios de cada material

    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    

    isPlaying = NO;
    minuto = @"00";
    segundos = @"00";
    
    minutosInt = 0;
    segundosInt = 0;

    NSString *tiempo = [NSString stringWithFormat: @"%@:%@", minuto, segundos];
    UIBarButtonItem *play = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playAll)];
    
    UIBarButtonItem *pause = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(pauseAll)];
    
    
    self.navigationItem.rightBarButtonItems =
    [NSArray arrayWithObjects:pause, play, time, nil];
    
    
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateMachines:) userInfo:nil repeats:YES];
    CGRect applicationFrame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height - self.navigationController.navigationBar.frame.size.height);
    self.contentView = [[CustomView alloc] initWithFrame:applicationFrame];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:200 green:200 blue:255 alpha:0.8]];
    [self.contentView setProcess:[[Process alloc] initDemo]];
    [self.contentView setNeedsDisplay];
    

    for (int i = 0; i < self.contentView.process.materiasPrima.count; i++)
        [self.contentView.process comprarMateriaPrima:i cantidad:10];
    
    
    CommunicationManager *cm = [[CommunicationManager alloc] initWithProcess:self.contentView.process asAdmin:NO];
    for(int i=0; i <=5; i++) {
        [cm showMachinesWithType:i];
    }
    [self createTimer];
    numMachine =0;
    self.comCommunicationManager = [[CommunicationManager alloc] initWithProcess:self.contentView.process asAdmin:YES];
    self.estadosMaquinas = [[NSArray alloc] initWithObjects:@"",@"powerRed.png",@"powerGreen.png",@"powerYellow.png", nil];
    
   
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
    isPlaying = YES;
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

    
    
    [self.tableView removeFromSuperview];
    [self.navigationController.view insertSubview:self.contentView belowSubview:self.navigationController.navigationBar];
    

}


- (NSTimer*)createTimer {
    // create timer on run loop
    return [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
}

- (void)timerTicked:(NSTimer*)timer {
    if(isPlaying) {
        [self.contentView.process procesar];
        NSString *info = [self.comCommunicationManager getGeneralProcessStatus];
        [self sendMyMessage:info];
    //NSLog([_vista.process exportToString]);
    //[_vista.process importFromString:[_vista.process exportToString]];
        [self.contentView setNeedsDisplay];
    }
}

-(void) pauseAll {
    isPlaying = NO;
    
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

    NSString *data = @"00";
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self sendMyMessage:data];
        [self performSegueWithIdentifier: @"VerResultados" sender: self];
    });
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *info = [self.comCommunicationManager getGeneralProcessStatus];
    NSArray *myReceivedInfo= [info componentsSeparatedByString:@"_"];
    
    
    NSString *tiempo = [NSString stringWithFormat:@"%@:%@", myReceivedInfo[2], myReceivedInfo[3]];
    //NSLog(info);
    if ([[segue identifier] isEqualToString:@"VerResultados"]) {
        
        NSDictionary *toResults = [[NSDictionary alloc] initWithObjectsAndKeys:[@(self.comCommunicationManager.process.presupuestoInicial) stringValue],@"presupuestoInicial",myReceivedInfo[1], @"presupuestoFinal",tiempo,@"tiempoTotal", nil];
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
