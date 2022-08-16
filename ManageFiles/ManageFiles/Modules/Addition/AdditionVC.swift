
//
//  
//  AdditionVC.swift
//  ManageFiles
//
//  Created by haiphan on 10/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import VisionKit
import MobileCoreServices

protocol AdditionDelegate: AnyObject {
    func moveToAction(url: URL)
}

class AdditionVC: BaseVC, AdditionProtocol {
    
    enum Addtion: String {
        case importAdd, folder, photo, camera, text, scan
    }
    
    var delegate: AdditionDelegate?
    
    // Add here outlets
    @IBOutlet weak var btClose: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    // Add here your view model
    private var viewModel: AdditionVM = AdditionVM()
    private let source: BehaviorRelay<[BaseSettingModel]> = BehaviorRelay.init(value: [])
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension AdditionVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        self.btClose.contentHorizontalAlignment = .right
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        self.source
            .withUnretained(self)
            .bind { owner, list in
                list.forEach { model in
                    let v: UIView = UIView(frame: .zero)
                    let filesCellView: FilesCellView = .loadXib()
                    v.addSubview(filesCellView)
                    filesCellView.snp.makeConstraints { make in
                        make.edges.equalToSuperview()
                    }
                    v.snp.makeConstraints { make in
                        make.height.equalTo(48)
                    }
                    filesCellView.setValueBottom(value: 0)
                    filesCellView.hideButonMore()
                    filesCellView.setValueAdd(model: model)
                    
                    let button: UIButton = UIButton(type: .custom)
                    v.addSubview(button)
                    button.snp.makeConstraints { make in
                        make.edges.equalToSuperview()
                    }
                    button.rx.tap
                        .withUnretained(self)
                        .bind { owner, _ in
                            guard let nameType = model.type,
                                  let type = Addtion.init(rawValue: nameType) else {
                                return
                            }
                            owner.selectAction(type: type, delegateCloud: owner, delegatePhoto: owner, delegateScan: owner)
                        }.disposed(by: owner.disposeBag)
                    
                    owner.stackView.addArrangedSubview(v)
                }
            }.disposed(by: disposeBag)
        
        ReadJSON
            .shared
            .parseToDate(name: "Addition", type: "json")
            .decode(type: [BaseSettingModel].self, decoder: JSONDecoder())
            .witElementhUnretained(self)
            .bind(to: self.source)
            .disposed(by: disposeBag)
    }
    
    private func moveToURL(url: URL) {
        self.dismiss(animated: true) {
            self.delegate?.moveToAction(url: url)
        }
    }
        
}
extension AdditionVC: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        // Process the scanned pages
        var images: [UIImage] = []
        for pageNumber in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNumber)
            images.append(image)
        }
        
        
        // You are responsible for dismissing the controller.
        controller.dismiss(animated: true) {
            if let pdfData = images.makePDF()?.dataRepresentation() {
                //                self.showCreatePDF(pdfData: pdfData)
            }
        }
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        // You are responsible for dismissing the controller.
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        // You should handle errors appropriately in your app.
        print(error)
        
        // You are responsible for dismissing the controller.
        controller.dismiss(animated: true)
    }
    
}
extension AdditionVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let first = urls.first else {
            return
        }
        self.moveToURL(url: first)
    }
}
extension AdditionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
//            self.moveToActionFiles()
//            self.dismiss(animated: true) {
                if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                    self.moveToURL(url: imageURL)
//            ManageApp.shared.secureCopyItemfromLibrary(at: imageURL, folderName: ConstantApp.shared.folderPhotos) { outputURL in
//                picker.dismiss(animated: true) {
//                    ManageApp.shared.createFolderModeltoFiles(url: outputURL)
//                }
//            } failure: { [weak self] text in
//                guard let wSelf = self else { return }
//                wSelf.msgError.onNext(text)
//            }
//                let vc = ImportFilesVC.createVC()
//                vc.modalTransitionStyle = .crossDissolve
//                vc.modalPresentationStyle = .overFullScreen
//                vc.inputURL = imageURL
//                self.present(vc, animated: true, completion: nil)
                    
//                }
            }
        }
    }
}
