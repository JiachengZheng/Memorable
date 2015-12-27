//
//  JCUIViewExtension.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/26.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit
extension UIView{
    
    var width: CGFloat{
        set{
            self.frame.size.width = newValue
        }
        get{
            return self.frame.size.width
        }
        
    }
    
    var height: CGFloat{
        set{
            self.frame.size.height = newValue
        }
        get{
            return self.frame.size.height
        }
    }
    
    var size: CGSize{
        set{
            self.frame.size = newValue
        }
        get{
            return self.frame.size
        }
        
    }
    
    var originX: CGFloat{
        set{
            self.frame.origin.x = newValue
        }
        get{
            return self.frame.origin.x
        }
        
    }
    
    var originY: CGFloat{
        set{
            self.frame.origin.y = newValue
        }
        get{
            return self.frame.origin.y
        }
    }
}
