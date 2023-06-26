//
//  CameraViewController.swift
//  LiDAR1
//
//  Created by VEMI Lab on 6/12/23.
//

import UIKit
import AVFoundation


class CameraViewController: UIViewController {
    
    //Capture Session
    var captureSession: AVCaptureSession?
    //Camera Output
    let captureOutput = AVCapturePhotoOutput()
    //Video Preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    //Camera Button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        
        getCameraAccess()
        
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
        
        
    //Creating camera UI
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height-200)
        
    }
    
    
    //Asking for camera use permission
    func getCameraAccess(){
        guard let camera = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: camera) else{
            fatalError("Camera is not available")
            
            
            /*switch AVCaptureDevice.authorizationStatus(for: .video){
             case .notDetermined:
             AVCaptureDevice.requestAccess(for: .video ) { [weak self] granted in
             guard granted else{
             return
             }
             DispatchQueue.main.async{
             self?.setUpCamera()
             }
             
             }
             case .restricted:
             break
             case .denied:
             break
             case .authorized:
             setUpCamera()
             @unknown default:
             break */
        }
        
        //setting up the camera
        func setUpCamera(){
            let session = AVCaptureSession()
            if let device = AVCaptureDevice.default(for: .video){
                do{
                    let input = try AVCaptureDeviceInput(device: device)
                    if session.canAddInput(input){
                        session.addInput(input)
                    }
                    if session.canAddOutput(captureOutput){
                        session.addOutput(captureOutput)
                        
                    }
                    
                    previewLayer.videoGravity = .resizeAspectFill
                    previewLayer.session = session
                    
                    session.startRunning()
                    self.captureSession = session
                }
                
                catch{
                    print("Error")
                    
                }
            }
        }
        
        func didTapTouchPhoto(){
            captureOutput.capturePhoto(with: <#T##AVCapturePhotoSettings#>, delegate: <#T##AVCapturePhotoCaptureDelegate#>)
        }
        
extension CameraViewController: AVCapturePhotoCaptureDelegate{
    func  photoOutput(_: <#T##AVCapturePhotoOutput#>, didFinishProcessingPhoto: <#T##AVCapturePhoto#>, error: <#T##Error?#>);){
                
                
                
                
            }
        }
        
    }
}
