//
//  VisualizePitchCardDetailViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/10/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class VisualizePitchCardDetailViewController: UIViewController {
  
  private var tabBarAtBottom: UITabBar! = nil
  private var mainScrollView: UIScrollView! = nil
  private var detailedNavigation: DetailedNavigationEvaluatPitchView! = nil
  private var graphPartPitch: GraphPartPitchCardView! = nil
  
  private var pitchEvaluationByUserData: PitchEvaluationByUserModelData! = nil
 
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(newPitchEvaluationByUserData: PitchEvaluationByUserModelData) {
    
    pitchEvaluationByUserData = newPitchEvaluationByUserData
    
    super.init(nibName: nil, bundle: nil)
    
  }
  
  override func loadView() {

    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.whiteColor()
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
//    self.createTabBarAtBottom()
//    self.createMainScrollView()
//    self.createDetailedNavigation()
//    self.createGraphPartPitch()
    
  }
  
  
}
