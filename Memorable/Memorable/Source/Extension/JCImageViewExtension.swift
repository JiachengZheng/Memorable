//
//  JCImageViewExtension.swift
//  Memorable
//
//  Created by zhengjiacheng on 16/1/12.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit
import YYWebImage
extension UIImageView{
    
    func loadLocalImage(name: String){
        let imagePath = getImageFullPath(name)
        if let data = NSData(contentsOfFile: imagePath){
            self.image = UIImage(data:data)
        }
        //self.yy_setImageWithURL(NSURL.fileURLWithPath(imagePath), options: .Progressive)
    }
}
