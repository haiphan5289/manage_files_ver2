
//
//  
//  ToolsVC.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import EasyFiles

class ToolsVC: BaseTabbarVC {
    
    enum ToolsFile: Int, CaseIterable {
        case importFiles, notePad, imageToPdf, fileTransfer, videoPlayer
        
        var title: String {
            switch self {
            case .importFiles: return "Import Files"
            case .notePad: return "Notepad+"
            case .imageToPdf: return "Image to PDF"
            case .fileTransfer: return "File Transfer"
            case .videoPlayer: return "Video Player"
            }
        }
        
        var subTitle: String {
            switch self {
            case .importFiles: return "Import your files & documents to manager"
            case .notePad: return "Create text file, note, code file..."
            case .imageToPdf: return "Convert images to PDF document"
            case .fileTransfer: return "Transfer files & docs to any devices via Wifi"
            case .videoPlayer: return "Play various video formats"
            }
        }
        
        var imgStr: String {
            switch self {
            case .importFiles: return "img_import"
            case .notePad: return "img_notePad"
            case .imageToPdf: return "img_img_to_pdf"
            case .fileTransfer: return "img_file_transfer"
            case .videoPlayer: return "img_video_player"
            }
        }
    }
    
    // Add here outlets
    @IBOutlet weak var contentSearchView: UIView!
    @IBOutlet weak var contentTableView: UIView!
    
    // Add here your view model
    private var viewModel: ToolsVM = ToolsVM()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension ToolsVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        self.screenType = .tools
        self.contentSearchView.addSubview(self.searchView)
        self.searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.contentTableView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        let folder = ToolsFile.allCases.map { FolderModel(imgName: $0.imgStr,
                                                          url: URL.init(fileURLWithPath: ""),
                                                          id: Date().timeIntervalSince1970) }
        self.source.accept(folder)
        
        self.source
            .witElementhUnretained(self)
            .bind { list in
                print("======= Tools \(list.count)")
            }.disposed(by: disposeBag)
    }
}
