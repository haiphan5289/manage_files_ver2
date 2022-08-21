
//
//  
//  CameraVC.swift
//  ManageFiles
//
//  Created by haiphan on 21/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import AVFoundation
import EasyFiles

class CameraVC: UIViewController, AVCapturePhotoCaptureDelegate, MoveToProtocol {
    
    // Add here outlets
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var btTakePhoto: UIButton!
    private var captureSession: AVCaptureSession!
    private var stillImageOutput: AVCapturePhotoOutput!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    // Add here your view model
    private var viewModel: CameraVM = CameraVM()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.captureSession = AVCaptureSession()
        self.captureSession.sessionPreset = .high
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            self.stillImageOutput = AVCapturePhotoOutput()
            
            if self.captureSession.canAddInput(input) && self.captureSession.canAddOutput(self.stillImageOutput) {
                self.captureSession.addInput(input)
                self.captureSession.addOutput(self.stillImageOutput)
                self.setupLivePreview()
                DispatchQueue.global(qos: .userInitiated).async {
                    self.captureSession.startRunning()
                }
                DispatchQueue.main.async {
                    self.videoPreviewLayer.frame = self.cameraView.bounds
                }
                
            }
            
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.captureSession.stopRunning()
    }
    
}
extension CameraVC {
    
    private func setupUI() {
        // Add here the setup for the UI
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        self.btTakePhoto.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                owner.stillImageOutput.capturePhoto(with: settings, delegate: owner )
            }.disposed(by: disposeBag)
    }
    
    func setupLivePreview() {
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.videoPreviewLayer.videoGravity = .resize
        self.videoPreviewLayer.connection?.videoOrientation = .portrait
        self.cameraView.layer.addSublayer(self.videoPreviewLayer)
        self.view.sendSubviewToBack(self.cameraView)
    }
}

extension CameraVC {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        if let image = UIImage(data: imageData) {
            Task.init {
                do {
                    let result = try await EasyFilesManage.shared.fetchImage(image: image, folder: "\(GlobalApp.FolderName.Trash.rawValue)/")
                    switch result {
                    case .success(let outputURL):
                        self.moveToActionFiles(url: [outputURL], status: .cloud)
                    case .failure(_): break
                    }
                } catch {
                    
                }
            }
        }
        
    }
}
