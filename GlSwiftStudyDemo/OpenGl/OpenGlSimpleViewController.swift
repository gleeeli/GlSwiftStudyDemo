//
//  OpenGlSimpleViewController.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2019/2/14.
//  Copyright © 2019年 gleeeli. All rights reserved.
//

import UIKit
import GLKit
import OpenGLES
import AVFoundation

class OpenGlSimpleViewController: UIViewController {
    let captureSession = AVCaptureSession()
    let previewView = PreviewView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        previewView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        self.view.addSubview(previewView)

        initAVDevice()
        outputSessionConfig()
        
        self.previewView.videoPreviewLayer.session = self.captureSession;
        
        self.captureSession.startRunning()
    }
    
    func initAVDevice() {
        // Create the capture session.
        captureSession.beginConfiguration()
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                  for: .video, position: .front)
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
            captureSession.canAddInput(videoDeviceInput)
            else { return }
        captureSession.addInput(videoDeviceInput)
    }
    
    func outputSessionConfig() {
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        captureSession.commitConfiguration()
    }
}

class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    /// Convenience wrapper to get layer as its statically known type.
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}


