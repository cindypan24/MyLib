//
//  ViewController.swift
//  Pocket Library
//
//  Created by Kinan Alsheikh on 4/26/18.
//Users/Kinan/Desktop/Pocket Library/Pocket Library/AppDelegate.swift/  Copyright © 2018 Kinan Alsheikh. All rights reserved.
//

import UIKit
import AVFoundation

let userDefaults = UserDefaults.standard

protocol CameraButtonDelegate{
    func cameraButtonPressed(withImage image: UIImage)
}

class ViewController: UIViewController {

    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    var cameraButton: UIButton!
    var delegate: CameraButtonDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationController?.isNavigationBarHidden = true
        title = "Camera"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Library", style: .plain, target: self, action: #selector(libraryButtonPressed))
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
        cameraButton = UIButton()
        cameraButton.setImage(#imageLiteral(resourceName: "cameraButtonImage"), for: .normal)
        cameraButton.addTarget(self, action: #selector(cameraButtonPressed), for: .touchUpInside)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cameraButton)
        
        setUpConstraints()
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            cameraButton.widthAnchor.constraint(equalToConstant: 100),
            cameraButton.heightAnchor.constraint(equalToConstant:100)
            ])
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back{
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }

    func setupInputOutput(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }

    }
    
    func setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
     @objc func cameraButtonPressed(sender: UIButton){
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    @objc func libraryButtonPressed(sender: UIButton){
        navigationController?.pushViewController(libraryVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

extension ViewController: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
        if let imageData = photo.fileDataRepresentation(){
            image = UIImage(data: imageData)
            let preview = PreviewViewController()
            preview.delegate = self as? CameraButtonDelegate
            preview.cameraButtonPressed(withImage: image!)
            navigationController?.pushViewController(preview, animated: true)
        }
        
    }
}

