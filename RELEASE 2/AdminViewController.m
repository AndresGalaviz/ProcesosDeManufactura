//
//  AdminViewController.m
//  release 2
//
//  Created by alumno on 4/20/15.
//  Copyright (c) 2015 JuanPauloLara. All rights reserved.
//

#import "AdminViewController.h"
#import "AppDelegate.h"
@interface AdminViewController () {
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

@implementation AdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_vista setProcess:[[Process alloc] initDemo]];
    [_vista setNeedsDisplay];
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"VerResultados"]) {
        
//        NSDictionary *toResults = [[NSDictionary alloc] initWithObjectsAndKeys:[@(100000) stringValue],@"presupuestoInicial",[@(machine1[1]) stringValue], @"presupuestoFinal",[@(7) stringValue],@"participantes",[@(machine7[8] + machine7[9] + machine7[10]) stringValue],@"productosProcesados",tiempo,@"tiempoTotal", nil];
//        [[segue destinationViewController] setDatos:toResults];
        
    }
}



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

@end
