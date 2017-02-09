//
//  GraphAccordingToUserView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/14/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol GrapAccordingToUserViewDelegate {
  
  func getEvaluationsAveragePerMonth(params: [String: AnyObject], sender: GraphAccordingToUserView)
  func flipCardToShowFilterOfGraphAccordingToUser(sender: GraphAccordingToUserView)
  
}

class GraphAccordingToUserView: UIView, CustomTextFieldWithTitleAndPickerForDashboardViewDelegate {

  private var filterButton: UIButton! = nil
  private var selectorOfInformationView: CustomTextFieldWithTitleAndPickerForDashboardView! = nil
  private var genericGraph: GenericDashboardGraphic! = nil
  private var optionsForSelector = [String]()
  private var arrayOfAgencyUsersModelData = [AgencyUserModelData]()
  private var numberOfUserSelected = 0
  
  private var dropDownTitleText: String = ""
  
  var delegate: GrapAccordingToUserViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfUsers: [AgencyUserModelData]) {
    
    arrayOfAgencyUsersModelData = newArrayOfUsers
    
    super.init(frame: frame)
    
    self.addGestures()
    self.initValues()
    self.initInterface()
    
  }
  
  //Despite the model is AgencyUserModelData, the info is about the Brands of the Company
  init(frame: CGRect, newArrayOfUsers: [AgencyUserModelData], newDropDownTitleText: String) {
    
    dropDownTitleText = newDropDownTitleText
    arrayOfAgencyUsersModelData = newArrayOfUsers
    
    super.init(frame: frame)
    
    self.addGestures()
    self.initValues()
    self.initInterfaceForCompany()
    
  }
  
  private func addGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    tapToDismissKeyboard.cancelsTouchesInView = false
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func initValues() {
    
    for user in arrayOfAgencyUsersModelData {
      
      if user.email != "" {
      
        optionsForSelector.append(user.email)
      
      } else {
        
        optionsForSelector.append("user without email")
        
      }
      
    }
    
//    optionsForSelector = ["Performance General", "Usuario 1", "Usuario 2"]
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createFilterButton()
    self.createSelectorOfInformationView()
    
    self.createGraphic()

    
  }
  
  private func initInterfaceForCompany() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createFilterButton()
    self.createSelectorOfInformationViewWithTitle()
    
    self.createGraphic()
    
    
  }
    
  private func createFilterButton() {
    
    let frameForButton = CGRect.init(x: 262.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 9.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 21.0 * UtilityManager.sharedInstance.conversionHeight)
    
    filterButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconNavBarFilters") as UIImage?
    filterButton.setImage(image, forState: .Normal)
    filterButton.tag = 1
    filterButton.addTarget(self, action: #selector(filterButtonPressed), forControlEvents:.TouchUpInside)
    
    self.addSubview(filterButton)
    
  }
  
  private func createSelectorOfInformationView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 40.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    selectorOfInformationView = CustomTextFieldWithTitleAndPickerForDashboardView.init(frame: frameForView,
                                                                           textLabel: VisualizeDashboardConstants.GeneralPerformanceCardView.selectorLabelText,
                                                                           nameOfImage: "dropdown",
                                                                           newOptionsOfPicker: optionsForSelector)
    
    selectorOfInformationView.tag = 1
    selectorOfInformationView.delegate = self
    //    selectorOfInformationView.mainTextField.addTarget(self,
    //                                              action: #selector(howManyDaysToShowEdited),
    //                                              forControlEvents: .AllEditingEvents)
    self.addSubview(selectorOfInformationView)
    
  }
  
  private func createSelectorOfInformationViewWithTitle() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 40.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    selectorOfInformationView = CustomTextFieldWithTitleAndPickerForDashboardView.init(frame: frameForView,
                                                                                       textLabel: dropDownTitleText,
                                                                                       nameOfImage: "dropdown",
                                                                                       newOptionsOfPicker: optionsForSelector)
    
    selectorOfInformationView.tag = 1
    selectorOfInformationView.delegate = self
    //    selectorOfInformationView.mainTextField.addTarget(self,
    //                                              action: #selector(howManyDaysToShowEdited),
    //                                              forControlEvents: .AllEditingEvents)
    self.addSubview(selectorOfInformationView)
    
  }
  
  private func createGraphic() {
    
    let frameForGraph = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 145.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 285.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 260.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var barDescription = "Agencia"
    
    if UserSession.session.role == "4" || UserSession.session.role == "5"  {
      
      barDescription = MyCompanyModelData.Data.name
      
    }
    
    genericGraph = GenericDashboardGraphic.init(frame: frameForGraph,
                                  newDataForLineChart: [Double](),
                                   newDataForBarChart: [Double](),
                                     newValuesOfXAxis: nil,
                               newDescriptionBarGraph: barDescription,
                              newDescriptionLineGraph: nil)
    
    self.addSubview(genericGraph)
    
//    NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: #selector(changeData), userInfo: nil, repeats: false)
    
  }
  
  @objc func changeData(newValuesForUser: [Double], newValuesForAgency: [Double]) {
    
    let nameUser = optionsForSelector[numberOfUserSelected]
    
    genericGraph.changeValuesOfGraph(nameUser,
                                     newXValues: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
                               newLineGraphData: newValuesForUser,
                                newBarGraphData: newValuesForAgency)
    
  }
  
  
//  private func createYAxis(quantityOfLines: Int) {
//    
//    let distanceBetweenLines: CGFloat = (207.0 / CGFloat(quantityOfLines)) * UtilityManager.sharedInstance.conversionWidth
//    
//    var frameForLines = CGRect.init(x: 53.0 * UtilityManager.sharedInstance.conversionWidth,
//                                    y: 13.0 * UtilityManager.sharedInstance.conversionHeight,
//                                    width: 1.0 * UtilityManager.sharedInstance.conversionWidth,
//                                    height: 198.0 * UtilityManager.sharedInstance.conversionHeight)
//    
//    var border: CALayer
//    let width = CGFloat(1)
//    
//    for i in 1...quantityOfLines {
//      
//      border = CALayer()
//      border.borderColor = UIColor.darkGrayColor().CGColor
//      border.borderWidth = width
//      border.frame = frameForLines
//      self.layer.addSublayer(border)
//      
//      self.createLabelForYAxis(String(i), baseFrame: frameForLines)
//      frameForLines = CGRect.init(x: frameForLines.origin.x + distanceBetweenLines,
//                                  y: frameForLines.origin.y,
//                                  width: frameForLines.size.width,
//                                  height: frameForLines.size.height)
//      
//      
//    }
//    
//  }
  
  @objc private func filterButtonPressed() {
    
    self.delegate?.flipCardToShowFilterOfGraphAccordingToUser(self)
    
  }
  
  //MARK: - CustomTextFieldWithTitleAndPickerForDashboardViewDelegate
  
  func userSelected(numberOfElementInArrayOfUsers: Int) {
    
    if arrayOfAgencyUsersModelData[numberOfElementInArrayOfUsers].id != nil {
    
      numberOfUserSelected = numberOfElementInArrayOfUsers
      
      let params: [String: AnyObject] = [
        "id": arrayOfAgencyUsersModelData[numberOfElementInArrayOfUsers].id,
        "auth_token": UserSession.session.auth_token
      ]
      
      self.delegate?.getEvaluationsAveragePerMonth(params, sender: self)
      
    }
    
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.endEditing(true)
    
  }
  
}
