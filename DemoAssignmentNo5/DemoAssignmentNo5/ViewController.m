//
//  ViewController.m
//  DemoAssignmentNo5
//
//  Created by Shailendra Kumar on 12/04/16.
//  Copyright © 2016 Appideas Sofware Solutions. All rights reserved.
//

#import "ViewController.h"
#import "UserLIstTableViewCell.h"
@interface ViewController ()
{
    NSMutableArray *arrJsonData;
    NSMutableArray *arrsortingData;
    NSArray * arrSortedData;
    NSString * strSortedUserId;
    NSString * strUserId;
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end


#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
float companyLati = 30.660387;  //office lati
float companyLongi = 76.860572;  //office longi

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrJsonData = [NSMutableArray array];
    arrsortingData = [NSMutableArray array];
    
    //load data
    [self parseJson];
    
}
-(void)parseJson
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"customers" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //parsing data
    arrJsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    if(arrJsonData.count > 0)
    {
        for (int indexCheck = 0; indexCheck < arrJsonData.count; indexCheck++)
        {
            NSString  *customerLati = [[arrJsonData valueForKey:@"latitude"]objectAtIndex:indexCheck];
            NSString  *customerLongi = [[arrJsonData valueForKey:@"longitude"]objectAtIndex:indexCheck];
            
            
            //calculate distance
            float idCustomerDistance= [self calculateDistance:companyLati lng:companyLongi lat:[customerLati floatValue] longi:[customerLongi floatValue] ];
            NSLog(@"%f",idCustomerDistance);
            
            if(idCustomerDistance < 100)
            {
                //add customer within 100 KM from your office
                NSString  *customerid = [[arrJsonData valueForKey:@"user_id"]objectAtIndex:indexCheck];
                [arrsortingData addObject:customerid];
                NSLog(@"%@",customerid);
                
            }
            
        }
    }
    
    if(arrsortingData.count > 0)
    {
        //customer list sorted
        arrSortedData = [self sort];
        if(arrSortedData.count > 0)
        {
            //list show in tableView
            [self.tableView reloadData];
        }
        
    }
}


-(float)calculateDistance:(float) lat1 lng:(float)lng1 lat:(float)lat2 longi:(float)lng2
{
    
    float longi1 = DEGREES_TO_RADIANS(lng1);//office longi
    float lati1 = DEGREES_TO_RADIANS(lat1); //office lati
    float longi2 = DEGREES_TO_RADIANS(lng2); //customer longi
    float lati2 = DEGREES_TO_RADIANS(lat2);//customer lati
    
    float distance = acos(sin(lati1) * sin(lati2) + cos(lati1) * cos(lati2) * cos(longi1 - longi2));
    // earth's radius in km = 6371
    
    return 6371 * distance;
    
}
-(NSArray *)sort
{
    //sorted
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
    return [arrsortingData sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortOrder]];
}

////tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrSortedData.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    
    UserLIstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UserLIstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:MyIdentifier];
    }
    
    
    //show id and name on table view
    
    for(int checkI = 0 ; checkI < arrJsonData.count ; checkI++)
    {
        strSortedUserId = [NSString stringWithFormat:@"%@",[arrSortedData objectAtIndex:indexPath.row] ];
        strUserId = [NSString stringWithFormat:@"%@",[[arrJsonData valueForKey:@"user_id"] objectAtIndex:checkI] ];
        
        if( [strSortedUserId isEqualToString:strUserId])
        {
            cell.lblCustomerId.text = strUserId;
            cell.lblCustomerName.text = [[arrJsonData valueForKey:@"customer_name"] objectAtIndex:checkI];
            break;
        }
    }
    
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
