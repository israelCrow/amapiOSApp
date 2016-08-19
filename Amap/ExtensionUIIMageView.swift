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
    if let url = NSURL(string: urlString) {
      let request = NSURLRequest(URL: url)
      let config  = NSURLSessionConfiguration.defaultSessionConfiguration()
      let session = NSURLSession(configuration: config)
      
      let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
        if error == nil && data != nil{
          self.image = UIImage(data: data!)
        }
      })
      task.resume()
    }
  }
}