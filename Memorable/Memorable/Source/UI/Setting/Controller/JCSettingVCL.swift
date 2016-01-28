//
//  JCSettingVCL.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/21.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class JCSettingVCL: JCBaseTableViewVCL {
    private var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        model = JCSettingModel()
        loadItem()
    }
    
    func loadItem(){
        let model = self.model as! JCSettingModel
        model.loadItem(nil , complete: { [weak self](com) -> Void in
            self?.reloadData()
            }) { (fail ) -> Void in
        }
    }
    
    func reloadData(){
        let model = self.model as! JCSettingModel
        dataSource = JCSettingDataSource(items:model.items)
        tableView.dataSource = self.dataSource
        tableView.reloadData()
    }
    
    func showGoSettingAlertView(){
        let setting = UIApplication.sharedApplication().currentUserNotificationSettings()
        if setting?.types.rawValue == 0{
            let alertViewController = UIAlertController(title: "未打开通知权限", message: "请到“设置-通知”中打开应用的允许通知权限", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: { [unowned self](action) -> Void in
                self.loadItem()
                })
            let goAction = UIAlertAction(title: "去设置", style: .Default, handler: {[unowned self] (action) -> Void in
                self.loadItem()
                if let url = NSURL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.sharedApplication().openURL(url)
                }
                })
            alertViewController.addAction(goAction)
            alertViewController.addAction(cancelAction)
            presentViewController(alertViewController, animated: true, completion: { () -> Void in
                
        })
        }
    }
    
    func setupIconBadge(on: Bool){
        if on{
            if !isUserOpenNotification(){
               showGoSettingAlertView()
                return
            }
        }
        let isShow = on ? "yes" : "false"
        NSUserDefaults.standardUserDefaults().setObject(isShow, forKey: "showIconBadge")
        showIconBadge()
    }
    
    func setupTopEventNotification(on: Bool){
        if on{
            if !isUserOpenNotification(){
                showGoSettingAlertView()
                return
            }
        }
        let isShow = on ? "yes" : "false"
        NSUserDefaults.standardUserDefaults().setObject(isShow, forKey: "topEventNotification")
        if !on{
            UIApplication.sharedApplication().cancelAllLocalNotifications()
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1{
            let cell = cell as! JCSettingSwitchCell
            cell.swithBtn.rx_value.subscribe(onNext: {[unowned self] (on) -> Void in
                self.setupIconBadge(on)
                }).addDisposableTo(disposeBag)
        }
        if indexPath.row == 2{
            let cell = cell as! JCSettingSwitchCell
            cell.swithBtn.rx_value.subscribe(onNext: {[unowned self] (on) -> Void in
                self.setupTopEventNotification(on)
                }).addDisposableTo(disposeBag)
        }
    }
}















