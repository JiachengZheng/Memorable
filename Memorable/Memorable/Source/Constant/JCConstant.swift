//
//  JCConstant.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import Foundation
import UIKit

let iphone4Height: CGFloat = 480
let iphone5Height: CGFloat = 568
let iphone6Height: CGFloat = 667
let iphone6pHeight: CGFloat = 736
let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height

let detailDaysLabelMaxFontSize = 150

let applicationDidEnterBackgroundNotification = "applicationDidEnterBackgroundNotification"
let applicationWillEnterForegroundNotification = "applicationWillEnterForegroundNotification"
/// 顶部title文字，重要文字
func ColorImportant() -> UIColor {
    return UIColor.colorWithHex(0x27272f)
}

/// 辅助文字，次要信息
func ColorSecondary() -> UIColor {
    return UIColor.colorWithHex(0x545c66)
}

/// 助文字，次要信息2
func ColorSecondary2() -> UIColor {
    return UIColor.colorWithHex(0x9d9d9d)
}

/// 最弱的文字描述
func ColorMinor() -> UIColor {
    return UIColor.colorWithHex(0xbebebe)
}

