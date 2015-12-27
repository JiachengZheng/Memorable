//
//  JCCALayerExtentsion.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import pop

extension CALayer{
    func addSpringAnimation(propertyName:String ,fromValue: NSValue?,toValue: NSValue?,bounds: CGFloat,speed: CGFloat,animKey: String,completionBlock:((POPAnimation!, Bool) -> Void)!){
        let anim = POPSpringAnimation(propertyNamed: propertyName)
        if let fromValue = fromValue{
            anim.fromValue = fromValue
        }
        if let toValue = toValue{
            anim.toValue = toValue
        }
        anim.springSpeed = speed
        anim.springBounciness = bounds
        anim.completionBlock = { (anim,finished) in
            completionBlock(anim,finished)
        }
        self.pop_addAnimation(anim, forKey: animKey)
    }
}








