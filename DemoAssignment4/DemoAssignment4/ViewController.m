//
//  ViewController.m
//  DemoAssignment4
//
//  Created by Shailendra Kumar on 12/04/16.
//  Copyright © 2016 Appideas Sofware Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *arrFlattenData;
    NSArray *nestedValues ;
}
@property (strong, nonatomic) IBOutlet UILabel *lblShowArrayData;
- (IBAction)btnActionForShowFlat:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    nestedValues = @[@[@1, @2, @[@3]], @[@4, @5, @6]];
    
    self.lblShowArrayData.text = [nestedValues componentsJoinedByString:@""];
 }


//method for show Flat array
- (IBAction)btnActionForShowFlat:(id)sender
{
    arrFlattenData = [NSMutableArray array];
    //call category method for flat array
    
    [nestedValues flattened];
    
    /////////////////////
    
    for (id object in nestedValues.flattened)
    {
        NSLog(@"%@", object);
        [arrFlattenData addObject:object];
        
    }
    //show data in UILabel
    self.lblShowArrayData.text = [arrFlattenData componentsJoinedByString:@""];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
