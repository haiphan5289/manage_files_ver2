
//
//  
//  ImagePDFVC.swift
//  ManageFiles
//
//  Created by haiphan on 24/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import EasyBaseCodes
import EasyFiles
import PDFKit

class ImagePDFVC: BaseVC, MoveToProtocol {
    
    // Add here outlets
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btRotate: UIButton!
    
    // Add here your view model
    private var viewModel: ImagePDFVM = ImagePDFVM()
    private let titleView: NavigationActionView = .loadXib()
    var url: URL?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationView()
    }
    
}
extension ImagePDFVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        self.screenType = .folder
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        self.btRotate.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.img.image = owner.img.image?.rotated(by: .pi / 2)
            }.disposed(by: disposeBag)
    }
    
    func generatePdfThumbnail(of thumbnailSize: CGSize , for documentUrl: URL, atPage pageIndex: Int) -> UIImage? {
        let pdfDocument = PDFDocument(url: documentUrl)
        let pdfDocumentPage = pdfDocument?.page(at: pageIndex)
        return pdfDocumentPage?.thumbnail(of: thumbnailSize, for: PDFDisplayBox.trimBox)
    }
    
    private func setupNavigationView() {
        self.addViewNavigationBar(titleView: self.titleView)
        self.titleView.hidePlusButton()
        self.titleView.delgate = self
        self.view.layoutIfNeeded()
        if let url = self.url {
            let type = EasyFilesManage.shared.detectFile(url: url)
            switch type {
            case .pdf:
                self.img.image = self.generatePdfThumbnail(of: self.img.frame.size, for: url, atPage: 0)
            default:
                if let url = URL(string: url.absoluteString) {
                    do {
                        let data = try Data(contentsOf: url)
                        self.img.image = UIImage(data: data)
                    } catch {
                        
                    }
                    
                }
            }
            self.titleView.setTitle(text: url.getName())
        }
    }
    
}
extension ImagePDFVC: NavigationActionDelegate {
    func selectAction(action: NavigationActionView.Action) {
        switch action {
        case .back, .plus: break
        case .save:
            if let url = self.url,
               let iamge = self.img.image,
               let pdfData = [iamge].makePDF()?.dataRepresentation()  {
                Task.init {
                    do {
                        let result = try await EasyFilesManage.shared.savePdf(data: pdfData, fileName: url.getName(), folderName: "\(GlobalApp.FolderName.Trash.rawValue)/")
                        switch result {
                        case .success(let outputURL):
                            self.moveToActionFiles(url: [outputURL], status: .cloud)
                        case .failure(let err):
                            self.showAlert(title: nil, message: err.localizedDescription)
                        }
                    } catch {
                        
                    }
                }
            }
        }
    }
    
}

