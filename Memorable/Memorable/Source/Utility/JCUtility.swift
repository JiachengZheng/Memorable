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

func strToDate(str: String,formatter:String = "yyyy-MM-dd HH:mm") -> NSDate?{
    let dateFormat = NSDateFormatter()
    dateFormat.timeZone = NSTimeZone.localTimeZone()
    dateFormat.dateFormat = formatter
    
    if let date = dateFormat.dateFromString(str){
        return date
    }else{
        return nil
    }
}

func dateToStr(date: NSDate,formatter:String = "yyyy-MM-dd") -> String{
    let dateFormat = NSDateFormatter()
    dateFormat.timeZone = NSTimeZone.localTimeZone()
    dateFormat.dateFormat = formatter
    let str = dateFormat.stringFromDate(date)
    return str
}

func getRecentSaturday()-> String{
    let now = NSDate()
    var saturday: NSDate
    let calendar = NSCalendar.currentCalendar()
    let weekDay = calendar.component(.Weekday, fromDate: now)
    /*
    1 －－星期天
    2－－星期一
    3－－星期二
    4－－星期三
    5－－星期四
    6－－星期五
    7－－星期六
    */
    if weekDay == 1{
        //周日
        saturday = now.dateByAddingDays(-1)
    }else if weekDay == 7{
        //周六
        saturday = now
    }else{
        saturday = now.dateByAddingDays(7-weekDay)
    }
    
    return dateToStr(saturday)
}

func getRecentSunday()-> String{
    let now = NSDate()
    var sunday: NSDate
    let weekDay = now.weekday()
    
    if weekDay == 1{
        //周日
        sunday = now
    }else if weekDay == 7{
        //周六
        sunday = now.dateByAddingDays(1)
    }else{
        sunday = now.dateByAddingDays(7 - (weekDay - 1))
    }
    
    return dateToStr(sunday)
}

func standardDateFormat(str:String,style: NSDateFormatterStyle = .FullStyle) -> String{
    let date = strToDate(str)
    if let dateStr = date?.formattedDateWithStyle(style){
        return dateStr
    }else{
        return ""
    }
}

func intervalTimeFromDate(str :String,formatter:String = "yyyy-MM-dd HH:mm",originDate: NSDate = NSDate() ) -> (String,String,String){
    let date1 = strToDate(str,formatter: formatter)
    guard let date = date1 else{
        return ("","","")
    }
    let now = originDate
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

func caculateLableSize(labelText: NSString,
    width: Float = MAXFLOAT,
    height: Float = MAXFLOAT,
    textAttributes: [String : AnyObject]) -> CGSize {
    return labelText.boundingRectWithSize(
            CGSizeMake(CGFloat(width), CGFloat(height)),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
        attributes:textAttributes , context: nil).size
}

func getUUID() -> String{
    let uuidRef = CFUUIDCreate(nil)
    let uuidStringRef = CFUUIDCreateString(nil, uuidRef)
    return uuidStringRef as String
}

func isDay(day1:String,earlier day2: String) -> Bool{
    guard let day = strToDate(day1) else{
        return true
    }
    guard let day3 = strToDate(day2) else{
        return false
    }
    return day.isEarlierThan(day3)
}

func getImageFullPath(name: String) -> String{
    var imageName = name
    if isIphone6p(){
        imageName = imageName + "@3x";
    }else{
        imageName = imageName + "@2x";
    }
    if let path = NSBundle.mainBundle().pathForResource(imageName, ofType: "png"){
        return path
    }else{
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "png")
        return path ?? name
    }
}

func loadTopEventDays() -> String{
    let list = eventRealm.objects(JCEvent)
    for event in list {
        if event.isTop {
            return intervalTimeFromDate(event.date + " " + event.time).0
        }
    }
    if let event = list.first{
        return intervalTimeFromDate(event.date + " " + event.time).0
    }
    return ""
}

func showIconBadge(){
    let isShow = NSUserDefaults.standardUserDefaults().objectForKey("showIconBadge") as? String
    var count = 0
    let num = Int(loadTopEventDays()) ?? 0
    if let isShow1 = isShow  {
        if isShow1 == "yes"{
            count = num
        }
    }else{
        count = num
    }
    UIApplication.sharedApplication().applicationIconBadgeNumber = count
}

func registerLocalNotification(){
    if let topEventNotification = NSUserDefaults.standardUserDefaults().objectForKey("topEventNotification") as? String{
        if topEventNotification == "false"{
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            return
        }
    }
    let list = eventRealm.objects(JCEvent)
    var topEvent1: JCEvent?
    for event in list {
        if event.isTop {
            topEvent1 = event
        }
    }
    guard let topEvent = topEvent1 else{
        return
    }
    let eventDate = topEvent.date + " " + topEvent.time
    let eventName = topEvent.name
    let eventId = topEvent.id
    UIApplication.sharedApplication().cancelAllLocalNotifications()
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        for i in 1...39{
            let noti = UILocalNotification()
            let fireDate = strToDate(dateToStr(NSDate().dateByAddingDays(i)) + " 08:00")
            noti.fireDate = fireDate
            noti.timeZone = NSTimeZone.localTimeZone()
            var body = ""
            if let d = strToDate(eventDate){

                let hours = intervalTimeFromDate(dateToStr(fireDate!,formatter: "yyyy-MM-dd HH:mm"),originDate:strToDate(eventDate)! ).1
                let minutes = intervalTimeFromDate(dateToStr(fireDate!,formatter: "yyyy-MM-dd HH:mm"),originDate:strToDate(eventDate)! ).2
                let hourStr = Int(hours)! > 0 ? hours + "小时" : ""
                let minuteStr = Int(minutes)! > 0 ? minutes + "分钟" : ""
                
                if d.isEarlierThan(fireDate){
                    let intervalDays = d.daysEarlierThan(fireDate)
                    let dayStr = intervalDays > 0 ? "\(intervalDays)" + "天" : ""
                    body = eventName + "过去已经" + dayStr + hourStr +  minuteStr + "了"
                }else{
                    let intervalDays = d.daysLaterThan(fireDate)
                    let dayStr = intervalDays > 0 ? "\(intervalDays)" + "天" : ""
                    body = "还有" + dayStr + hourStr + minuteStr + "就是" + eventName + "了"
                }
            }
            noti.alertBody = body
            noti.userInfo = ["topEventId": eventId]
            UIApplication.sharedApplication().scheduleLocalNotification(noti)
        }
        dispatch_async(dispatch_get_main_queue(), {
        })
    })
}

func isUserOpenNotification() -> Bool{
    let setting = UIApplication.sharedApplication().currentUserNotificationSettings()
    if setting?.types.rawValue == 0{
        return false
    }
    return true
}









