//
//  JCListVCL.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCListVCL: JCBaseTableViewVCL {
    var cellImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.model = JCListModel()
        loadItem()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 禁用 iOS7 返回手势
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        loadItem()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
    }
    
    func loadItem(){
        let model = self.model as! JCListModel
        model.loadItem(nil , complete: { [weak self](com) -> Void in
            self?.reloadData()
            }) { (fail ) -> Void in
                
        }
    }
    
    func reloadData(){
        let model = self.model as! JCListModel
        self.dataSource = JCListDataSource(items:model.items)
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
            if segue.identifier == "Detail" {
                if let cell = sender as? JCListTableViewCell{
                    cellImageView = cell.bgImageView
                    cellImageView.frame = self.view.convertRect(cell.bgImageView.frame, fromView: cell.contentView)
                    cell.removeFromSuperview()
                    self.view.addSubview(cellImageView)
                    let index = tableView.indexPathForCell(cell)
                    let item = self.model.items[index!.row] as! JCListItem
                    let event = item.event
                    let vcl = segue.destinationViewController as! JCEventDetailVCL
                    vcl.paramDic = ["fromList": true,"event":event]
                }
            }
    }
}

//MARK: UITableViewDelegate
extension JCListVCL{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! JCListTableViewCell
//        cell.toggleAnimation()
    }
}

extension JCListVCL: UINavigationControllerDelegate{
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
         if let _ = toVC as? JCEventDetailVCL{
            if operation == UINavigationControllerOperation.Push {
                return JCListToDetailTransion()
            } else {
                return nil
            }
        }
        return nil
    }
}
