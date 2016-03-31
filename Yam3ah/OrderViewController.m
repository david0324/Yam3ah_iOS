//
//  OrderViewController.m
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "OrderViewController.h"
#import "WebCommunicationClass.h"
#import "ThankyouViewController.h"
#import "Config.h"
#import "Global.h"
#import "CartItemData.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "LetterProgressView.h"

@interface OrderViewController ()
{
    NSString *paymentUrl;
}

@end

@implementation OrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   //  GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    
  
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    CGFloat itemPrice = 0.0;
    
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    
    for (CartItemData *aItem in GDP.arrCartItems)
    {
        itemPrice = itemPrice + ([aItem.qty integerValue] * [aItem.price floatValue]);
        
    }
    
    paymentUrl = @"https://www.yam3ah.com/knet_pay/";
    NSString *fullURL = [NSString stringWithFormat:@"%@buy.php?amount=%f",paymentUrl,itemPrice];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [uipaymentview loadRequest:requestObj];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request);
   // NSLog(@"%d",navigationType);
    
    NSString *url = [NSString stringWithFormat:@"%@",[request URL]];
 //   NSMutableArray *allpaymentdata;
    NSMutableDictionary *dictdata = [NSMutableDictionary dictionary];
    
    if (navigationType == 5)
    {
        if ([url rangeOfString:@"result.php"].location != NSNotFound)
        {
            NSArray *arr = [url componentsSeparatedByString:@"?"];
            if (arr.count > 0)
            {
                if ([arr objectAtIndex:1])
                {
                  //  [MBProgressHUD showHUDAddedTo:[AppDelegate sharedDelegate].window animated:YES];
                     [LetterProgressView showHUDAddedTo:[App_Delegate window] animated:YES];

                    NSArray *arrMy = [[arr objectAtIndex:1]componentsSeparatedByString:@"&"];
                    NSLog(@"%@",arrMy);
                    NSLog(@"Kapil");
                    for (int i =0 ; i < arrMy.count; i++)
                    {
                        NSArray *arrValues = [[arrMy objectAtIndex:i] componentsSeparatedByString:@"="];
                        if ([[arrValues objectAtIndex:0]isEqualToString:@"PaymentID"] || [[arrValues objectAtIndex:0]isEqualToString:@"Result"] || [[arrValues objectAtIndex:0]isEqualToString:@"TranID"] || [[arrValues objectAtIndex:0]isEqualToString:@"Ref"])
                        {
                            [dictdata setObject:[arrValues objectAtIndex:1] forKey:[arrValues objectAtIndex:0]];
                        }
                        
                        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                        [dict setObject:[arrValues objectAtIndex:1] forKey:[arrValues objectAtIndex:1]];
                       // [allpaymentdata addObject:dict];
                    }
                    
                }
                if ([[dictdata valueForKey:@"Result"]isEqualToString:@"CAPTURED"]) {
                    
                    
                    
                    NSString *reqURL = [NSString stringWithFormat:@"%@%@%@",paymentUrl,@"response_handle.php?",[arr objectAtIndex:1]];
                    NSURL *url = [NSURL URLWithString:reqURL];
                    
                    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                    [uipaymentview loadRequest:requestObj];
                    
                    [self performSelector:@selector(submitOrder:) withObject:dictdata afterDelay:1.0];
                    return YES;
                }
                else if ([[dictdata valueForKey:@"Result"]isEqualToString:@"NOT CAPTURED"])
                {
                    NSString *reqURL = [NSString stringWithFormat:@"%@%@%@",paymentUrl,@"esponse_handle.php?",[arr objectAtIndex:1]];
                    NSURL *url = [NSURL URLWithString:reqURL];
                    
                    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                    [uipaymentview loadRequest:requestObj];

                    return YES;
                }
            }
            return  NO;
        }
        else if([url rangeOfString:@"error.php"].location != NSNotFound)
        {
            NSArray *arr = [url componentsSeparatedByString:@"?"];
            
              // [LetterProgressView DismissFromView:[App_Delegate window]];
            NSLog(@"Error PHP");
            
             //[_delegate closeTapped];
            
            NSLog(@"self=%@",[self description]);

//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Notice !" message:@"Please try again your transaction get failed " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"", nil];
//            [alert show];
           // [uipa stopLoading];
           // [self.navigationController popViewControllerAnimated:NO];
            
            NSString *reqURL = [NSString stringWithFormat:@"%@%@%@",paymentUrl,@"response_handle.php?",[arr objectAtIndex:1]];
            NSURL *url = [NSURL URLWithString:reqURL];
            
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            [uipaymentview loadRequest:requestObj];

            return YES;
        }
    }
    
    return  YES;
    
}


-(void)submitOrder:(NSMutableDictionary*)dictdata
{
    [self.dictOrderdata setObject:[dictdata objectForKey:@"PaymentID"] forKey:@"payment_id"];
    [self.dictOrderdata setObject:[dictdata objectForKey:@"TranID"] forKey:@"payment_transaction_id"];
    [self.dictOrderdata setObject:[dictdata objectForKey:@"Ref"] forKey:@"reference_id"];
    [self.dictOrderdata setObject:@"1" forKey:@"is_payment_success"];

    WebCommunicationClass *aCommunication = [[WebCommunicationClass alloc] init];
    [aCommunication setACaller:self];
    [aCommunication save_order:self.dictOrderdata];
    
}

#pragma mark  - webViewDelegates
- (void)webViewDidStartLoad:(UIWebView *)webView{
   // [MBProgressHUD showHUDAddedTo:[AppDelegate sharedDelegate].window animated:YES];
    [LetterProgressView showHUDAddedTo:[App_Delegate window] animated:YES];
    
    //[self.activityLoader startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *url = [NSString stringWithFormat:@"%@",webView.request.URL];
    
    
   
    
   // [MBProgressHUD hideAllHUDsForView:[AppDelegate sharedDelegate].window animated:YES];
  //  [LetterProgressView showHUDAddedTo:[App_Delegate window] animated:YES];
    
    [LetterProgressView DismissFromView:[App_Delegate window]];
    
     if([url rangeOfString:@"error.php"].location != NSNotFound)
    {
        NSURL *url = [NSURL URLWithString:@"http://ds211.projectstatus.co.uk/alyam3ah/knet_pay/buy.php?amount=100"];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [uipaymentview loadRequest:requestObj];
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Notice !" message:@"Please try again your transaction get failed " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"", nil];
//                   [alert show];
        
       
        
//        [[NSNotificationCenter defaultCenter]
//         postNotificationName:@"TestNotification"
//         object:self];
        
       // [self.navigationController popViewControllerAnimated:NO];
   }
    

   // [self.activityLoader stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
 //   [MBProgressHUD hideAllHUDsForView:[AppDelegate sharedDelegate].window animated:YES];
     [LetterProgressView DismissFromView:[App_Delegate window]];

    //[self.activityLoader stopAnimating];
 //[self.navigationController popViewControllerAnimated:YES];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Notice !" message:@"Please try again your transaction get failed " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"", nil];
//    [alert show];
}

//- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)fram decisionListener:(id<WebPolicyDecisionListener>)listener
//{
//    
//}

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
}

-(void) dataDownloadFail:(ASIHTTPRequest*)aReq  withMethood:(NSString *)MethoodName
{
    //[MBProgressHUD hideAllHUDsForView:[App_Delegate window] animated:YES];
    
     [LetterProgressView DismissFromView:[App_Delegate window]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
