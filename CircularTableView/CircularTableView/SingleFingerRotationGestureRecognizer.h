//
//  SingleFingerRotationGestureRecognizer.h
//  CircularTableView
//
//  Created by JJ on 7/23/16.
//  Copyright © 2016 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SingleFingerRotationGestureRecognizer : UIGestureRecognizer 


/**
 The rotation of the gesture in radians since its last change.
 */
@property (nonatomic, assign) BOOL isClockwiseRotation ;

@property (nonatomic, assign) BOOL disableClockwiseRotation ;
@property (nonatomic, assign) BOOL disableAntiClockwiseRotation ;

@property (nonatomic, assign) UITouch *touch ;

@property (nonatomic, assign) CGFloat rotationAngle ;

@property (nonatomic, assign) CGFloat totalRotationAngle ;

@end
