//
//  JCListModel.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCListModel: JCBaseModel {
    override func loadItem(param: [String : AnyObject]?, complete: ([String : AnyObject]? -> Void), failure: ([String : AnyObject]? -> Void)) {
        self.items.removeAll()
        let list = eventRealm.objects(JCEvent)
        var itemArr: [JCListItem] = []
        var topItem: JCListItem?
        for obj in list {
            let item = JCListItem(id: obj.id, name: obj.name, date: obj.date + " " + obj.time)
            item.event = obj
            if item.event.isTop{
                topItem = item
                continue
            }
            itemArr.append(item)
        }
        itemArr.sortInPlace{ (item1, item2) -> Bool in
            let time1 = item1.event.date + " " + item1.event.time
            let time2 = item2.event.date + " " + item2.event.time
            if let date1 = strToDate(time1),date2 = strToDate(time2){
                let result = date1.compare(date2)
                if result == .OrderedAscending{
                    return false
                }else{
                    return true
                }
            }
            return false
        }
        
        if let topItem1 = topItem{
            itemArr.insert(topItem1, atIndex: 0)
        }else{
            let item = itemArr.first
            if let event = item?.event{
                eventManager.updateEventWith(event.id, eventName: event.name, eventDate: event.date, eventTime: event.time, eventType: event.type, eventIsTop: true, eventBgName: event.bgName)
            }
        }
        self.items = itemArr
        complete(nil)
    }
    
    func deleteItemAtIndex(indexPath: NSIndexPath){
        let item =  self.items[indexPath.row] as! JCListItem
        eventManager.deleteEvent(item.event)
        self.items.removeAtIndex(indexPath.row)
    }
    
    func resetTopEvent(){
        let list = eventRealm.objects(JCEvent)
        let item = items.first as! JCListItem
        
        for event in list {
            if event.id == item.event.id{
                eventManager.updateEventWith(event.id, eventName: event.name, eventDate: event.date, eventTime: event.time, eventType: event.type, eventIsTop: true, eventBgName: event.bgName)
            }else{
                eventManager.updateEventWith(event.id, eventName: event.name, eventDate: event.date, eventTime: event.time, eventType: event.type, eventIsTop: false, eventBgName: event.bgName)

            }
        }
    }
    
    
    
    
    
    
    
    
}
