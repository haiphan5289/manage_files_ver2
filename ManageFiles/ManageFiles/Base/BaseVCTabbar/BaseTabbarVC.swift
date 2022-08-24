//
//  BaseTabbarVC.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit
import EasyFiles
import EasyBaseCodes
import RxSwift
import RxCocoa

class BaseTabbarVC: BaseVC, SetupTableView, MoveToProtocol, ToolsProtocol {
    
    let searchView: SearchView = .loadXib()
    var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    let source: BehaviorRelay<[FolderModel]> = BehaviorRelay.init(value: [])
    var selectItem: PublishSubject<FolderModel> = PublishSubject.init()
    var additionStatis: AdditionVC.AdditionStatus = .normal
    @VariableReplay var cellStatus: FolderVC.CellStatus = .single
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension BaseTabbarVC {
    
    private func setupUI() {
        self.setupTableView(delegate: self, name: FilesCell.self)
        self.tableView.allowsMultipleSelection = true
        guard let path = Bundle.main.path(forResource: "image_check", ofType:"png")else {
            debugPrint("video.m4v not found")
            return
        }
        let url = URL(fileURLWithPath: path)
        print("======== url.getSize() \(url.getSize())")
        
    }
    
    private func setupRX() {
        self.source
            .witElementhUnretained(self)
            .bind(to: tableView.rx.items(cellIdentifier: FilesCell.identifier, cellType: FilesCell.self)) {(row, element, cell) in
                switch self.screenType {
                case .folder:
                    cell.setValueHome(folđer: element)
                    cell.isHideImage(isHide: (self.cellStatus == .single) ? true : false )
                case .home:
                    cell.setValueHome(folđer: element)
                case .files:
                    cell.setValueFiles(folđer: element)
                case .tools:
                    if let toolFile = ToolsVC.ToolsFile.allCases.safe[row] {
                        cell.setValueTools(folđer: element, toolFile: toolFile)
                    }
                case .tabbar, .setting, .action: break
                }
                cell.selectActionCell = { [weak self] action in
                    guard let self = self else { return }
                    switch action {
                    case .more:
                        self.moveToFiles(folder: element, delegate: self)
                        //                        self.selectItem.onNext(element)
                    case .drop: break
                    }
                }
            }.disposed(by: disposeBag)
        
        self.tableView
            .rx
            .itemSelected
            .withUnretained(self)
            .bind { owner, idx in
                guard owner.cellStatus == .single else {
                    return
                }
                switch owner.screenType {
                case .tools:
                    let type = ToolsVC.ToolsFile.allCases[idx.row]
                    var addition: AdditionVC.AdditionStatus = .normal
                    if type == .imageToPdf {
                        addition = .imageToPDF
                    }
                    owner.selectAction(type: type, delegateCloud: owner, additionStatus: addition, additionDelegate: owner)
                default:
                    let item = owner.source.value[idx.row]
                    owner.moveToFolder(url: item.url, delegate: owner)
                }
                
                //            switch self.screenType {
                //            case .files:
                //                let item = owner.source.value[idx.row]
                //                owner.moveToFolder(url: item.url, delegate: owner)
                //            case .home:
                //
                //            case .folder, .action, .setting, .tabbar, .tools: break
                //            }
            }.disposed(by: disposeBag)
        
        self.$cellStatus
            .withUnretained(self)
            .bind { owner, _ in
                owner.tableView.reloadData()
            }.disposed(by: disposeBag)
    }
    
}
extension BaseTabbarVC: AdditionDelegate {
    func moveToAction(url: URL) {
        self.moveToImagePDF(url: url)
    }
}
extension BaseTabbarVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let first = urls.first else {
            return
        }
        switch self.additionStatis {
        case .normal: self.moveToActionFiles(url: urls, status: .cloud)
        case .imageToPDF: self.moveToImagePDF(url: first)
            
        }
        
    }
}
extension BaseTabbarVC: FilesMenuDelegate {
    func selectAction(action: FilesMenuVC.Action) {
        GlobalApp.shared.updateAgain.onNext(())
    }
    
}
extension BaseTabbarVC: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
extension BaseTabbarVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
