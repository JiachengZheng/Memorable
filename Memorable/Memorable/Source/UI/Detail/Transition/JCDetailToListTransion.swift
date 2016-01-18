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
        return 0.34
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? JCEventDetailVCL else{
            return
        }

        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! JCListVCL
        let container = transitionContext.containerView()
        
        let dayslabel = fromVC.contentView.daysLabel.snapshotViewAfterScreenUpdates(true)
        let title = fromVC.contentView.titleLabel.snapshotViewAfterScreenUpdates(true)
        let date = fromVC.contentView.dateLabel.snapshotViewAfterScreenUpdates(true)
        let bg = fromVC.backgroundImageView.snapshotViewAfterScreenUpdates(false)
        
        title.frame = container!.convertRect(fromVC.contentView.titleLabel.frame, fromView: fromVC.contentView)
        date.frame = container!.convertRect(fromVC.contentView.dateLabel.frame, fromView: fromVC.contentView)
        dayslabel.frame = container!.convertRect(fromVC.contentView.daysLabel.frame, fromView: fromVC.contentView)
       
        let eventId = fromVC.eventId
        let model = toVC.model as! JCListModel
        var i:CGFloat = 0
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
        container!.addSubview(title)
        container!.addSubview(date)
        
        fromVC.contentView.hidden = true
        
        let titleWidth = caculateLableSize(fromVC.contentView.titleLabel.text!,height:Float(fromVC.contentView.titleLabel.height), textAttributes: [NSFontAttributeName:UIFont.systemFontOfSize(22)]).width
        let dateWidth = caculateLableSize(fromVC.contentView.dateLabel.text!,height:Float(fromVC.contentView.dateLabel.height) ,textAttributes: [NSFontAttributeName:UIFont.systemFontOfSize(11)]).width
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            dayslabel.frame = CGRectMake(screenWidth - 14 - dayslabel.width, CGFloat(64 + i*listCellHight + 14), dayslabel.width, dayslabel.height)
            title.center = CGPointMake(13+titleWidth/2, CGFloat(64 + i*listCellHight + 26))
            date.center = CGPointMake(13+dateWidth/2, CGFloat(64 + i*listCellHight + 51))
            bg.frame = CGRectMake(0, CGFloat(64 + i*listCellHight), screenWidth, listCellHight)
            toVC.view.alpha = 1
            
            }) { (finish: Bool) -> Void in
                dayslabel.removeFromSuperview()
                bg.removeFromSuperview()
                date.removeFromSuperview()
                title.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
    }
}
