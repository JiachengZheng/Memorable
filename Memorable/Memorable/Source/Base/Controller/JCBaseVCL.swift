//
//  JCBaseVCL.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
class JCBaseVCL: UIViewController ,UIGestureRecognizerDelegate{

    var model: JCBaseModel = JCBaseModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadViewController(name: String) -> JCBaseVCL{
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyBoard.instantiateViewControllerWithIdentifier(name) as! JCBaseVCL
    }
    
    func showSuccess(text: String = ""){
        SVProgressHUD.showSuccessWithStatus(text)
    }
    
    func showFail(text: String = ""){
        SVProgressHUD.showErrorWithStatus(text)
    }
    
    func showTipView(text: String = ""){
        SVProgressHUD.showInfoWithStatus(text)
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
