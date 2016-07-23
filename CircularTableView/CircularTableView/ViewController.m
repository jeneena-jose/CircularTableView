//
//  ViewController.m
//  CircularTableView
//
//  Created by JJ on 7/23/16.
//  Copyright © 2016 JJ. All rights reserved.
//

#import "ViewController.h"
#import "SingleFingerRotationGestureRecognizer.h"

#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (x * 180 / M_PI)



@interface ViewController ()
{
    UIView *squareView;
    SingleFingerRotationGestureRecognizer *rotationGestureRecognizer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    squareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    squareView.backgroundColor = [UIColor redColor];
    squareView.userInteractionEnabled = YES;
    squareView.center = self.view.center;

    [self.view addSubview:squareView];
    
    if (!rotationGestureRecognizer) {
        rotationGestureRecognizer = [[SingleFingerRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
        [squareView addGestureRecognizer:rotationGestureRecognizer];
    }
}

- (void) rotation:(SingleFingerRotationGestureRecognizer *)gesture
{
//    NSLog(@"%ld", (long)gesture.state);
    
    if (gesture.state ==UIGestureRecognizerStateBegan ) {
        [self touchesBegan:gesture.touch];
    }
    else if(gesture.state ==UIGestureRecognizerStateChanged )
    {
        [self touchesMoved:gesture.touch];
    }
    else if(gesture.state ==UIGestureRecognizerStateEnded || gesture.state ==UIGestureRecognizerStateCancelled ||  gesture.state ==UIGestureRecognizerStateFailed){
        [self touchesEnded];
    }
}


- (void)touchesBegan :(UITouch* )touch
{
//    NSLog(@"2touchesBegan");
}

- (void)touchesMoved: (UITouch* )touch
{
    [squareView setTransform:CGAffineTransformRotate([squareView transform], [rotationGestureRecognizer rotationAngle])];
    CGFloat curTransformAngle = atan2f(squareView.transform.b , squareView.transform.a);

//    NSLog(@"2touchesMoved Rotation Direction = %d Angle = %f Square = %f", rotationGestureRecognizer.isClockwiseRotation, rotationGestureRecognizer.totalRotationAngle, curTransformAngle);
}

-(void) touchesEnded
{
//    NSLog(@"2touchesEnded");
//    NSLog(@"2touchesEnded Rotation Direction = %d Angle = %f", rotationGestureRecognizer.isClockwiseRotation, rotationGestureRecognizer.totalRotationAngle);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
