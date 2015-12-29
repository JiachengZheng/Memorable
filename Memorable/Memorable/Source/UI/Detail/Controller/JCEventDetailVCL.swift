//
//  JCEventDetailVCL.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit
import pop

class JCEventDetailVCL: JCBaseVCL {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var contentView: JCEventContentView!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var themeBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    var isEditVeiwAnimation = false
    var editViewDataSource: JCEventEditViewDataSource!
    var editView: JCEventEditView?
    var isEdit: Bool = false
    var timer: NSTimer!
    
    var eventName: String = ""
    var eventDate: String = dateToStr(NSDate())
    var eventTime: String = "00:00"
    var eventType: String?
    var eventIsTop: Bool?

    override func awakeFromNib() {
        super.awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopTimerWhenEnterForeground", name: applicationDidEnterBackgroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadWhenEnterForeground", name: applicationWillEnterForegroundNotification, object: nil)
        
    }
    
    func reloadWhenEnterForeground(){
        timer.fireDate =  NSDate.distantPast()
    }
    
    func stopTimerWhenEnterForeground(){
        timer.fireDate =  NSDate.distantFuture()
    }
    
    //MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        loadModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !timer.valid{
            timer.fireDate =  NSDate.distantPast()
        }
        self.performSelector("animationContentView", withObject: nil, afterDelay: 0.3)
    }
    
    override func viewWillDisappear(animated: Bool) {
        if timer.valid{
            timer.fireDate =  NSDate.distantFuture()
        }

    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
        timer.invalidate()
        timer = nil
    }
    
    //MARK: 加载模型
    func loadModel(){
        self.model = JCEventDetailModel()
        model.loadItem(nil, complete: {[weak self] (suc) -> Void in
            self?.initContentView()
        }) { (fail) -> Void in
                
        }
    }
    
    func reloadEditTableView(){
        let model1 = self.model as! JCEventDetailModel
        guard let items = model1.editViewItem else{
            return
        }

        editViewDataSource = JCEventEditViewDataSource(items:items)
        editView!.tableView.dataSource = editViewDataSource
        editView!.tableView.reloadData()
    }
    
    //MARK: 点击事件
    @IBAction func clickEditBtn(sender: AnyObject) {
        isEdit = !isEdit
        if let _ = editView{
            reloadEditView(nil)
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
        contentView.setupLable(eventName, date: eventDate, time: eventTime)
        eventManager.updateEventWith("1",eventName: eventName,eventDate: eventDate,eventTime: eventTime,eventType: "生活",eventIsTop: true)
        clickCancelBtn()
    }
    
    //MARK: 检查输入合法性
    func checkContent(){

    }
    
    //MARK:动画处理
    func animationEditView(show: Bool,fromValue: CGFloat = editViewOriginY,toValue: CGFloat = editViewNormalY,speed: CGFloat = 16){
        
        isEditVeiwAnimation = true
        if show{
            UIApplication.sharedApplication().statusBarStyle = .Default
        }else{
            NSNotificationCenter.defaultCenter().postNotificationName(EditViewDisappearNotification, object: nil)
            UIApplication.sharedApplication().statusBarStyle = .LightContent
            showPickerView(false)
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
        contentView.toggleAnimation()
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
        datePicker.frame = CGRectMake(0, screenHeight, screenWidth, 216)
        datePicker.backgroundColor = UIColor.whiteColor()
        datePicker.addTarget(self, action: "datePickerChange:", forControlEvents: .ValueChanged)
        menuBtn.imageEdgeInsets = UIEdgeInsets(top: -10, left: -20, bottom: 0, right: 0)
        editBtn.imageEdgeInsets = UIEdgeInsets(top: -10, left: 20, bottom: 0, right: 0)
        
    }
    
    func initContentView(){
        guard let model = self.model as? JCEventDetailModel else{
            return
        }
        
        if let name = model.event?.name{
            eventName = name
            updateContentViewLabel()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "updateContentViewLabel", userInfo: nil, repeats: true)
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(backgroundImageView.snp_top).offset(getScaleValue(80))
            make.bottom.equalTo(backgroundImageView.snp_bottom).offset(getScaleValue(-100))
            make.right.equalTo(backgroundImageView)
            make.left.equalTo(backgroundImageView)
        }
        contentView.hidden = true
        contentView.userInteractionEnabled = false
    }
    
    func initEditView(){
        let effect = UIBlurEffect(style: .ExtraLight)
        editView = JCEventEditView(effect: effect)
        editView!.tableView.delegate = self
        editView!.tableView.registerClass(JCEventEditTableViewCell.self, forCellReuseIdentifier: "JCEventEditTableViewCell")
        reloadEditView(nil)
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
    
    func reloadEditView(parm:[String: AnyObject]?){
        let model1 = self.model as! JCEventDetailModel
        model1.loadEditViewItem(parm, complete: {[weak self] (suc) -> Void in
            self?.reloadEditTableView()
            }) { (fail ) -> Void in
        }
    }
    
    func updateContentViewLabel(){
        guard let model = self.model as? JCEventDetailModel else{
            return
        }
        
        if let name = model.event?.name,let date = model.event?.date,let time = model.event?.time{
            contentView.setupLable(name, date: date,time:time)
        }
    }
    
    func showPickerView(show: Bool){
        if show{
            setupPickerDate()
        }
        UIView.animateWithDuration(0.2, animations: {[weak self] () -> Void in
            if let picker = self?.datePicker{
                if show{
                    let y = screenHeight - picker.height
                    picker.frame = CGRectMake(0, y, screenWidth, picker.height)
                }else{
                    picker.frame = CGRectMake(0, screenHeight, screenWidth, picker.height)
                }
            }
            }) { (finish) -> Void in
        }
    }
    
    func setupPickerDate(){
        if let model = self.model as? JCEventDetailModel{
            if datePicker.datePickerMode == .Date{
                if let date = model.event?.date{
                    if let str = strToDate(date,formatter: "yyyy-MM-dd"){
                        datePicker.date = str
                    }
                }
            }else{
                if let date = model.event?.time{
                    if let str = strToDate(date,formatter: "HH:mm"){
                        datePicker.date = str
                    }
                }
            }
        }
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
    
    //MARK: 监听textField
    func textFieldEditChanged(textField: UITextField){
        if let text = textField.text{
            eventName = text
        }
        showPickerView(false)
    }
    
    //MARK: 监听 datePicker
    func datePickerChange(picker: UIDatePicker){
        let event: JCEvent!
        if picker.datePickerMode == .Date{
            eventDate = dateToStr(picker.date)
            event = JCEvent(value:["1",eventName, eventDate,"00:00","生活",true])
        }else{
            eventTime = dateToStr(picker.date,formatter:"HH:mm")
            event = JCEvent(value:["1",eventName,eventDate,eventTime,"生活",true])
        }
        
        let dic: [String: AnyObject] = ["isEdit":true,"editEvent": event]
        reloadEditView(dic)
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

//MARK: UITextFieldDelegate
extension JCEventDetailVCL: UITextFieldDelegate{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        if !string.isEmpty && (eventName as NSString).length > 25{
            return false
        }
        return true
    }

}

//MARK: UITableViewDelegate
extension JCEventDetailVCL:UITableViewDelegate{
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        if let cell = cell as? JCEventEditTableViewCell{
            if let textField = cell.nameTF{
                textField.addTarget(self, action: "textFieldEditChanged:", forControlEvents: .EditingChanged)
                textField.delegate = self
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath == 0{
            return
        }
        NSNotificationCenter.defaultCenter().postNotificationName(EditViewDisappearNotification, object: nil)
        if indexPath.row == 1{
            datePicker.datePickerMode = .Date
            showPickerView(true)
        }else if indexPath.row == 2{
            datePicker.datePickerMode = .Time
            showPickerView(true)
        }else if indexPath.row == 3{
            
        }
    }
}





















