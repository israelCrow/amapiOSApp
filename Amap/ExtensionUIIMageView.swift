//
//  ExtensionUIIMageView.swift
//  Amap
//
//  Created by Mac on 8/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

extension UIImageView {
  public func imageFromUrl(urlString: String) {
    
    let frameForActivity = CGRect.init(x: 0.0,
                                       y: 0.0,
                                   width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                  height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let activity = UIActivityIndicatorView.init(frame: frameForActivity)
    activity.center = self.center
    self.addSubview(activity)
    activity.startAnimating()
    
    let url = NSURL(string: urlString)
    dispatch_async(dispatch_get_main_queue()) {
      let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap
      activity.stopAnimating()
      activity.removeFromSuperview()
      
      dispatch_async(dispatch_get_main_queue(), {
        
        if data != nil {
        
          self.image = UIImage(data: data!)
        
        }
      })
    }//dispatch_async
    
//    if let url = NSURL(string: urlString) {
//      let request = NSURLRequest(URL: url)
//      let config  = NSURLSessionConfiguration.defaultSessionConfiguration()
//      let session = NSURLSession(configuration: config)
//      
//      let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
//        if error == nil && data != nil{
//          
//          activity.stopAnimating()
//          activity.removeFromSuperview()
//          self.image = UIImage(data: data!)
//          
//        }
//      })
//      task.resume()
//    }
  }
  
  public func imageFromUrlAndAdaptToSize(urlString: String) {
    
    let frameForActivity = CGRect.init(x: 0.0,
                                       y: 0.0,
                                       width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                       height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let activity = UIActivityIndicatorView.init(frame: frameForActivity)
    activity.center = self.center
    self.addSubview(activity)
    activity.startAnimating()
    
    let url = NSURL(string: urlString)
    
    dispatch_async(dispatch_get_main_queue()) {
      let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
      activity.stopAnimating()
      activity.removeFromSuperview()
      dispatch_async(dispatch_get_main_queue(), {
        let newImage = UIImage(data: data!)
        var finalImage: UIImage?
        
        if self.superview?.isKindOfClass(VideoPlayerVimeoYoutubeView) != nil {
          
          if newImage != nil {
            
            if newImage!.size.width > (295.0 * UtilityManager.sharedInstance.conversionWidth) {
              
              let factorOfTransformation = ((295.0 * UtilityManager.sharedInstance.conversionWidth) / newImage!.size.width)
              let newHeight = newImage!.size.height * factorOfTransformation
              let newWidth = newImage!.size.width * factorOfTransformation
              
              UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
              newImage!.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
              finalImage = UIGraphicsGetImageFromCurrentImageContext()
              UIGraphicsEndImageContext()
              
              let videoPlayerView = self.superview! as! VideoPlayerVimeoYoutubeView
              videoPlayerView.backgroundColor = UIColor.clearColor()
              let frameForVideoPlayer = CGRect.init(x: videoPlayerView.frame.origin.x,
                y: videoPlayerView.frame.origin.y,
                width: finalImage!.size.width,
                height: finalImage!.size.height)
              
              videoPlayerView.frame = frameForVideoPlayer
              let frameForMyself = CGRect.init(x: 0.0,
                y: 0.0,
                width: finalImage!.size.width,
                height: finalImage!.size.height)
              
              videoPlayerView.frame = frameForVideoPlayer
              self.frame = frameForMyself
              //                self.center = videoPlayerView.center
              
              //                UIView.animateWithDuration(0.35){
              //
              //                  videoPlayerView.frame = frameForVideoPlayer
              //
              //                }
              
              
            }else{
              
              let videoPlayerView = self.superview! as! VideoPlayerVimeoYoutubeView
              videoPlayerView.backgroundColor = UIColor.clearColor()
              finalImage = newImage
              
            }
            
          }else{
            
            finalImage = UIImage.init()
            
          }
          
        }else{
          
          finalImage = newImage
          
        }
        
        self.image = finalImage
        
        if self.image != nil {
        
          let imageSize: [String: UIImage] = ["image": self.image!]
        
          NSNotificationCenter.defaultCenter().postNotificationName("ReceiveImageSuccessfully", object: nil, userInfo: imageSize)
          
        } else {
          
          let imageSize: [String: String] = ["image": "No hay imagen"]
          
          NSNotificationCenter.defaultCenter().postNotificationName("ReceiveImageSuccessfully", object: nil, userInfo: imageSize)
          
        }
        
        
      })
    }//dispatch_async
  
  
//    let frameForActivity = CGRect.init(x: 0.0,
//                                       y: 0.0,
//                                       width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
//                                       height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
//    
//    let activity = UIActivityIndicatorView.init(frame: frameForActivity)
//    activity.center = self.center
//    self.addSubview(activity)
//    activity.startAnimating()
//    
//    if let url = NSURL(string: urlString) {
//      let request = NSURLRequest(URL: url)
//      let config  = NSURLSessionConfiguration.defaultSessionConfiguration()
//      let session = NSURLSession(configuration: config)
//      
//
//      
//      let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
//        if error == nil && data != nil{
//          
//          activity.stopAnimating()
//          activity.removeFromSuperview()
//          
//          let newImage = UIImage(data: data!)
//          var finalImage: UIImage?
//          
//          if self.superview?.isKindOfClass(VideoPlayerVimeoYoutubeView) != nil {
//            
//            if newImage != nil {
//            
//              if newImage!.size.width > (295.0 * UtilityManager.sharedInstance.conversionWidth) {
//              
//                let factorOfTransformation = (295.00 / newImage!.size.width)
//                let newHeight = newImage!.size.height * factorOfTransformation
//                let newWidth = newImage!.size.width * factorOfTransformation
//                
//                UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
//                newImage!.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
//                finalImage = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//                
//                let videoPlayerView = self.superview! as! VideoPlayerVimeoYoutubeView
//                let frameForVideoPlayer = CGRect.init(x: videoPlayerView.frame.origin.x,
//                  y: videoPlayerView.frame.origin.y,
//                  width: finalImage!.size.width,
//                  height: finalImage!.size.height)
//                
//                videoPlayerView.frame = frameForVideoPlayer
//                let frameForMyself = CGRect.init(x: 0.0,
//                  y: 0.0,
//                  width: finalImage!.size.width,
//                  height: finalImage!.size.height)
//                
//                videoPlayerView.frame = frameForVideoPlayer
//                self.frame = frameForMyself
////                self.center = videoPlayerView.center
//                
////                UIView.animateWithDuration(0.35){
////                 
////                  videoPlayerView.frame = frameForVideoPlayer
////                  
////                }
//                
//              
//              }else{
//                
//                let videoPlayerView = self.superview! as! VideoPlayerVimeoYoutubeView
//                videoPlayerView.backgroundColor = UIColor.clearColor()
//                finalImage = newImage
//                
//              }
//              
//            }else{
//              
//              finalImage = UIImage.init()
//              
//            }
//            
//          }else{
//            
//            finalImage = newImage
//            
//          }
//          
//          self.image = finalImage
//          
//        }
//      })
//      task.resume()
//    }
  }

}