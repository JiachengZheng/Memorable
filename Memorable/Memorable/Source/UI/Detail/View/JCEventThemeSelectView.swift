//
//  JCEventThemeSelectView.swift
//  Memorable
//
//  Created by zhengjiacheng on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit
import pop
class JCEventThemeSelectView: UIView {

    var dissmissBlock: (()->Void)?
    var chooseThemeBlock: ((tag: Int)-> Void)?
    
    var isShow = false
    let btnWidth: CGFloat = {
        if isIphone6(){
            return CGFloat(48)
        }
        if isIphone6p(){
            return CGFloat(60)
        }
        return CGFloat(42)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(0xffffff, alpha: 0)
        
        for i in 1...6{
            let btn = self.viewWithTag(1000+i) as! JCBaseButton
            btn.addTarget(self, action: "chooseThemeBtn:", forControlEvents: .TouchUpInside)
        }
        self.hidden = true
    }
    
    func closeAction(){
        dissmissBlock?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = UIScreen.mainScreen().bounds
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "closeAction"))
        self.userInteractionEnabled = false
        for i in 1...6{
            let btn = self.viewWithTag(1000+i) as! JCBaseButton
            btn.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(self.snp_bottom).offset(-85)
                let originX = ((screenWidth-6 * btnWidth)/7.0)*CGFloat(i) + CGFloat(i-1)*btnWidth
                make.left.equalTo(originX)
                make.size.equalTo(CGSizeMake(btnWidth, btnWidth))
            })
        }
        layoutIfNeeded()
    }
    
    func toggleAnimation(){
        isShow = !isShow
        if isShow{
            self.hidden = false
            self.userInteractionEnabled = true
        }else{
            self.userInteractionEnabled = false
        }
        performSelector("startAnimation", withObject: nil , afterDelay: 0.05)
    }
    
    func startAnimation(){
        for i in 1...6{
            var btn: JCBaseButton!
            if isShow{
                btn = self.viewWithTag(1000+i) as! JCBaseButton
            }else{
                btn = self.viewWithTag(1007-i) as! JCBaseButton
            }
           
            performSelector("btnAnimation:", withObject: btn!, afterDelay: 0.05*Double(i))
            if !isShow && i == 6{
                performSelector("hiddenSelf", withObject: btn!, afterDelay: 0.05*Double(6) + 0.5)
            }
        }
    }
    
    func hiddenSelf(){
        self.hidden = true
    }
    
    func btnAnimation(view: UIView){
        view.hidden = false
        let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
        anim.springBounciness = 5
        anim.springSpeed = 12
        if isShow{
            anim.fromValue = screenWidth
            anim.toValue = ((screenWidth-6 * btnWidth)/7.0)*CGFloat(view.tag - 1000) + CGFloat(view.tag - 1000-1)*btnWidth + btnWidth/2

        }else{
            anim.toValue = screenWidth + btnWidth/2
            anim.fromValue = ((screenWidth-6 * btnWidth)/7.0)*CGFloat(view.tag - 1000) + CGFloat(view.tag - 1000-1)*btnWidth + btnWidth/2
        }
        view.layer.pop_addAnimation(anim, forKey: "btn\(tag)")
    }
    
    func chooseThemeBtn(btn: JCBaseButton){
        if btn.tag == 1006{
            return
        }
        chooseThemeBlock?(tag: btn.tag - 1000)
    }
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
