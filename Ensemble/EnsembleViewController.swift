//
//  EnsembleViewController.swift
//  Ensemble
//
//  Created by Jele on 12/8/2022.
//

import UIKit
import AgoraRtcKit

class EnsembleViewController: UIViewController {
    // 定义 localView 变量
    var localView: UIView!
    // 定义 remoteView 变量
    var remoteView: UIView!
    // 定义 agoraKit
    var agoraKit: AgoraRtcEngineKit?
    
    deinit {
        print("dealloc")
        agoraKit?.stopPreview()
        agoraKit?.leaveChannel(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // 当加载视图后，你可以进行其他其他设置。
        // 初始化视频窗口
        initView()
        // 当调用 Agora API 时，以下函数会被调用
        initializeAgoraEngine()
        setupLocalVideo()
        joinChannel()
    }
    
    // 设置视频窗口布局
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
    }
    
    func initView(){
        // 初始化远端视频窗口。
        remoteView = UIView()
        self.view.addSubview(remoteView)
        // 初始化本地视频窗口。
        localView = UIView()
        self.view.addSubview(localView)
    }
    
    func initializeAgoraEngine(){
        let config = AgoraRtcEngineConfig()
        let log = AgoraLogConfig()
        log.level = .info
        // 在这里输入你的 App ID.
        config.appId = "b11196b76c2548c294fd08cd9f51d0bd"
        config.logConfig = log
        // 调用 AgoraRtcEngineDelegate
        agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
    }
    
    func setupLocalVideo(){
        // 启用视频模块
        agoraKit?.enableVideo()
        // 开始本地预览
        agoraKit?.startPreview()
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.renderMode = .hidden
        videoCanvas.view = localView
        // 设置本地视图
        agoraKit?.setupLocalVideo(videoCanvas)
    }
    
    func joinChannel(){
        let option = AgoraRtcChannelMediaOptions()
        // 在视频通话场景下，将频道场景设置为 liveBroadcasting
        option.channelProfile = .of((Int32)(AgoraChannelProfile.liveBroadcasting.rawValue))
        // 设置用户角色为主播
        option.clientRoleType = .of((Int32)(AgoraClientRole.broadcaster.rawValue))
        // 使用临时 token 加入频道，在这里传入你的项目的 token 和频道名。
        agoraKit?.joinChannel(byToken: "006b11196b76c2548c294fd08cd9f51d0bdIADIGWxuzvqzARpyPNnwxcrPwZT/inQGujXyBQ7T0JKoRWDQ6kYAAAAAEACxI7THtH32YgEAAQCzffZi", channelId: "testtt", uid: 0, mediaOptions: option)
    }
}

extension EnsembleViewController: AgoraRtcEngineDelegate {
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int){
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        agoraKit?.setupRemoteVideo(videoCanvas)
   }
    
    
}
