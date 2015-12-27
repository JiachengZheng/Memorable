//
//  JCDetailContentView.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit
import SnapKit
import pop
class JCDetailContentView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subDaysLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        subTitleLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp_bottom)
        }
        daysLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            let spacing = getScaleValue(-20)
            make.centerY.equalTo(self.snp_centerY).offset(spacing)
        }
        subDaysLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(daysLabel.snp_right)
            make.baseline.equalTo(daysLabel.snp_baseline)
        }
        dateLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp_bottom)
        }

    }
    
    func toggleAnimation(){
        self.layer.pop_removeAllAnimations()
        self.hidden = false
        
        let opacityAnim = POPBasicAnimation(propertyNamed: kPOPLayerOpacity)
        opacityAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        opacityAnim.duration = 0.8
        opacityAnim.fromValue = 0.2
        opacityAnim.toValue = 1
        self.layer.pop_addAnimation(opacityAnim, forKey: "opacityAnim")
        
        self.layer.addSpringAnimation(kPOPLayerScaleXY,
            fromValue: NSValue.init(CGSize: CGSize(width: 0.5, height: 0.5)),
            toValue: NSValue.init(CGSize: CGSize(width: 1, height: 1)),
            bounds: 5,
            speed: 1,
            animKey: "scaleAnim"){ (pop, finish) -> Void in
        }
    }
}
