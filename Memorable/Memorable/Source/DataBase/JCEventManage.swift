//
//  JCEventManage.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/27.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import Foundation

class JCEventManage {
    
    func addDefaultEvent() {
        
        let list = eventRealm.objects(JCEvent)
        if list.count > 0{
            return
        }
        
        let event = JCEvent(value:[getUUID(),"周六",getRecentSaturday(),"00:00","生活",false ,"background1"])
        let event1 = JCEvent(value:[getUUID(),"周日",getRecentSunday(),"00:00","生活",false,"background1"])
        let event2 = JCEvent(value:[getUUID(),"14年双十二","2014-12-12","00:00","生活",false,"background1"])
        let event3 = JCEvent(value:[getUUID(),"15年双十二","2015-12-12","00:00","生活",true,"background1"])
        let _ = try? eventRealm.write { () -> Void in
            eventRealm.add([event,event1,event2,event3])
        }
    }
    
    func addEvent(eventName: String,eventDate: String,eventTime: String,eventType: String,eventIsTop: Bool,eventBgName: String = "background1"){
        let event = JCEvent(value:[getUUID(),eventName,eventDate,eventTime,eventType,eventIsTop,eventBgName])
        if eventIsTop{
            let list = eventRealm.objects(JCEvent)
            for event in list {
                if event.isTop {
                    eventManager.updateEventWith(event.id, eventName: event.name, eventDate: event.date, eventTime: event.time, eventType: event.type, eventIsTop: false, eventBgName: event.bgName)
                }
            }
        }
        let _ = try? eventRealm.write { () -> Void in
            eventRealm.add([event])
        }
    }
    
    func updateEventWith(eventId:String ,eventName: String,eventDate: String,eventTime: String,eventType: String,eventIsTop: Bool,eventBgName: String) {
        let event = JCEvent(value:[eventId,eventName,eventDate,eventTime,eventType,eventIsTop,eventBgName])
        if eventIsTop{
            let list = eventRealm.objects(JCEvent)
            for event in list {
                if event.isTop {
                    eventManager.updateEventWith(event.id, eventName: event.name, eventDate: event.date, eventTime: event.time, eventType: event.type, eventIsTop: false, eventBgName: event.bgName)
                }
            }
        }

        let _ = try? eventRealm.write { () -> Void in
            eventRealm.add(event,update: true)
        }
    }
    
    func deleteAll() {
        let _ = try? eventRealm.write { () -> Void in
            eventRealm.deleteAll()
        }
    }
    
    func deleteEvent(event: JCEvent) {
        let _ = try? eventRealm.write { () -> Void in
            eventRealm.delete(event)
        }
    }
    
    func addDefaultEventCategory() {
        let list = eventRealm.objects(JCEventCategory)
        if list.count > 0{
            return
        }
        let cate1 = JCEventCategory(value:[getUUID(),"生活"])
        let cate2 = JCEventCategory(value:[getUUID(),"工作"])
        let cate3 = JCEventCategory(value:[getUUID(),"纪念日"])
        let _ = try? eventRealm.write { () -> Void in
            eventRealm.add([cate1,cate2,cate3])
        }
    }
    
    func addEventCategory(category: JCEventCategory) {
        let _ = try? eventRealm.write { () -> Void in
            eventRealm.add(category)
        }
    }
    
    func updateEventCategory(categoryId:String ,categoryName: String) {
        let category = JCEventCategory(value:[categoryId,categoryName])
        let _ = try? eventRealm.write { () -> Void in
            eventRealm.add(category,update: true)
        }
    }
    
    func deleteCategory(category : JCEventCategory) {
        let _ = try? eventRealm.write { () -> Void in
            eventRealm.delete(category)
        }
    }

    
}