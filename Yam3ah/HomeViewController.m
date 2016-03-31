//
//  HomeViewController.m
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTVCell.h"
#import "WebCommunicationClass.h"
#import "Config.h"
#import "LetterProgressView.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize arrLatestProduct,arrItemsList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [LetterProgressView showHUDAddedTo:[App_Delegate window] animated:YES];

    WebCommunicationClass *obj_WebCommunicationClass=[[WebCommunicationClass alloc] init];
    [obj_WebCommunicationClass setACaller:self];
    [obj_WebCommunicationClass getLatestProductList:[NSString stringWithFormat:@"%d",self.page_number]];
    self.tableView = productTblView;
    self.canLoadMore = YES;
    isLoadingMore = NO;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableFooterView" owner:self options:nil];
    TableFooterView *footerView = (TableFooterView *)[nib objectAtIndex:0];
    self.footerView = footerView;
    txtFSearch.showsCancelButton = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    UITextField *textField = [txtFSearch valueForKey:@"_searchField"];
    textField.clearButtonMode = UITextFieldViewModeNever;

    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setBackgroundColor:[UIColor colorWithRed:67.0/255 green:191.0/255 blue:181.0/255 alpha:1.0f]];
  [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
  [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
    
    
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                  [UIColor colorWithRed:67.0/255 green:191.0/255 blue:181.0/255 alpha:1.0f],
                                                                                                  UITextAttributeTextColor,
                                                                                                  [UIColor whiteColor],
                                                                                                  UITextAttributeTextShadowColor,
                                                                                                  [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
                                                                                                  UITextAttributeTextShadowOffset,
                                                                                                  nil]
                                                                                        forState:UIControlStateNormal];
    
    
//    self.page_number = 0;
//    [self loadMore];
   
    
    
    
    
    
//    scrlViewProduct.contentSize = CGSizeMake([UIScreen mainScreen].applicationFrame.size.width * arr.count, imgScrollView.frame.size.height);
}

- (void)getAllItemsWithPage:(NSMutableArray*)arr
{
    shouldShowFooter = NO;
    [productTblView reloadData];
    WebCommunicationClass *obj_WebCommunicationClass=[[WebCommunicationClass alloc] init];
    [obj_WebCommunicationClass setACaller:self];
    [obj_WebCommunicationClass getLatestProductList:[NSString stringWithFormat:@"%d",self.arrItemsList.count]];
    
    
   /* for (UIView *v in scrlViewProduct.subviews)
    {
        if ([v isKindOfClass:[EGOImageView class]] || [v isKindOfClass:[UIButton class]])
        {
            [v removeFromSuperview];
        }
    }
    
    
    scrlViewProduct = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0, 120, 320.0, 399.0)];
    // scrlViewProduct.delegate = self;
    // scrlViewProduct.contentSize = CGSizeMake(320.0, 840.0);
    scrlViewProduct.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrlViewProduct];
    
    float horizontal = 4.0;
    float vertical = 4.0;
    for (int i = 0; i < arr.count; i++)
    {
        if((i%3) == 0 && i!=0)
        {
            horizontal = 4.0;
            vertical = vertical + 101.0 + 4.0;
//            [scrlViewProduct setFrame:CGRectMake(scrlViewProduct.frame.origin.x, scrlViewProduct.frame.origin.y, scrlViewProduct.frame.size.width, scrlViewProduct.frame.size.height+vertical)];
        }
        UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(horizontal, vertical, 101, 101)];
       // [imgView setShowActivity:YES];
        backgroundQueue = dispatch_queue_create("com.razeware.imagegrabber.bgqueue", NULL);
           
        dispatch_async(backgroundQueue, ^(void)
        {
            [imgView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"feature_image_thumb"]]]]];
            //
            //[imgView setImageURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"feature_image_thumb"]]];
        });
        
       // [imgView setImageURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"feature_image_thumb"]]];
//        imgView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
//                                    UIViewAutoresizingFlexibleLeftMargin |
//                                    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleRightMargin);
//        imgView.userInteractionEnabled = TRUE;
        [scrlViewProduct addSubview:imgView];
        
        
        UIButton *buttonImage = [UIButton buttonWithType:UIButtonTypeCustom];
       [buttonImage setFrame:CGRectMake(horizontal, vertical, 101.0, 101.0)];
       [buttonImage setTag:i];
        [buttonImage addTarget:self action:@selector(getButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrlViewProduct addSubview:buttonImage];
        horizontal = horizontal + 101.0 + 4.0;
    }
    NSLog(@"vertical=%f",vertical);
    [scrlViewProduct setContentSize:CGSizeMake(320.0, vertical+101.0+200)];*/
}

-(void)getButton:(UIButton*)sender
{
     ProductDetailViewController *obj = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
      obj.dictProductDetail = [self.arrLatestProduct objectAtIndex:[sender tag]];
     [self.navigationController pushViewController:obj animated:YES];
}

-(void)FetchData
{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Load More

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// The method -loadMore was called and will begin fetching data for the next page (more).
// Do custom handling of -footerView if you need to.
//

/*
- (void) willBeginLoadingMore
{
    TableFooterView *fv = (TableFooterView *)self.footerView;
    [fv.activityIndicator startAnimating];
}*/

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Do UI handling after the "load more" process was completed. In this example, -footerView will
// show a "No more items to load" text.
//

- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    TableFooterView *fv = (TableFooterView *)self.footerView;
//    [fv.activityIndicator stopAnimating];
    
    if (!self.canLoadMore) {
        // Do something if there are no more items to load
        
        // We can hide the footerView by: [self setFooterViewVisibility:NO];
        
        // Just show a textual info that there are no more items to load
        fv.infoLabel.hidden = NO;
        fv.hidden=YES;
        self.footerView = nil;
    }
    else
    {
        self.tableView = productTblView;
        self.canLoadMore = YES;
        isLoadingMore = NO;
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableFooterView" owner:self options:nil];
        TableFooterView *footerView = (TableFooterView *)[nib objectAtIndex:0];
        self.footerView = footerView;
        txtFSearch.showsCancelButton = NO;
        fv.infoLabel.hidden = YES;
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    // Do your async loading here
    [self performSelector:@selector(getAllItemsWithPage:) withObject:nil afterDelay:0.0];
    // See -addItemsOnBottom for more info on what to do after loading more items
    return YES;
}


- (void)canLoadMoreData:(NSInteger)count
{
    if (count < 15)
    {
        //        if ([txtfSearch isFirstResponder]) {
        //            [txtfSearch resignFirstResponder];
        //        }
        self.canLoadMore = NO;
    }// signal that there won't be any more items to load
    else
    {
        self.canLoadMore = YES;
    }
    
    // Inform STableViewController that we have finished loading more items
    [self loadMoreCompleted];
}


#pragma mark - UITableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrItemsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    CellIdentifier= @"HomeTVCell";
    HomeTVCell* cell;
    cell = (HomeTVCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSString *nibNameOrNil= @"HomeTVCell";
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[HomeTVCell class]])
            {
                cell = (HomeTVCell*)currentObject;
                break;
            }
        }
    }
    [cell.viewImages setTag:indexPath.row];
    [cell updatetableViewCell:[self.arrItemsList objectAtIndex:indexPath.row] target:self];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    ProductDetailViewController *obj = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
//    obj.dictProductDetail = [self.arrLatestProduct objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:obj animated:YES];
}
- (void)btnProductTapped:(UIButton *)sender
{
    NSInteger indexRow = [[sender superview] tag];
    NSArray *arrRowItems = [NSArray arrayWithArray:[self.arrItemsList objectAtIndex:indexRow]];
    ProductDetailViewController *obj = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    obj.dictProductDetail = [arrRowItems objectAtIndex:sender.tag-1];
    [self.navigationController pushViewController:obj animated:YES];
}

-(IBAction)catagoriesBtnPressed:(id)sender
{
    CategoriesController *obj = [[CategoriesController alloc] initWithNibName:@"CategoriesController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}

#pragma mark - UITextField Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range dsf:(NSString *)text
{
    NSString *resultingString = [searchBar.text stringByAppendingString: text];
    
    if  ([resultingString stringByTrimmingCharactersInSet:whiteCharacterSet].length)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchProducts];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    searchBar.text = nil;
    searchBar.showsCancelButton = NO;
    [self searchProducts];
    [searchBar resignFirstResponder];
}

-(void)searchProducts
{
    [self.arrItemsList removeAllObjects];
    
    [LetterProgressView showHUDAddedTo:[App_Delegate window] animated:YES];
    WebCommunicationClass *obj_WebCommunicationClass=[[WebCommunicationClass alloc] init];
    [obj_WebCommunicationClass setACaller:self];
    [obj_WebCommunicationClass getSearchProductList:txtFSearch.text offset:[NSString stringWithFormat:@"%d",self.page_number]];
}


#pragma -mark server method
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    [LetterProgressView DismissFromView:[App_Delegate window]];
    NSString *aStrResult=[[NSString alloc] initWithData:[aReq responseData] encoding:NSUTF8StringEncoding];
    NSLog(@"aStrResult=%@",aStrResult);
    if([MethoodName caseInsensitiveCompare:kGetLatestProductlist]==0)
    {
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue])
        {
            if(!self.arrItemsList)
                self.arrItemsList=[NSMutableArray array];
            
            NSMutableArray *arrProducts = [NSMutableArray arrayWithArray:[aResultDictionery objectForKey:@"responseData"]];
            
            NSMutableArray *arrRow = [NSMutableArray array];
            int count = 0;
            for (NSInteger i = 0; i < arrProducts.count ;i++)
            {
                NSDictionary *aDict = [arrProducts objectAtIndex:i];
                [arrRow addObject:aDict];
                count+=1;
                if (count == 3 || arrProducts.count == i+1)
                {
                    [self.arrItemsList addObject:arrRow];
                    arrRow = [NSMutableArray array];
                    count = 0;
                }
            }
            [self canLoadMoreData:arrProducts.count];
            [productTblView reloadData];
        }
        else
        {
            [self canLoadMoreData:0];
             [productTblView reloadData];
             [self canLoadMoreData:0];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[[aResultDictionery objectForKey:@"status"]valueForKey:@"status_message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alertView show];
        }
    }
    else if([MethoodName caseInsensitiveCompare:kGetSearchProduct]==0)
    {
        txtFSearch.text = nil;
        txtFSearch.showsCancelButton = NO;
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue])
        {
            if(!self.arrItemsList)
                self.arrItemsList=[NSMutableArray array];
            
            NSMutableArray *arrProducts = [NSMutableArray arrayWithArray:[aResultDictionery objectForKey:@"responseData"]];
            
            NSMutableArray *arrRow = [NSMutableArray array];
            int count = 0;
            for (NSInteger i = 0; i < arrProducts.count ;i++)
            {
                NSDictionary *aDict = [arrProducts objectAtIndex:i];
                [arrRow addObject:aDict];
                count+=1;
                if (count == 3 || arrProducts.count == i+1)
                {
                    [self.arrItemsList addObject:arrRow];
                    arrRow = [NSMutableArray array];
                    count = 0;
                }
            }
            [self canLoadMoreData:arrProducts.count];
            [productTblView reloadData];
        }
        else
        {
            [productTblView reloadData];
            [self canLoadMoreData:0];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[[aResultDictionery objectForKey:@"status"]valueForKey:@"status_message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

-(void) dataDownloadFail:(ASIHTTPRequest*)aReq  withMethood:(NSString *)MethoodName
{
    [LetterProgressView DismissFromView:[App_Delegate window]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
