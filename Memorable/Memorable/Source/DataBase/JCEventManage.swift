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
        
        let event = JCEvent(value:["1","周末",getRecentSaturday(),"00:00","生活",true])
        
        let _ = try? eventRealm.write { () -> Void in
            eventRealm.add(event)
        }
    }
    
    func updateEvent(event: JCEvent) {
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

    
}