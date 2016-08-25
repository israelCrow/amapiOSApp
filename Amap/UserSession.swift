//
//  UserSession.swift
//  Amap
//
//  Created by Mac on 8/24/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class UserSession: NSObject {
  
  static let session = UserSession()
  
  var id: String! = nil
  var auth_token: String! = nil
  var rol: String! = nil
  var first_name: String?
  var last_name: String?
  var email: String! = nil
  var is_member_amap: Bool! = nil
  var agency_id: String! = nil

}