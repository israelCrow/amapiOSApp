//
//  PreviewVimeoYoutubeView.swift
//  Amap
//
//  Created by Mac on 8/22/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import YouTubePlayer
import YTVimeoExtractor
import AVKit
import AVFoundation

protocol PreviewVimeoYoutubeViewDelegate {
  
  func editSelectedCase(caseData: Case)
  func deleteSelectedCase(caseData: Case)
  
}

class PreviewVimeoYoutubeView: UIView {
  
  private var caseData: Case! = nil
  private var videoURLString: String?
  private var videoURLNSURL: NSURL! = nil
  private var imageForCaseImageView: UIImageView! = nil
  private var editCaseButton: UIButton! = nil
  private var deleteCaseButton: UIButton! = nil
  private var itsPossibleToChangeImage: Bool = false
  private var isYoutubeVideo: Bool = false
  private var isVimeoVideo: Bool = false
  private var loadingLabel: UILabel! = nil
  private var thumbNailOfVimeo: UIImageView?
  private var videoPlayerYoutube: YouTubePlayerView! = nil
  private var videoPlayerVimeoAVPlayer: AVPlayer! = nil
  private var isPlayingVidePlayerVimeoPlayer: Bool = false
  private var videoPlayerLayerVimeoAVPlayerLayer: AVPlayerLayer! = nil
  
  private var showButtonsOfEditionAndDelete: Bool! = nil
  
  var delegate: PreviewVimeoYoutubeViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, caseInfo: Case, showButtonsOfEdition: Bool) {

    showButtonsOfEditionAndDelete = showButtonsOfEdition
    
    caseData = caseInfo
    if caseData.url != nil {
      
      videoURLString = caseData.url
      videoURLNSURL = NSURL.init(string: videoURLString!)
      
    } else {
      
      videoURLString = nil
      videoURLNSURL = nil
      
    }
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.clearColor()
    
    if caseData.case_image_thumb != nil && (caseData.case_image_thumb?.containsString("missing.png") == false) {
      
      self.createImageForCaseImageView()
      
    } else {
      
      self.checkForTypeOfVideo()
      
    }
    
  }
  
  private func createImageForCaseImageView() {
    
    let frameForImageView = CGRect.init(x: 0.0,
                                        y: 0.0,
                                        width: self.frame.size.width,
                                        height: self.frame.size.height)
    
    imageForCaseImageView = UIImageView.init(frame: frameForImageView)
//    imageForCaseImageView.image = caseData.case_image_url!
    imageForCaseImageView.autoresizingMask = .FlexibleWidth
    imageForCaseImageView.contentMode = .ScaleAspectFit
    if caseData.case_image_thumb != nil {
      imageForCaseImageView.imageFromUrl(caseData.case_image_thumb!)
    }
    self.addSubview(imageForCaseImageView)
    
    if showButtonsOfEditionAndDelete == true {
      self.createEditCaseButton()
      self.createDeleteCaseButton()
    }
    
  }
  
  private func createEditCaseButton() {
    
    let frameForButton = CGRect.init(x: self.frame.size.width - (55.0 * UtilityManager.sharedInstance.conversionWidth),
                                     y: self.frame.size.height - (25.0 * UtilityManager.sharedInstance.conversionHeight),
                                 width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    editCaseButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconEdit") as UIImage?
    editCaseButton.setImage(image, forState: .Normal)
    editCaseButton.tag = 1
    editCaseButton.addTarget(self, action: #selector(editCase), forControlEvents:.TouchUpInside)
    
    self.addSubview(editCaseButton)
    
  }
  
  private func createDeleteCaseButton() {
    
    let frameForButton = CGRect.init(x: self.frame.size.width - (25.0 * UtilityManager.sharedInstance.conversionWidth),
                                     y: self.frame.size.height - (25.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    deleteCaseButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconClose") as UIImage?
    deleteCaseButton.setImage(image, forState: .Normal)
    deleteCaseButton.tag = 2
    deleteCaseButton.addTarget(self, action: #selector(deleteCase), forControlEvents:.TouchUpInside)
    
    self.addSubview(deleteCaseButton)
    
  }
  
  
  private func createLoadingLabel(message: String) {
    
    loadingLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Semibold",
                      size: 20.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 0.0/255.0, green: 64.0/255.0, blue: 89.0/255.0, alpha: 0.25)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: message,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(1.0),
        NSForegroundColorAttributeName: color
      ]
    )
    loadingLabel.attributedText = stringWithFormat
    loadingLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (loadingLabel.frame.size.width / 2.0),
                               y: loadingLabel.frame.origin.y + loadingLabel.frame.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: loadingLabel.frame.size.width,
                               height: loadingLabel.frame.size.height)
    
    loadingLabel.frame = newFrame
    
    self.addSubview(loadingLabel)
    
  }
  
  private func checkForTypeOfVideo() {
    
    isYoutubeVideo = UtilityManager.sharedInstance.validateIfLinkIsYoutube(videoURLString)
    isVimeoVideo = UtilityManager.sharedInstance.validateIfLinkIsVimeo(videoURLString)
    
    if isYoutubeVideo == true {
      
      self.loadVideoPlayerYoutube()
      
    }else
      if isVimeoVideo == true {
        
        self.loadVideoPlayerVimeoAVPlayer()
        
      }else{
        self.createLoadingLabel("Sin multimedia")
        if showButtonsOfEditionAndDelete == true {
          self.createEditCaseButton()
          //self.createDeleteCaseButton()
        }
        //self.createImageForCaseImageView()
    }
    
  }
  
  private func loadVideoPlayerYoutube() {
    
    let frameForPlayer = CGRect.init(x: 0.0,
                                     y: 0.0,
                                     width: self.frame.size.width,
                                     height: self.frame.size.height)
    
    videoPlayerYoutube = YouTubePlayerView.init(frame: frameForPlayer)
    videoPlayerYoutube.loadVideoURL(NSURL.init(string: videoURLString!)!)
    videoPlayerYoutube.userInteractionEnabled = false
    self.addSubview(videoPlayerYoutube)
    
  }
  
  private func loadVideoPlayerVimeoAVPlayer() {
    let frameForVideoPlayer = CGRect.init(x: 0.0,
                                          y: 0.0,
                                          width: self.frame.size.width,
                                          height: self.frame.size.height)
    
    YTVimeoExtractor.sharedExtractor().fetchVideoWithVimeoURL(videoURLString!,
                                                              withReferer: nil)
    {
      (video, error) in
      if video != nil {
        
        let streamURLs = video?.streamURLs
        let videoLink_360 = streamURLs?[360] as? String
        let videoLink_720 = streamURLs?[720] as? String
        
        //Uncomment this if you want to load thumbnail of the video
        
        //        let thumbnailsURLs = video?.thumbnailURLs
        //        let imageLink_320 = thumbnailsURLs?[320] as? String
        //        let imageLink_640 = thumbnailsURLs?[640] as? String
        //
        //
        //        if imageLink_640 != nil {
        //
        //          self.thumbNailOfVimeo = UIImageView.init(frame: frameForVideoPlayer)
        //          self.thumbNailOfVimeo!.imageFromUrl(imageLink_640!)
        //          self.addSubview(self.thumbNailOfVimeo!)
        //
        //          let playVideoTap = UITapGestureRecognizer.init(target: self,
        //                                                         action: #selector(self.playOrPauseVideoPlayerVimeo))
        //          playVideoTap.numberOfTapsRequired = 1
        //          self.thumbNailOfVimeo?.userInteractionEnabled = true
        //          self.thumbNailOfVimeo?.addGestureRecognizer(playVideoTap)
        //
        //        } else
        //          if imageLink_320 != nil {
        //
        //            self.thumbNailOfVimeo = UIImageView.init(frame: frameForVideoPlayer)
        //            self.thumbNailOfVimeo!.imageFromUrl(imageLink_320!)
        //            self.addSubview(self.thumbNailOfVimeo!)
        //
        //            let playVideoTap = UITapGestureRecognizer.init(target: self,
        //                                                           action: #selector(self.playOrPauseVideoPlayerVimeo))
        //            playVideoTap.numberOfTapsRequired = 1
        //            self.thumbNailOfVimeo?.userInteractionEnabled = true
        //            self.thumbNailOfVimeo?.addGestureRecognizer(playVideoTap)
        //
        //        }
        
        if videoLink_720 != nil {
          
          self.videoPlayerVimeoAVPlayer = AVPlayer.init(URL: NSURL.init(string: videoLink_720!)!)
          self.videoPlayerLayerVimeoAVPlayerLayer = AVPlayerLayer.init(player: self.videoPlayerVimeoAVPlayer)
          self.videoPlayerLayerVimeoAVPlayerLayer.frame = frameForVideoPlayer
          self.layer.addSublayer(self.videoPlayerLayerVimeoAVPlayerLayer)
          //                self.videoPlayerVimeoAVPlayer.play()
          
        }else
          if videoLink_360 != nil {
            
            self.videoPlayerVimeoAVPlayer = AVPlayer.init(URL: NSURL.init(string: videoLink_360!)!)
            self.videoPlayerLayerVimeoAVPlayerLayer = AVPlayerLayer.init(player: self.videoPlayerVimeoAVPlayer)
            self.videoPlayerLayerVimeoAVPlayerLayer.frame = frameForVideoPlayer
            self.layer.addSublayer(self.videoPlayerLayerVimeoAVPlayerLayer)
            //                  self.videoPlayerVimeoAVPlayer.play()
            
        }
      }
    }
  }
  
  func editCase() {
    
    self.delegate?.editSelectedCase(caseData)
    
  }
  
  @objc private func deleteCase() {
    
    self.delegate?.deleteSelectedCase(caseData)
    
  }
  
//  @objc private func playOrPauseVideoPlayerVimeo() {
//    
//    if isPlayingVidePlayerVimeoPlayer != true {
//      
//      videoPlayerVimeoAVPlayer.play()
//      isPlayingVidePlayerVimeoPlayer = true
//      
//    }else{
//      
//      videoPlayerVimeoAVPlayer.pause()
//      isPlayingVidePlayerVimeoPlayer = false
//      
//    }
//    
//  }

  
  
  
  
}
