//
//  JCMemorableDetailVCL.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit
import pop
class JCMemorableDetailVCL: JCBaseVCL,UITextFieldDelegate {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var contentView: JCDetailContentView!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var themeBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    var isEditVeiwAnimation = false
    var editView: JCDetailEditView?
    var isEdit: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.performSelector("animationContentView", withObject: nil, afterDelay: 0.3)
    }
    
    //MARK: 点击事件
    @IBAction func clickEditBtn(sender: AnyObject) {
        isEdit = !isEdit
        if let _ = editView{
        }else{
            initEditView()
        }
        let tap = UITapGestureRecognizer(target: self, action: "clickCancelBtn")
        backgroundImageView.addGestureRecognizer(tap)
        animationEditView(isEdit)
    }
    
    @IBAction func clickShareBtn(sender: AnyObject) {
        clickCancelBtn()
    }
    
    @IBAction func clickThemeBtn(sender: AnyObject) {
        clickCancelBtn()
    }
    
    func clickCancelBtn(){
        if !isEdit{
            return
        }
        isEdit = false
        animationEditView(isEdit)
    }
    
    func clickSaveBtn(){
        clickCancelBtn()
    }
    
    //MARK:动画处理
    func animationEditView(show: Bool,fromValue: CGFloat = editViewOriginY,toValue: CGFloat = editViewNormalY,speed: CGFloat = 16){
        
        isEditVeiwAnimation = true
        if show{
            UIApplication.sharedApplication().statusBarStyle = .Default
        }else{
            NSNotificationCenter.defaultCenter().postNotificationName(EditViewDisappearNotification, object: nil)
            UIApplication.sharedApplication().statusBarStyle = .LightContent
        }
        
        var tuple = (fromValue,toValue)
        if !show{
            tuple = (toValue,fromValue)
        }
        editView?.layer.pop_removeAllAnimations()
        editView!.layer.addSpringAnimation(kPOPLayerPositionY,
            fromValue: tuple.0,
            toValue: tuple.1,
            bounds: 9,
            speed: speed,
            animKey: "editView",
            completionBlock: { (pop , finish) -> Void in
                self.isEditVeiwAnimation = false
        })
        self.view.layoutIfNeeded()
    }
    
    func animationContentView(){
        contentView.ToggleAnimation()
    }
    
    //MARK: 初始化UI
    func initUI(){
        backgroundImageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        menuBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(backgroundImageView).offset(8)
            make.top.equalTo(backgroundImageView).offset(20)
            make.size.equalTo(CGSize(width: 60, height: 44))
        }
        editBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(backgroundImageView).offset(-8)
            make.top.equalTo(menuBtn)
            make.size.equalTo(menuBtn)
        }
        themeBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(menuBtn)
            make.bottom.equalTo(backgroundImageView).offset(-10)
            make.size.equalTo(menuBtn)
        }
        shareBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(editBtn)
            make.bottom.equalTo(backgroundImageView).offset(-10)
            make.size.equalTo(menuBtn)
        }
        contentView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(backgroundImageView.snp_top).offset(getScaleValue(80))
            make.bottom.equalTo(backgroundImageView.snp_bottom).offset(getScaleValue(-100))
            make.right.equalTo(backgroundImageView)
            make.left.equalTo(backgroundImageView)
        }
        contentView.hidden = true
        contentView.userInteractionEnabled = false
        menuBtn.imageEdgeInsets = UIEdgeInsets(top: -10, left: -20, bottom: 0, right: 0)
        editBtn.imageEdgeInsets = UIEdgeInsets(top: -10, left: 20, bottom: 0, right: 0)
    }
    
    func initEditView(){
        let effect = UIBlurEffect(style: .ExtraLight)
        editView = JCDetailEditView(effect: effect)
        editView!.tableView.delegate = self
        editView!.tableView.dataSource = self
        editView!.saveActionBlock = {[weak self] in
            self?.clickSaveBtn()
        }
        editView!.cancelActionBlock = { [weak self] in
            self?.clickCancelBtn()
        }
        self.view.addSubview(editView!)
        editView!.frame = CGRectMake(0, (-1.0)*(editViewHeight+editViewExtentHeight), screenWidth, editViewHeight + editViewExtentHeight)
        let pan = UIPanGestureRecognizer(target: self, action: "panEditView:")
        backgroundImageView?.addGestureRecognizer(pan)
    }
    
    //MARK: panGesture
    func panEditView(gesture: UIPanGestureRecognizer){
        if !isEdit || isEditVeiwAnimation{
            return
        }
        let translation = gesture.translationInView(self.view)
        
        if (gesture.state == .Began){

        }else if (gesture.state == .Changed){
            let changeY = translation.y - editViewExtentHeight/2
            if changeY < 0{
                UIView.animateWithDuration(0.05, animations: {[weak self] () -> Void in
                    self?.editView!.frame = CGRectMake(0, changeY , screenWidth, editViewExtentHeight + editViewHeight)
                    })
            }
            
        }else if(gesture.state == .Cancelled || gesture.state == .Ended){
            let centerY: CGFloat = 150
            var y =  centerY + translation.y
            if translation.y>40{
                y =  (centerY + 15)
            }
            
            if translation.y > 0{
                isEdit = true
                animationEditView(isEdit,fromValue:y ,speed: 4)
            }else{
                isEdit = false
                animationEditView(isEdit,toValue: y,speed: 3)
            }
            
        }
        
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
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

//MARK: UITableViewDelegate
extension JCMemorableDetailVCL:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identifier = "JCDetailEditTableViewCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if let _ = cell{
        }else{
            cell = JCDetailEditTableViewCell(style: .Default, reuseIdentifier: identifier,type:EditTableViewCellType(rawValue: indexPath.row)!)
        }
        if let cell1 = cell as? JCDetailEditTableViewCell{
            cell1.nameTF?.delegate = self
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    

}
