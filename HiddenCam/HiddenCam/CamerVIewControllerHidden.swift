//
//  CamerVIewController.swift
//  HiddenCam
//
//  Created by Daniel on 26/11/2019.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewControllerHidden: UIViewController {
    let photoButton: UIButton = UIButton()
    
    //Camera Capture requiered properties
    var captureDevice : AVCaptureDevice!
    let session = AVCaptureSession()
    var stillImageOutput: AVCapturePhotoOutput!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        photoButton.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        photoButton.backgroundColor = UIColor.red
        photoButton.layer.masksToBounds = true
        photoButton.setTitle("or?", for: .normal)
        photoButton.setTitleColor(UIColor.white, for: .normal)
        photoButton.layer.cornerRadius = 20.0
        photoButton.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        photoButton.addTarget(self, action: #selector(self.takePhoto(sender:)), for: .touchUpInside)
        
        view.addSubview(photoButton)
        
        let text: UITextView = UITextView(frame: CGRect(x: self.view.frame.width/2 - 150, y: 100, width: 300, height: 40))
        text.text = "This is just a regular ViewController. There is nothing to see here."
        text.textColor = UIColor.black
        view.addSubview(text)

        self.setupAVCapture()
    }
    
    @objc func takePhoto(sender: UIButton){
        stillImageOutput.capturePhoto(with: AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg]), delegate: self)
    }
}


// MARK: - AVCaptureSession related methods
extension CameraViewControllerHidden {
    func setupAVCapture(){
        session.sessionPreset = AVCaptureSession.Preset.vga640x480
        guard let device = AVCaptureDevice
            .default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                     for: .video,
                     position: AVCaptureDevice.Position.front) else {
                        return
        }
        captureDevice = device
        beginSession()
    }
    
    func beginSession(){
        var deviceInput: AVCaptureDeviceInput!
        
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            guard deviceInput != nil else {
                print("error: can't get deviceInput")
                return
            }
            
            if self.session.canAddInput(deviceInput){
                self.session.addInput(deviceInput)
            }
            
            stillImageOutput = AVCapturePhotoOutput()
            
            if session.canAddOutput(stillImageOutput) {
                session.addOutput(self.stillImageOutput)
            }
            
            // we can also attach videoDataOutput from the previous example to get all the video frames
            // but now for the example image capturing is enough
            
            session.startRunning()
        } catch let error as NSError {
            deviceInput = nil
            print("error: \(error.localizedDescription)")
        }
    }
    
    // clean up AVCapture
    func stopCamera(){
        session.stopRunning()
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CameraViewControllerHidden: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        //process single image
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let captureImageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        let image = UIImage(data: imageData)
        captureImageView.image = image
        
        //show the captured image
        let centerView = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width / 2 - 100,
                                              y: UIScreen.main.bounds.size.height / 2 - 100,
                                              width: 200,
                                              height: 200))
        centerView.backgroundColor = UIColor.red
        centerView.addSubview(captureImageView)
        
        self.view.addSubview(centerView)
        
    }
}
