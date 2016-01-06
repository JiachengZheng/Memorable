//
//  JCDetailToListTransion.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/6.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCDetailToListTransion: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //1.获取动画的源控制器和目标控制器
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! JCEventDetailVCL
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! JCListVCL
        let container = transitionContext.containerView()
        let dayslabel = fromVC.contentView.daysLabel.snapshotViewAfterScreenUpdates(true)
        let bg = fromVC.backgroundImageView.snapshotViewAfterScreenUpdates(false)
         dayslabel.frame = container!.convertRect(fromVC.contentView.daysLabel.frame, fromView: fromVC.contentView)
        fromVC.contentView.hidden = true
        let eventId = fromVC.eventId
        let model = toVC.model as! JCListModel
        var i = 0
        
        for item in model.items{
            if let item1 = item as? JCListItem{
                if item1.id == eventId{
                    break
                }
            }
            i++
        }
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        bg.frame = toVC.view.frame
        toVC.view.alpha = 0
        
        container!.addSubview(toVC.view)
        container!.addSubview(bg)
        container!.addSubview(dayslabel)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            dayslabel.frame = CGRectMake(screenWidth - 14 - dayslabel.width, CGFloat(64 + i*70 + 14), dayslabel.width, dayslabel.height)
            bg.frame = CGRectMake(0, CGFloat(64 + i*70), screenWidth, 70)
            toVC.view.alpha = 1
            bg.alpha = 0.6
            }) { (finish: Bool) -> Void in
                dayslabel.removeFromSuperview()
                bg.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
    }

    
}
