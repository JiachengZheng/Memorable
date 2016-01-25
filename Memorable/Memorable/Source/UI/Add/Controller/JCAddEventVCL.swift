//
//  JCAddEventVCL.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/23.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class JCAddEventVCL: JCBaseTableViewVCL {

    @IBOutlet weak var datePicker: UIDatePicker!
    private var disposeBag = DisposeBag()
    
    var eventName: String = ""
    var eventDate: String = ""
    var eventTime: String = ""
    var eventCategory: String = ""
    var eventIsTop: Bool = false
    var eventId: String = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        datePicker.date = NSDate()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        showPickerView(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventDate = dateToStr(NSDate())
        self.eventCategory = "生活"
        model = JCAddEventModel()
        loadItem()
        subscribe()
        datePicker.frame = CGRectMake(0, screenHeight, screenWidth, 216)
        datePicker.backgroundColor = UIColor.whiteColor()
    }
    
    func loadItem(){
        let model = self.model as! JCAddEventModel
        model.loadItem(nil , complete: { [weak self](com) -> Void in
            self?.reloadData()
            }) { (fail ) -> Void in
        }
    }
    
    func reloadData(){
        let model = self.model as! JCAddEventModel
        dataSource = JCAddEventDataSource(items:model.items)
        tableView.dataSource = self.dataSource
        tableView.reloadData()
    }
    
    func resetInputView(){
        let cell1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! JCAddEventNameCell
        cell1.textField.resignFirstResponder()
        showPickerView(false)
    }
    
    //MARK: 订阅信号
    func subscribe(){
        
        //datePicker 变化
        datePicker.rx_date.subscribeNext { [unowned self](date) -> Void in
            if self.datePicker.datePickerMode == .Date{
                self.eventDate = dateToStr(self.datePicker.date)
                let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection:0)) as! JCAddEventDateCell
                cell.dateLable.text = self.eventDate
            }else{
                self.eventTime = dateToStr(self.datePicker.date,formatter:"HH:mm")
                let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection:0)) as! JCAddEventTimeCell
                cell.timeLabel.text = self.eventTime
            }
            }.addDisposableTo(disposeBag)
    }
    
    func showPickerView(show: Bool){
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
    
    @IBAction func saveAction(sender: AnyObject) {
        resetInputView()
        saveEvent()
        performSelector("backAction", withObject: nil, afterDelay: 1)
    }
    
    func saveEvent(){
        eventManager.addEvent(eventName,eventDate: eventDate,eventTime: eventTime,eventType: eventCategory,eventIsTop: eventIsTop)
        showSuccess("保存成功")
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell1 = tableView.cellForRowAtIndexPath(indexPath)
        if let _ = cell1 as? JCAddEventNameCell{
            showPickerView(false)
        }else{
            let cell2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! JCAddEventNameCell
            cell2.textField.resignFirstResponder()
        }
        
        if let _ = cell1 as? JCAddEventDateCell{
            datePicker.datePickerMode = .Date
            showPickerView(true)
        }else if let _ = cell1 as? JCAddEventTimeCell{
            datePicker.datePickerMode = .Time
            showPickerView(true)
        }else if let _ = cell1 as? JCAddEventCategoryCell{
            let vcl = loadViewController("JCEventCategoryVCL") as! JCEventCategoryVCL
            vcl.currentCategory = "生活"
            vcl.selectCategoryBlock = {[unowned self] in
                let item = self.model.items[3] as! JCAddEventCategoryItem
                self.eventCategory = $0
                item.category = $0
                self.reloadData()
            }
            self.navigationController?.pushViewController(vcl, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? JCAddEventNameCell{
            cell.textField.rx_text.subscribeNext({ [unowned self](text) -> Void in
                self.eventName = text
                }).addDisposableTo(disposeBag)
            cell.textField.delegate = self
        }else if let cell = cell as? JCAddEventTopCell{
            cell.switchBtn.rx_value.subscribe(onNext: {[unowned self] (on) -> Void in
                self.eventIsTop = on
            }).addDisposableTo(disposeBag)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}

extension JCAddEventVCL: UITextFieldDelegate{
    
}











