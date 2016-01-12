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
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! JCListVCL
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! JCEventDetailVCL
        let container = transitionContext.containerView()
        
        let bg = fromVC.cellImageView.snapshotViewAfterScreenUpdates(false)
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        
        bg.frame = container!.convertRect(fromVC.cellImageView.frame, fromView: fromVC.view)
    
        container!.addSubview(toVC.view)
        container!.addSubview(bg)
        toVC.view.alpha = 0
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            bg.frame = toVC.view.frame
            }) { (finish: Bool) -> Void in
                toVC.view.alpha = 1
                bg.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
    }

}
