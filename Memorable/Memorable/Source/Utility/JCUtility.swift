//
//  JCUtility.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import Foundation
import UIKit

///基准是iPhone6p
func getScaleValue(value: CGFloat) -> CGFloat{
    return value * (screenHeight/iphone6Height)
}

func isIphone4() -> Bool{
    return screenHeight == iphone4Height
}

func isIphone5() -> Bool{
    return screenHeight == iphone5Height
}

func isIphone6() -> Bool{
    return screenHeight == iphone6Height
}

func isIphone6p() -> Bool{
    return screenHeight == iphone6pHeight
}

func ImageWithColor (color:UIColor, bounds:CGRect) -> UIImage? {
    let rect:CGRect = bounds;
    UIGraphicsBeginImageContext(rect.size);
    let context:CGContextRef? = UIGraphicsGetCurrentContext()
    
    if let context1 = context {
        CGContextSetFillColorWithColor(context1, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image
    }
    
    return nil
}


