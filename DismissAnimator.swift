//
//  DismissAnimator.swift
//  InteractiveModal
//
//  Created by Caleb Stultz on 3/11/16.
//  Copyright © 2016 Thorn Technologies. All rights reserved.
//


import UIKit

class DismissAnimator : NSObject {
}

var mainViewController = ViewController()

extension DismissAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let containerView = transitionContext.containerView()
            else {
                return
        }
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        let screenBounds = UIScreen.mainScreen().bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            animations: {
                fromVC.view.frame = finalFrame
            },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                UIApplication.sharedApplication().keyWindow!.addSubview(toVC.view)
                UIApplication.sharedApplication().keyWindow!.sendSubviewToBack(toVC.view)
            }
    )}
}

