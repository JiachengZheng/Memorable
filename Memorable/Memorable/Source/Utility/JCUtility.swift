//
//  JCUtility.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import Foundation
import UIKit
import DateTools
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

func strToDate(str: String,formatter:String = "YYYY-MM-dd hh:mm") -> NSDate?{
    let dateFormat = NSDateFormatter()
    dateFormat.timeZone = NSTimeZone.localTimeZone()
    dateFormat.dateFormat = formatter
    
    if let date = dateFormat.dateFromString(str){
        return date
    }else{
        return nil
    }
}

func dateToStr(date: NSDate,formatter:String = "YYYY-MM-dd") -> String{
    let dateFormat = NSDateFormatter()
    dateFormat.timeZone = NSTimeZone.localTimeZone()
    dateFormat.dateFormat = formatter
    return dateFormat.stringFromDate(date)
}

func getRecentSaturday()-> String{
    let now = NSDate()
    var saturday: NSDate
    let weekDay = now.weekday()

    if weekDay == 0{
        //周日
        saturday = now.dateByAddingDays(-1)
    }else if weekDay == 6{
        //周六
        saturday = now
    }else{
        saturday = now.dateByAddingDays(7-weekDay)
    }
    
    return dateToStr(saturday)
}

func standardDateFormat(str:String) -> String{
    let date = strToDate(str)
    if let dateStr = date?.formattedDateWithStyle(.FullStyle){
        return dateStr
    }else{
        return ""
    }
}

func intervalTimeFromDate(str :String) -> (String,String,String){
    let date1 = strToDate(str,formatter: "YYYY-MM-dd hh:mm")
    guard let date = date1 else{
        return ("","","")
    }
    let now = NSDate()
    let totalSeconds = now.timeIntervalSinceDate(date)
    var minutes = Int((totalSeconds / 60) % 60)
    var hours = Int(totalSeconds / 3600)%24
    var day = Int(totalSeconds / (3600*24))
    if minutes<0{
        minutes = -minutes
    }
    if hours<0{
        hours = -hours
    }
    if day<0{
        day = -day
    }
    
    return ("\(day)","\(hours)","\(minutes)")
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


