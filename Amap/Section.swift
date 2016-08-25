//
//  Section.swift
//  Amap
//
//  Created by Mac on 8/15/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

struct Section {
  var name: String!
  var skills: [Skill]!
  var collapsed: Bool!
  
  init(name: String, skills: [Skill], collapsed: Bool = true) {
    self.name = name
    self.skills = skills
    self.collapsed = collapsed
  }
}