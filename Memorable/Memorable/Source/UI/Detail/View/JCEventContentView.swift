//
//  JCEventContentView.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit
import SnapKit
import pop
class JCEventContentView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subDaysLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
            make.width.equalTo(screenWidth)
        }
        subTitleLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp_bottom)
            make.width.equalTo(screenWidth)
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
            make.width.equalTo(screenWidth)
        }

    }
    
    func toggleAnimation(){
        self.layer.pop_removeAllAnimations()
        self.hidden = false
        
        let opacityAnim = POPBasicAnimation(propertyNamed: kPOPLayerOpacity)
        opacityAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        opacityAnim.duration = 0.6
        opacityAnim.fromValue = 0.2
        opacityAnim.toValue = 1
        self.layer.pop_addAnimation(opacityAnim, forKey: "opacityAnim")
        
        self.layer.addSpringAnimation(kPOPLayerScaleXY,
            fromValue: NSValue.init(CGSize: CGSize(width: 0.7, height: 0.7)),
            toValue: NSValue.init(CGSize: CGSize(width: 1, height: 1)),
            bounds: 9,
            speed: 17,
            animKey: "scaleAnim"){ (pop, finish) -> Void in
        }
    }
    
    func setupLable(name:String,date:String,time:String){
        let totalDate = date + " " +  time
        if let d = strToDate(totalDate){
            if d.isEarlierThan(NSDate()){
                subTitleLabel.text = "过去已经"
            }else{
                subTitleLabel.text = "还有"
            }
        }
       
        titleLabel.text = name
        dateLabel.text = standardDateFormat(totalDate)
        daysLabel.text = intervalTimeFromDate(totalDate).0
        subDaysLabel.text = "天" + intervalTimeFromDate(totalDate).1 + "时" + intervalTimeFromDate(totalDate).2 + "分"
        updateDaysLabelFont()
    }
    
    func updateDaysLabelFont(){
        if let text1 = daysLabel.text {
            let text = text1 as NSString
            var size: CGFloat = 72
            if text.length == 5{
            }else if (text1 as NSString).length == 4{
                size = 90
            }else if text.length == 3{
                size = 100
            }else if text.length == 2{
                size = 120
            }else if text.length == 1{
                size = 135
            }
            
            if isIphone5(){
                size += 3
            }
            if isIphone6(){
                size += 15
            }
            if isIphone6p(){
                size += 25
            }
            daysLabel.font = UIFont(name: "Arial", size: size)
        }
        titleLabel.font = UIFont.systemFontOfSize(51)
        dateLabel.font = UIFont.systemFontOfSize(15)
    }
    
    
    
    
    
    
    
    
    
    
    
}
