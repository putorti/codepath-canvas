//
//  CanvasViewController.swift
//  canvas
//
//  Created by Jason Putorti on 2/17/16.
//  Copyright © 2016 Jason Putorti. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet var canvasView: UIView!
    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var trayArrow: UIImageView!
    
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(sender: AnyObject) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
        } else if sender.state == UIGestureRecognizerState.Changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            let velocity = sender.velocityInView(view)
            
            if velocity.y > 0 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.trayView.center = self.trayDown
                })
                // rotate tray arrow
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.trayView.center = self.trayUp
                })
                // rotate tray arrow
            }
        }
        
    }
    
    func didPinchNewFace(sender: UIPinchGestureRecognizer) {
        // get the scale value from the pinch gesture recognizer
        let scale = sender.scale
        let imageView = sender.view as! UIImageView
        imageView.transform = CGAffineTransformScale(imageView.transform, scale, scale)
        sender.scale = 1
    }
    
    @IBAction func didPanFace(sender: AnyObject) {
        
        var translation = sender.translationInView(view)
        var imageView = sender.view as! UIImageView
        
        if sender.state == UIGestureRecognizerState.Began {
            
            print("didPanFace: Begin")
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            // add pinch recognizer to new face somehow

        } else if sender.state == UIGestureRecognizerState.Changed {
            
            print("didPanFace: Changed to", translation)
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("didPanFace: Ended")
            
        }
  
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
