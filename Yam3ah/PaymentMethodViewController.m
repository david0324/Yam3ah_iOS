//
//  PaymentMethodViewController.m
//  Yam3ah
//
//  Created by sudhanshupareek on 12/05/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "PaymentMethodViewController.h"
#import "OrderViewController.h"
#import "WebCommunicationClass.h"
#import "GlobalDataPersistence.h"
#import "LetterProgressView.h"
#import "Config.h"
#import "AppDelegate.h"
#import "ThankyouViewController.h"


@interface PaymentMethodViewController ()

@end

@implementation PaymentMethodViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Metods
- (IBAction)btnPaymentClick:(id)sender
{
    btnsender = sender;
    [LetterProgressView showHUDAddedTo:[App_Delegate window] animated:YES];
    WebCommunicationClass *aCommunication = [[WebCommunicationClass alloc] init];
    [aCommunication setACaller:self];
    [aCommunication checkOrderAvailablity:self.dictOrderdata];
}

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Server Metods
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    //  [MBProgressHUD hideAllHUDsForView:[AppDelegate sharedDelegate].window animated:YES];
    [LetterProgressView DismissFromView:[App_Delegate window]];
    NSString *aStrResult=[[NSString alloc] initWithData:[aReq responseData] encoding:NSUTF8StringEncoding];
    NSLog(@"aStrResult=%@",aStrResult);
    if([MethoodName caseInsensitiveCompare:kSaveOrder]==0)
    {
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue])
        {
            
            GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
            [GDP.arrCartItems removeAllObjects];
            GDP = nil;
            [AppDelegate sharedDelegate].boolCartEmpty = TRUE;
            [AppDelegate sharedDelegate].boolController = TRUE;
            [AppDelegate sharedDelegate].boolStockFinish = TRUE;
            ThankyouViewController *obj = [[ThankyouViewController alloc]initWithNibName:@"ThankyouViewController" bundle:nil];
            obj.strOrderId = [[aResultDictionery objectForKey:@"responseData"] objectForKey:@"order_id"];
            [self.navigationController pushViewController:obj animated:YES];
        }
        else
        {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[[aResultDictionery objectForKey:@"status"]valueForKey:@"status_message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if([MethoodName caseInsensitiveCompare:kCheckProductAvailability]==0)
    {
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue])
        {
            if (btnsender.tag == 100) {
                
                if ([self.dictOrderdata objectForKey:@"paymenttype"]) {
                    [self.dictOrderdata removeObjectForKey:@"paymenttype"];
                    [self.dictOrderdata setObject:@"COD" forKey:@"paymenttype"];
                }
                else
                {
                    [self.dictOrderdata setObject:@"COD" forKey:@"paymenttype"];
                }
                
                [LetterProgressView showHUDAddedTo:[App_Delegate window] animated:YES];
                WebCommunicationClass *aCommunication = [[WebCommunicationClass alloc] init];
                [aCommunication setACaller:self];
                [aCommunication save_order:self.dictOrderdata];
            }
            else if (btnsender.tag == 101)
            {
                if ([self.dictOrderdata objectForKey:@"paymenttype"]) {
                    [self.dictOrderdata removeObjectForKey:@"paymenttype"];
                    [self.dictOrderdata setObject:@"KNET" forKey:@"paymenttype"];
                }
                else
                {
                    [self.dictOrderdata setObject:@"KNET" forKey:@"paymenttype"];
                }
                
                OrderViewController *objorder = [[OrderViewController alloc]initWithNibName:@"OrderViewController" bundle:nil];
                objorder.dictOrderdata = self.dictOrderdata;
                [self.navigationController pushViewController:objorder animated:YES];
            }
        }
        else
        {
            [AppDelegate sharedDelegate].boolStockFinish = TRUE;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[[aResultDictionery objectForKey:@"status"]valueForKey:@"status_message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

-(void) dataDownloadFail:(ASIHTTPRequest*)aReq  withMethood:(NSString *)MethoodName
{
    //[MBProgressHUD hideAllHUDsForView:[App_Delegate window] animated:YES];
    [LetterProgressView DismissFromView:[App_Delegate window]];
}




@end
