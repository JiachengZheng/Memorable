//
//  JCListToDetailTransion.swift
//  Memorable
//
//  Created by zhengjiacheng on 16/1/8.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCListToDetailTransion: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //1.获取动画的源控制器和目标控制器
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! JCListVCL
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! JCEventDetailVCL
        let container = transitionContext.containerView()
        let bg = fromVC.cellImageView.snapshotViewAfterScreenUpdates(true)
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        bg.frame = container!.convertRect(fromVC.cellImageView.frame, fromView: fromVC.view)
        fromVC.view.frame = toVC.view.frame
        container!.addSubview(fromVC.view)
        container!.addSubview(toVC.view)
        container!.addSubview(bg)
        toVC.view.alpha = 0
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            bg.frame = toVC.view.frame
            }) { (finish: Bool) -> Void in
                toVC.view.alpha = 1
                fromVC.view.removeFromSuperview()
                bg.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
    }

}
