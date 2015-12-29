//
//  JCEventDetailModel.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import Foundation

class JCEventDetailModel: JCBaseModel {
    
    var event: JCEvent?
    var editViewItem: [JCEventEditViewItem]?
    
    override func loadItem(param: [String : AnyObject]?, complete: ([String : AnyObject]? -> Void), failure: ([String : AnyObject]? -> Void)) {
        let list = eventRealm.objects(JCEvent)
        if let obj1 = list.first {
            event = obj1
        }
        complete(nil)
    }
    
    func loadEditViewItem(param: [String : AnyObject]?, complete: ([String : AnyObject]? -> Void), failure: ([String : AnyObject]? -> Void)){
        guard let event = event else{
            failure(nil)
            return
        }
        let item1 = JCEventEditViewItem(itemType: .Name, text: event.name)
        let item2 = JCEventEditViewItem(itemType: .Date, text: event.date)
        let item3 = JCEventEditViewItem(itemType: .Time, text: event.time)
        let item4 = JCEventEditViewItem(itemType: .Type, text: event.type)
        let item5 = JCEventEditViewItem(itemType: .Top,  isTop:event.isTop)
        editViewItem = [item1,item2,item3,item4,item5]
        complete(nil)
    }
    
    
    
    
    
    
    
    
}
