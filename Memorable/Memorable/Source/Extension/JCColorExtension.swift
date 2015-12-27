//
//  JCColorExtension.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/26.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit
public extension UIColor {
    
    public class func colorWithHex(hexColor:Int) -> UIColor {
        return UIColor.colorWithHex(hexColor, alpha: 1.0)
    }
    
    public class func colorWithHex(hexColor:Int, alpha:Float) -> UIColor {
        let red:Float = ((Float)((hexColor & 0xFF0000) >> 16))/255.0;
        let green:Float = ((Float)((hexColor & 0xFF00) >> 8))/255.0;
        let blue:Float = ((Float)(hexColor & 0xFF))/255.0;
        return UIColor(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: CGFloat(alpha))
    }
}
