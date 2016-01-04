//
//  JCShareVCL.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/1.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit
import pop
class JCShareVCL: JCBaseVCL {
    
    
    @IBOutlet weak var qqBtn: JCBaseButton!
    @IBOutlet weak var qqZoneBtn: JCBaseButton!
    @IBOutlet weak var sinaBtn: JCBaseButton!
    @IBOutlet weak var friendBtn: JCBaseButton!
    @IBOutlet weak var weixinBtn: JCBaseButton!
    @IBOutlet weak var closeBtn: JCBaseButton!

    var dismissBlock:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let effect = UIBlurEffect(style: .Light)
        let blur = UIVisualEffectView(effect: effect)
        blur.frame = self.view.frame
        self.view.addSubview(blur)
        self.view.backgroundColor = UIColor.colorWithHex(0xffffff, alpha: 0.5)
        self.view.sendSubviewToBack(blur)
        setupView()
        blur.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "closeAction:"))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .Default
            }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        for i in 0...4{
            if let view = self.view.viewWithTag(1000+i){
                performSelector("presentAnimation:", withObject: view, afterDelay:  (Double(i) * 0.05))
            }
        }
        closeBtnAnimation(9.4)

    }
    
    func closeBtnAnimation(toValue: Float){
        closeBtn.hidden = false
        presentAnimation(closeBtn)
        let anim = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        anim.beginTime = CACurrentMediaTime() + 0.1
        anim.duration = 0.6
        anim.toValue = toValue
        closeBtn.layer.pop_addAnimation(anim, forKey: "close")
    }
    
    func presentAnimation(view: UIView){
        view.hidden = false
        view.layer.addSpringAnimation(kPOPLayerBounds, fromValue: NSValue.init(CGRect: CGRectMake(0, 0, 0, 0)), toValue: NSValue.init(CGRect: CGRectMake(0, 0, 60, 60)), bounds: 10, speed: 8, animKey: "pop") { (anim, finished) -> Void in
        }
    }
    
    func dismissAnimation(view: UIView){
        view.layer.addSpringAnimation(kPOPLayerBounds, fromValue: NSValue.init(CGRect: CGRectMake(0, 0, 60, 60)), toValue: NSValue.init(CGRect: CGRectMake(0, 0, 0, 0)), bounds: 10, speed: 8, animKey: "pop") { (anim, finished) -> Void in
            view.hidden = true
        }
    }

    func setupView(){

        qqZoneBtn.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(-30)
        }
        qqBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(qqZoneBtn.snp_left).offset(-40)
            make.centerY.equalTo(qqZoneBtn)
        }
        weixinBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(qqZoneBtn.snp_right).offset(40)
            make.centerY.equalTo(qqZoneBtn)
        }
        friendBtn.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(qqZoneBtn)
            make.top.equalTo(qqZoneBtn.snp_bottom).offset(30)

        }
        sinaBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(qqBtn.snp_bottom).offset(30)
            make.centerX.equalTo(qqBtn)
        }
        closeBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(friendBtn).offset(150)
            make.centerX.equalTo(friendBtn)
//            make.size.equalTo(CGSizeMake(10, 10))
        }
    }
    
    @IBAction func closeAction(sender: AnyObject) {
        for i in 0...4{
            if let view = self.view.viewWithTag(1000+i){
                performSelector("dismissAnimation:", withObject: view, afterDelay:  (Double(i) * 0.05))
            }
        }
        
        let anim = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        anim.duration = 0.6
        anim.toValue = 0
        closeBtn.layer.pop_addAnimation(anim, forKey: "close")
        dismissAnimation(closeBtn)
        performSelector("dissmissSelf", withObject: nil, afterDelay:  0.32)
    }
    
    func dissmissSelf(){
        dismissBlock?()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
