//
//  SingleFingerRotationGestureRecognizer.m
//  CircularTableView
//
//  Created by JJ on 7/23/16.
//  Copyright © 2016 JJ. All rights reserved.
//

#import "SingleFingerRotationGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

#define PI_DOUBLE  (M_PI * 2.0)
#define degreesToRadians(degrees) ( ( degrees ) / 180.0 * M_PI )
#define radiansToDegrees(radians) ( ( radians ) * ( 180.0 / M_PI ) )

@interface SingleFingerRotationGestureRecognizer()
{
    
}
@end

@implementation SingleFingerRotationGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    
    // Fail when more than 1 finger detected.
    if ([[event touchesForGestureRecognizer:self] count] > 1) {
        [self setState:UIGestureRecognizerStateFailed];
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touchesMoved");
    
    // We can look at any touch object since we know we
    // have only 1. If there were more than 1 then
    // touchesBegan:withEvent: would have failed the recognizer.
    UITouch *touch = [touches anyObject];
    
    // To rotate with one finger, we simulate a second finger.
    // The second figure is on the opposite side of the virtual
    // circle that represents the rotation gesture.
    
    UIView *view = [self view];
    CGPoint center = CGPointMake(CGRectGetMidX([view bounds]), CGRectGetMidY([view bounds]));
    CGPoint currentTouchPoint = [touch locationInView:view];
    CGPoint previousTouchPoint = [touch previousLocationInView:view];
    
    CGFloat prevAngle = atan2f(previousTouchPoint.y - center.y, previousTouchPoint.x - center.x) ;
    CGFloat currAngle = atan2f(currentTouchPoint.y - center.y, currentTouchPoint.x - center.x) ;
    
    if(currAngle < 0){
        currAngle = PI_DOUBLE + currAngle;
    }
    
    if(prevAngle < 0){
        prevAngle = PI_DOUBLE + prevAngle;
    }
    
    
    NSLog(@"Perv = %@ Curr= %@", NSStringFromCGPoint(previousTouchPoint), NSStringFromCGPoint(currentTouchPoint));
//    NSLog(@"Perv = %f Curr= %f", prevAngle , currAngle);

    CGFloat angleInRadians = currAngle - prevAngle;
    
    
    // when diff is minus but still clockwise like 358 Degree --> 2 Degree
    if( angleInRadians < -M_PI && angleInRadians > -PI_DOUBLE ){
        
        CGFloat tempCurAngle = PI_DOUBLE+currAngle;
        angleInRadians = tempCurAngle - prevAngle;
    }
    
    // when diff is positive but still anti-clockwise like 2 Degree --> 358 Degree
    if( angleInRadians > M_PI && angleInRadians < PI_DOUBLE ){
        
        CGFloat tempPrevAngle = PI_DOUBLE+prevAngle;
        angleInRadians = currAngle - tempPrevAngle;
    }
    
    
    if (angleInRadians > 0) {
        _isClockwiseRotation = YES;
    }
    else if (angleInRadians < 0)
    {
        _isClockwiseRotation = NO;
    }
    else
    {
        [self setState:UIGestureRecognizerStateFailed];
        return;
    }
    
    NSLog(@"Direction : %d", _isClockwiseRotation);

    
    _rotationAngle = angleInRadians;
    _totalRotationAngle += _rotationAngle;
    
    if ([self state] == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateBegan];
    } else {
        [self setState:UIGestureRecognizerStateChanged];
    }
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    
    // Perform final check to make sure a tap was not misinterpreted.
    if ([self state] == UIGestureRecognizerStateChanged) {
        [self setState:UIGestureRecognizerStateEnded];
    } else {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
    
    [self setState:UIGestureRecognizerStateFailed];
}


+ (CGFloat)  angleBetweenPoint : (CGPoint) aPtFrom toPoint : (CGPoint) aPtTo {
    
    // get origin point to origin by subtracting end from start
    CGPoint originPoint = CGPointMake(aPtFrom.x - aPtTo.x, aPtFrom.y - aPtTo.y);
    // get bearing in radians
    CGFloat bearingRadians = atan2f(originPoint.y, originPoint.x);
    
    return bearingRadians;
}



@end
