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
        toVC.view.alpha = 0
        container!.addSubview(toVC.view)
        container!.addSubview(bg)
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            bg.frame = toVC.view.frame
            toVC.view.alpha = 1
            bg.alpha = 0.95
            }) { (finish: Bool) -> Void in
                bg.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
    }

}
