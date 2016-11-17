//
//  CreateCaseView.swift
//  Amap
//
//  Created by Mac on 8/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CreateCaseViewDelegate {
  
  func createCaseRequest(parameters: [String: AnyObject])
  func cancelCreateCase()
  func updateCaseRequest(parameters: [String: AnyObject], caseID: String)
  func selectCaseImageFromLibrary()
  func askingForDeleteCaseImage()
  
}

class CreateCaseView: UIView, UITextFieldDelegate, UITextViewDelegate, VideoPlayerVimeoYoutubeViewDelegate{
  
  private var cancelCreateButton: UIButton! = nil
  private var saveCaseButton: UIButton! = nil
  private var mainScrollView: UIScrollView! = nil
  private var containerView: UIView! = nil
  private var caseImage: UIImage?
  private var caseNameView: CustomTextFieldWithTitleView! = nil
  private var caseDescriptionTextView: UITextView! = nil
  private var clearButton: UIButton! = nil
  private var addImageLabel: UILabel! = nil
  private var caseImageView: UIImageView! = nil
  private var caseVideoPlayerVimeoYoutube: VideoPlayerVimeoYoutubeView! = nil
  private var previewVideoPlayerVimeoYoutube: PreviewVimeoYoutubeView! = nil
  private var caseWebLinkView: CustomTextFieldWithTitleView! = nil
  private var errorInFieldsLabel: UILabel! = nil
  private var isDownContentView: Bool = false
  
  var isBeingShown: Bool! = nil
  
  private var caseDataForPreview: Case! = nil
  
  var delegate: CreateCaseViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    isBeingShown = true
    
    super.init(frame: frame)
    
    self.addSomeGestures()
    self.initInterface()
    
  }
  
  init(frame: CGRect, caseData: Case){
  
    caseDataForPreview = caseData
    
    super.init(frame: frame)
  
    self.addSomeGestures()
    self.initInterfaceForPreview()
  
  }
  
  private func addSomeGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    self.userInteractionEnabled = true
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createCancelCreateButton()
    self.createSaveCaseButton()
    self.createMainScrollView()
    self.createContainerView()
    self.createCaseNameView()
    self.createCaseDescriptionTextView()
    self.createAddImageLabel()
    self.createCaseVideoPlayerVimeoYoutubeWithoutURL()
    self.createCaseWebLinkView()
    self.createErrorInFieldsLabel()
    
  }
  
  private func initInterfaceForPreview() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createCancelCreateButton()
    self.createSaveCaseButtonForPreview()
    self.createMainScrollView()
    self.createContainerView()
    self.createCaseNameViewForPreview()
    self.createCaseDescriptionTextViewForPreview()
    self.createAddImageLabelForPreview()
    self.createPreviewVideoPlayerVimeoYoutube()
    self.createCaseWebLinkViewForPreview()
    self.createErrorInFieldsLabel()
    
  }
  
  private func createCancelCreateButton() {
    
    let frameForButton = CGRect.init(x:270.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 10.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 15.0 * UtilityManager.sharedInstance.conversionWidth ,
                                height: 15.0 * UtilityManager.sharedInstance.conversionHeight)
    
    cancelCreateButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconCloseBlack") as UIImage?
    cancelCreateButton.setImage(image, forState: .Normal)
    cancelCreateButton.alpha = 1.0
    cancelCreateButton.addTarget(self, action: #selector(cancelCreateCase), forControlEvents:.TouchUpInside)
    
    self.addSubview(cancelCreateButton)
    
  }
  
  private func createSaveCaseButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringForSaveButton = "Crea caso"
    
    let stringWithFormat = NSMutableAttributedString(
      string: stringForSaveButton ,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: stringForSaveButton,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0, y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight), width: self.frame.size.width, height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    saveCaseButton = UIButton.init(frame: frameForButton)
    saveCaseButton.addTarget(self,
                         action: #selector(requestCreateCase),
                         forControlEvents: .TouchUpInside)
    saveCaseButton.backgroundColor = UIColor.blackColor()
    saveCaseButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    saveCaseButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.addSubview(saveCaseButton)
    
  }
  
  private func createSaveCaseButtonForPreview() {
  
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringForSaveButton = "Salvar cambios"
    
    let stringWithFormat = NSMutableAttributedString(
      string: stringForSaveButton ,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: stringForSaveButton,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0, y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight), width: self.frame.size.width, height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    saveCaseButton = UIButton.init(frame: frameForButton)
    saveCaseButton.addTarget(self,
                             action: #selector(requestSaveEditCase),
                             forControlEvents: .TouchUpInside)
    saveCaseButton.backgroundColor = UIColor.blackColor()
    saveCaseButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    saveCaseButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.addSubview(saveCaseButton)
  
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 40.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 419.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let newContentSize = CGSize.init(width: frameForMainScrollView.size.width,
                                    height: frameForMainScrollView.size.height + (65.0 * UtilityManager.sharedInstance.conversionHeight))
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.showsVerticalScrollIndicator = true
    mainScrollView.contentSize = newContentSize
    mainScrollView.scrollEnabled = false
    mainScrollView.backgroundColor = UIColor.whiteColor()
    self.addSubview(mainScrollView)
    
  }
  
  private func createContainerView() {
    
    let frameForContainerView = CGRect.init(x: 0.0,
                                            y: 0.0,
                                        width: mainScrollView.frame.size.width,
                                       height: mainScrollView.frame.size.height)
    
    containerView = UIView.init(frame: frameForContainerView)
    containerView.backgroundColor = UIColor.clearColor()
    mainScrollView.addSubview(containerView)
    
    
  }
  
  private func createCaseNameView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: self.frame.size.width,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseNameView = CustomTextFieldWithTitleView.init(frame: frameForCustomView, title: nil, image: nil)
    caseNameView.mainTextField.placeholder = "Nombre del caso"
    caseNameView.backgroundColor = UIColor.clearColor()
    caseNameView.mainTextField.delegate = self
    self.containerView.addSubview(caseNameView)
    
  }
  
  private func createCaseNameViewForPreview() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: self.frame.size.width,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseNameView = CustomTextFieldWithTitleView.init(frame: frameForCustomView, title: nil, image: nil)
    caseNameView.mainTextField.text = caseDataForPreview.name
    caseNameView.mainTextField.userInteractionEnabled = true
    caseNameView.backgroundColor = UIColor.clearColor()
    caseNameView.mainTextField.delegate = self
    self.containerView.addSubview(caseNameView)
    print()
  }
  
  private func createCaseDescriptionTextView() {
    
    let frameForTextView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 57.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 82.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseDescriptionTextView = UITextView.init(frame: frameForTextView)
    caseDescriptionTextView.tag = 1
    caseDescriptionTextView.backgroundColor = UIColor.whiteColor()
    caseDescriptionTextView.font = UIFont(name:"SFUIText-Regular",
                                        size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    caseDescriptionTextView.text = "Descripción del caso"
    caseDescriptionTextView.textColor = UIColor.lightGrayColor()
    caseDescriptionTextView.delegate = self

    self.containerView.addSubview(caseDescriptionTextView)
    
    self.createCancelButtonForNameTextView()
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: 139.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 220 * UtilityManager.sharedInstance.conversionWidth,
                               height: 0.5)
    containerView.layer.addSublayer(border)
    containerView.layer.masksToBounds = true
    
   
    
  }
  
  private func createCaseDescriptionTextViewForPreview() {
    
    let frameForTextView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                       y: 57.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                       height: 82.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseDescriptionTextView = UITextView.init(frame: frameForTextView)
    caseDescriptionTextView.tag = 1
    caseDescriptionTextView.backgroundColor = UIColor.whiteColor()
    caseDescriptionTextView.font = UIFont(name:"SFUIText-Regular",
                                          size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    caseDescriptionTextView.text = caseDataForPreview.description!
    caseDescriptionTextView.userInteractionEnabled = true
    caseDescriptionTextView.textColor = UIColor.blackColor()
    caseDescriptionTextView.delegate = self
    
    self.containerView.addSubview(caseDescriptionTextView)
    
    self.createCancelButtonForNameTextView()
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: 139.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 220 * UtilityManager.sharedInstance.conversionWidth,
                               height: 0.5)
    containerView.layer.addSublayer(border)
    containerView.layer.masksToBounds = true

  }
  
  private func createCancelButtonForNameTextView() {
    let frameForButton = CGRect.init(x:caseDescriptionTextView.frame.origin.x + caseDescriptionTextView.frame.size.width - (20.0 * UtilityManager.sharedInstance.conversionWidth),
                                     y: caseDescriptionTextView.frame.origin.y,
                                     width: 20.0 * UtilityManager.sharedInstance.conversionWidth ,
                                     height: 20.0 * UtilityManager.sharedInstance.conversionHeight)
    clearButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "deleteButton") as UIImage?
    clearButton.setImage(image, forState: .Normal)
    clearButton.tag = 1
    clearButton.alpha = 0.0
    clearButton.addTarget(self, action: #selector(deleteNameTextView), forControlEvents:.TouchUpInside)
    
    caseDescriptionTextView.addSubview(clearButton)
  }
  
  private func createAddImageLabel() {
    
    addImageLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Medium",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.25)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.CreateCaseView.caseAddImageLabelText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    addImageLabel.attributedText = stringWithFormat
    addImageLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: (160 * UtilityManager.sharedInstance.conversionHeight),
                               width: addImageLabel.frame.size.width,
                               height: addImageLabel.frame.size.height)
    
    addImageLabel.frame = newFrame
    
    self.containerView.addSubview(addImageLabel)
    
  }
  
  private func createAddImageLabelForPreview() {
    
    addImageLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Medium",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.25)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Imagen/Video del caso",
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    addImageLabel.attributedText = stringWithFormat
    addImageLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: (160 * UtilityManager.sharedInstance.conversionHeight),
                               width: addImageLabel.frame.size.width,
                               height: addImageLabel.frame.size.height)
    
    addImageLabel.frame = newFrame
    
    self.containerView.addSubview(addImageLabel)
    
  }
  
  private func createCaseImageView() {
    
    let frameForCaseImageView = CGRect.init(x: 0.0,
                                          y: addImageLabel.frame.origin.y + addImageLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                          width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                          height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseImageView = UIImageView.init(frame: frameForCaseImageView)
    caseImageView.backgroundColor = UIColor.redColor()
    caseImageView.layer.masksToBounds = false
    
    containerView.addSubview(caseImageView)
    
  }

  private func createCaseWebLinkView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 322.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseWebLinkView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                        title: AgencyProfileEditConstants.CreateCaseView.caseWebLinkLabelText,
                                                        image: nil)
    caseWebLinkView.mainTextField.placeholder = "http://www.ejemplo.com"
    caseWebLinkView.backgroundColor = UIColor.clearColor()
    caseWebLinkView.mainTextField.delegate = self
    caseWebLinkView.mainTextField.tag = 8
    self.containerView.addSubview(caseWebLinkView)
    
  }
  
  private func createCaseWebLinkViewForPreview() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 322.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseWebLinkView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                        title: "Link del caso",
                                                        image: nil)
    caseWebLinkView.mainTextField.text = (caseDataForPreview.url != nil ? caseDataForPreview.url! : nil)
    caseWebLinkView.mainTextField.userInteractionEnabled = true
    caseWebLinkView.backgroundColor = UIColor.clearColor()
    caseWebLinkView.mainTextField.delegate = self
    caseWebLinkView.mainTextField.tag = 8
    self.containerView.addSubview(caseWebLinkView)
    
  }

  
  private func createErrorInFieldsLabel() {
    
    errorInFieldsLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.redColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Nombre, descripción y link obligatorios",
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    errorInFieldsLabel.attributedText = stringWithFormat
    errorInFieldsLabel.sizeToFit()
    let newFrame = CGRect.init(x: (containerView.frame.size.width / 2.0) - (errorInFieldsLabel.frame.size.width / 2.0),
                               y: 400.0 * UtilityManager.sharedInstance.conversionHeight,
                           width: errorInFieldsLabel.frame.size.width,
                          height: errorInFieldsLabel.frame.size.height)
    
    errorInFieldsLabel.frame = newFrame
    errorInFieldsLabel.alpha = 0.0
    self.containerView.addSubview(errorInFieldsLabel)
    
  }
  
  //Called at the beggining or without text
  private func createCaseVideoPlayerVimeoYoutubeWithoutURL() {
    
    var lastFrameOfCaseVideoPlayer: CGRect? = nil
    
    if caseVideoPlayerVimeoYoutube != nil { //caseVideoPlayer exists
      
      if caseVideoPlayerVimeoYoutube.existsImage == false { //and no exists image selected
        
        lastFrameOfCaseVideoPlayer = caseVideoPlayerVimeoYoutube.frame
        
        caseVideoPlayerVimeoYoutube.layer.removeAllAnimations()
        caseVideoPlayerVimeoYoutube.layer.removeFromSuperlayer()
        caseVideoPlayerVimeoYoutube = nil
        
        caseVideoPlayerVimeoYoutube = VideoPlayerVimeoYoutubeView.init(frame: lastFrameOfCaseVideoPlayer!, url: nil)
        caseVideoPlayerVimeoYoutube.delegate = self
        self.containerView.addSubview(caseVideoPlayerVimeoYoutube)
        
      }
    
    } else { //when caseVideoPlayer is nil
      
      if lastFrameOfCaseVideoPlayer == nil {
        
        let frameForVideoPlayer = CGRect.init(x: 0.0,
                                              y: addImageLabel.frame.origin.y + addImageLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                              width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                              height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
        
        caseVideoPlayerVimeoYoutube = VideoPlayerVimeoYoutubeView.init(frame: frameForVideoPlayer, url: nil)
        caseVideoPlayerVimeoYoutube.delegate = self
        
        if caseVideoPlayerVimeoYoutube.deleteCaseImageButton != nil {
          
          caseVideoPlayerVimeoYoutube.deleteCaseImageButton.alpha = 0.0
          
        }
        
        
        
        let tapForAddImage = UITapGestureRecognizer.init(target: self, action: #selector(selectImageForCaseFromLibrary))
        tapForAddImage.numberOfTapsRequired = 1
        caseVideoPlayerVimeoYoutube.addGestureRecognizer(tapForAddImage)

        self.containerView.addSubview(caseVideoPlayerVimeoYoutube)
        
      } else { //supposedly never get this else
        
        caseVideoPlayerVimeoYoutube = VideoPlayerVimeoYoutubeView.init(frame: lastFrameOfCaseVideoPlayer!, url: nil)
        caseVideoPlayerVimeoYoutube.delegate = self
        self.containerView.addSubview(caseVideoPlayerVimeoYoutube)
        
      }
      
    }
    

    
  }
  
  //Called when user writes down the case web link
  
  private func createCaseVideoPlayerVimeoYoutube(url: String) {
    
    var lastFrameOfCaseVideoPlayer: CGRect? = nil
    
    let isYoutubeOrVimeoLink = UtilityManager.sharedInstance.validateIfLinkIsVimeo(url) || UtilityManager.sharedInstance.validateIfLinkIsYoutube(url)
    
    if isYoutubeOrVimeoLink == true {
      
      if caseVideoPlayerVimeoYoutube != nil { //caseVideoPlayer exists
        
        
        lastFrameOfCaseVideoPlayer = caseVideoPlayerVimeoYoutube.frame
        
        caseVideoPlayerVimeoYoutube.layer.removeAllAnimations()
        caseVideoPlayerVimeoYoutube.layer.removeFromSuperlayer()
        caseVideoPlayerVimeoYoutube = nil
        
        caseVideoPlayerVimeoYoutube = VideoPlayerVimeoYoutubeView.init(frame: lastFrameOfCaseVideoPlayer!, url: url)
        caseVideoPlayerVimeoYoutube.delegate = self
        self.containerView.addSubview(caseVideoPlayerVimeoYoutube)
        
        
        
      } else {
        
        let frameForVideoPlayer = CGRect.init(x: 0.0,
                                              y: addImageLabel.frame.origin.y + addImageLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                              width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                              height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
        
        caseVideoPlayerVimeoYoutube = VideoPlayerVimeoYoutubeView.init(frame: frameForVideoPlayer, url: url)
        caseVideoPlayerVimeoYoutube.delegate = self
        self.containerView.addSubview(caseVideoPlayerVimeoYoutube)
        
      }
      
    }
    
  }
  
  private func createPreviewVideoPlayerVimeoYoutube() {
    
    if previewVideoPlayerVimeoYoutube != nil {
      
      previewVideoPlayerVimeoYoutube.layer.removeAllAnimations()
      previewVideoPlayerVimeoYoutube.layer.removeFromSuperlayer()
      previewVideoPlayerVimeoYoutube = nil
      
    }
    
    let frameForVideoPlayer = CGRect.init(x: 0.0,
                                          y: addImageLabel.frame.origin.y + addImageLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                          width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                          height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
    
    previewVideoPlayerVimeoYoutube = PreviewVimeoYoutubeView.init(frame: frameForVideoPlayer,
caseInfo: caseDataForPreview, showButtonsOfEdition: true)
    
    self.containerView.addSubview(previewVideoPlayerVimeoYoutube)
    
  }
  
  
  
  func changeCaseImageView(newImage: UIImage) {
    
    caseImage = newImage
    self.caseVideoPlayerVimeoYoutube.changeImageOfCase(newImage)
    if caseVideoPlayerVimeoYoutube.deleteCaseImageButton != nil {
      
      caseVideoPlayerVimeoYoutube.deleteCaseImageButton.alpha = 1.0
      
    }
    
    
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {

    
    if textField.tag == 8 {
      
      let textChecked = textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
      
      if textChecked != nil && textChecked != "" {
        
        createCaseVideoPlayerVimeoYoutube(textChecked!)
        
      } else {
        
        createCaseVideoPlayerVimeoYoutubeWithoutURL()
        
      }
      
    }
    
    return true
    
  }
  
  func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    
    if textField.tag == 8 {
      
      let textChecked = textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
      
      if textChecked != nil && textChecked != "" {
        
        createCaseVideoPlayerVimeoYoutube(textChecked!)
        
      } else {
        
        createCaseVideoPlayerVimeoYoutubeWithoutURL()
        
      }
      
    }
    
    return true
    
  }
  
  private func showErrorInFieldsLabel() {
  
    if errorInFieldsLabel.alpha == 0.0 {
      UIView.animateWithDuration(0.35){
        self.errorInFieldsLabel.alpha = 1.0
      }
    }
  
  }
  
  private func hideErrorInFieldsLabel() {
    
    if errorInFieldsLabel.alpha == 1.0 {
      UIView.animateWithDuration(0.35){
        self.errorInFieldsLabel.alpha = 0.0
      }
    }
    
  }
  
  private func showClearButton() {
    
    if clearButton.alpha == 0.0 {
      UIView.animateWithDuration(0.35){
        self.clearButton.alpha = 1.0
      }
    }
    
  }
  
  private func hideClearButton() {
    
    if clearButton.alpha == 1.0 {
      UIView.animateWithDuration(0.35){
        self.clearButton.alpha = 0.0
      }
    }
    
  }
  
  @objc private func deleteNameTextView() {
    
    caseDescriptionTextView.text = ""
    self.hideClearButton()
    
  }
  
  //MARK - UITextDelegate
  
  func textFieldDidBeginEditing(textField: UITextField) {
    
    if textField.tag == 8 {
      
      self.moveDownContainerViewForLinkTextField()
      
    }else{
      
      self.moveDownContainerView()
      
    }
    
    
    self.hideErrorInFieldsLabel()
    
  }
  
  func textViewDidBeginEditing(textView: UITextView) {
  
    self.hideErrorInFieldsLabel()
    
    if textView.tag == 1 {
      
      self.removePlaceHolderOfTextView(textView)
      self.showClearButton()
      
    }
  }
  
  func textViewShouldBeginEditing(textView: UITextView) -> Bool {
    
    self.moveDownContainerView()
    
    return true
    
  }
  
  func textViewDidEndEditing(textView: UITextView) {
    
    if textView.tag == 1 {
      
      self.setPlaceHolderOfTextView(textView)
      if textView.text != "Descripción del caso" {
      
        self.showClearButton()
        
      }
    }
  }
  
  func textViewDidChange(textView: UITextView) {
    
    self.moveDownContainerView()
    
    if textView.tag == 1 {
      
      self.showClearButton()
      
    }
    
  }
  
  private func removePlaceHolderOfTextView(textView: UITextView) {
    
    if textView.text == "Descripción del caso" {
      
      textView.text = ""
      textView.textColor = UIColor.blackColor()
      
    }
  }
  
  private func setPlaceHolderOfTextView(textView: UITextView) {
   
    if textView.text == "" {
      
      textView.text = "Descripción del caso"
      textView.textColor = UIColor.lightGrayColor()
      self.hideClearButton()
      
    }
    
  }
  
  @objc private func cancelCreateCase() {
   
    self.delegate?.cancelCreateCase()
    
  }
  
  private func moveDownContainerViewForLinkTextField() {
    
    if isDownContentView == false {
      
      let newFrameForContainerView = CGRect.init(x: containerView.frame.origin.x,
                                                 y: containerView.frame.origin.y - (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                                 width: containerView.frame.size.width,
                                                 height: containerView.frame.size.height)
      
      UIView.animateWithDuration(0.1,
                                 animations: {
                                  self.containerView.frame = newFrameForContainerView
      }) { (finished) in
        if finished == true {
          
          self.mainScrollView.scrollEnabled = true
          self.isDownContentView = true
          
        }
      }
    }
    
  }
  
  private func moveDownContainerView() {
    
    if isDownContentView == false {
      
      let newFrameForContainerView = CGRect.init(x: containerView.frame.origin.x,
                                                 y: containerView.frame.origin.y + (53.5 * UtilityManager.sharedInstance.conversionHeight),
                                                 width: containerView.frame.size.width,
                                                 height: containerView.frame.size.height)
      
      UIView.animateWithDuration(0.1,
                                 animations: {
                                  self.containerView.frame = newFrameForContainerView
      }) { (finished) in
        if finished == true {
          
          self.mainScrollView.scrollEnabled = true
          self.isDownContentView = true
          
        }
      }
    }

  }
  
  func moveUpContainerView() {
    
    if isDownContentView == true {
      
      let newFrameForContainerView = CGRect.init(x: containerView.frame.origin.x,
                                                 y: 0.0,
                                                 width: containerView.frame.size.width,
                                                 height: containerView.frame.size.height)
      
      UIView.animateWithDuration(0.1,
                                 animations: {
                                  self.containerView.frame = newFrameForContainerView
      }) { (finished) in
        if finished == true {
          
          self.mainScrollView.setContentOffset(CGPointZero, animated: true)
          self.mainScrollView.scrollEnabled = false
          self.isDownContentView = false
          
        }
      }
    }
  }
  
  @objc private func requestSaveEditCase() {
    
    let isNameOk = UtilityManager.sharedInstance.isValidText(caseNameView.mainTextField.text!)
    let isDescriptionOk = UtilityManager.sharedInstance.isValidText(caseDescriptionTextView.description)
    let isURLOk = UIApplication.sharedApplication().canOpenURL(NSURL.init(string: caseWebLinkView.mainTextField.text!)!)
    let doesExistImage: Bool
    if caseImage != nil {
      doesExistImage = true
    }else{
      doesExistImage = false
    }
    
    if (isNameOk == true && isDescriptionOk == true && isURLOk == true) {
      
      self.disableAllElements()
      
      var params = [String:AnyObject]()
      let caseName: String = caseNameView.mainTextField.text!
      let caseDescription: String = caseDescriptionTextView.text
      let caseWebLink: String = caseWebLinkView.mainTextField.text!
      
      if doesExistImage ==  false {
        
        params = [
          "auth_token" : UserSession.session.auth_token,
          "filename" : (AgencyModel.Data.name != nil ? "\(AgencyModel.Data.name).png" : "AgenciaID\(UserSession.session.agency_id).png"),
          "success_case" :
            ["name" : caseName,
              "description" : caseDescription,
              "url" : caseWebLink,
              "agency_id" : UserSession.session.agency_id
          ]
        ]
      }else{
        
        let dataImage = UIImagePNGRepresentation(caseImage!)
        
        params = [
          "auth_token" : UserSession.session.auth_token,
          "filename" : (AgencyModel.Data.name != nil ? "\(AgencyModel.Data.name).png" : "AgenciaID\(UserSession.session.agency_id).png"),
          "success_case" :
            [
              "case_image" : dataImage!,
              "name" : caseName,
              "description" : caseDescription,
              "url" : caseWebLink,
              "agency_id" : UserSession.session.agency_id
          ]
        ]
      }
      
      self.hideErrorInFieldsLabel()
      self.delegate?.updateCaseRequest(params, caseID: caseDataForPreview.id)
      
    } else {
      
      self.showErrorInFieldsLabel()
      
    }

    
  }
  
  @objc private func requestCreateCase() {
    
    let finalUrl = self.transformURL()
    let isURLOk = UIApplication.sharedApplication().canOpenURL(NSURL.init(string: finalUrl)!)
    
    let isNameOk = UtilityManager.sharedInstance.isValidText(caseNameView.mainTextField.text!)
    let isDescriptionOk = UtilityManager.sharedInstance.isValidText(caseDescriptionTextView.description)
    let doesExistImage: Bool
    if caseImage != nil {
      doesExistImage = true
    }else{
      doesExistImage = false
    }
    

    
    
    if (isNameOk == true && isDescriptionOk == true && isURLOk == true) {
      
      UtilityManager.sharedInstance.showLoader()
      
      self.disableAllElements()
      
      var params = [String:AnyObject]()
      let caseName: String = caseNameView.mainTextField.text!
      let caseDescription: String = caseDescriptionTextView.text
      let caseWebLink: String = finalUrl
      
      if doesExistImage ==  false {

        params = [
          "auth_token" : UserSession.session.auth_token,
          "filename" : (AgencyModel.Data.name != nil ? "\(AgencyModel.Data.name).png" : "AgenciaID\(UserSession.session.agency_id).png"),
          "success_case" :
                           ["name" : caseName,
                     "description" : caseDescription,
                             "url" : caseWebLink,
                       "agency_id" : UserSession.session.agency_id
                           ]
        ]
      }else{
        
        let dataImage = UIImagePNGRepresentation(caseImage!)
        
        params = [
          "auth_token" : UserSession.session.auth_token,
          "filename" : (AgencyModel.Data.name != nil ? "\(AgencyModel.Data.name).png" : "AgenciaID\(UserSession.session.agency_id).png"),
          "success_case" :
            [
            "case_image" : dataImage!,
                  "name" : caseName,
           "description" : caseDescription,
                   "url" : caseWebLink,
             "agency_id" : UserSession.session.agency_id
          ]
        ]
      }
      
      self.hideErrorInFieldsLabel()
      self.delegate?.createCaseRequest(params)
      
    } else {
      
      self.showErrorInFieldsLabel()
      
    }
  }
  
  private func transformURL() -> String {
    
    let isURLOk = UIApplication.sharedApplication().canOpenURL(NSURL.init(string: caseWebLinkView.mainTextField.text!)!)
    
    var finalURL = caseWebLinkView.mainTextField.text!
    
    if isURLOk == false {
      
      if finalURL.rangeOfString("www.") == nil {
        
        finalURL = "www." + finalURL
        
      }
      if finalURL.rangeOfString("http://") == nil {
        
        finalURL = "http://" + finalURL
        
      }
      
    }
    
    return finalURL
    
  }
  
  private func disableAllElements() {
    
    cancelCreateButton.userInteractionEnabled = false
    saveCaseButton.userInteractionEnabled = false
    caseDescriptionTextView.userInteractionEnabled = false
    clearButton.userInteractionEnabled = false
    
    if caseVideoPlayerVimeoYoutube != nil {
      
      caseVideoPlayerVimeoYoutube.userInteractionEnabled = false
      
    }
    
    if previewVideoPlayerVimeoYoutube != nil {
      
      previewVideoPlayerVimeoYoutube.userInteractionEnabled = false
      
    }
    
    caseWebLinkView.userInteractionEnabled = false
    
  
//    private var caseDescriptionTextView: UITextView! = nil
//    private var clearButton: UIButton! = nil
//    private var addImageLabel: UILabel! = nil
//    private var caseImageView: UIImageView! = nil
//    private var changeCaseImageButton: UIButton! = nil
//    private var caseVideoPlayerVimeoYoutube: VideoPlayerVimeoYoutubeView! = nil
//    private var previewVideoPlayerVimeoYoutube: PreviewVimeoYoutubeView! = nil
//    private var caseWebLinkView: CustomTextFieldWithTitleView! = nil
//    private var errorInFieldsLabel: UILabel! = nil
    
  }
  
  @objc func dismissKeyboard(sender:AnyObject) {
    
    self.endEditing(true)
    self.moveUpContainerView()
    
  }
  
  func deleteImageOfNewCase() {
    
    self.caseVideoPlayerVimeoYoutube.deleteImageOfCase()
    if caseVideoPlayerVimeoYoutube.deleteCaseImageButton != nil {
      
      caseVideoPlayerVimeoYoutube.deleteCaseImageButton.alpha = 0.0
      
    }
    
  }

  //MARK: - VideoPlayerVimeoYoutubeDelegate
  
  @objc func selectImageForCaseFromLibrary() {
    
    self.moveUpContainerView()
      
    self.delegate?.selectCaseImageFromLibrary()
    
  }
  
  func askForDeleteCaseImage() {
    
    self.delegate?.askingForDeleteCaseImage()
    
  }
  
  
}
