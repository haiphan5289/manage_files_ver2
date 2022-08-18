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

class BaseTabbarVC: BaseVC, SetupTableView {

    let searchView: SearchView = .loadXib()
    var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    let source: BehaviorRelay<[FolderModel]> = BehaviorRelay.init(value: [])
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
        guard let path = Bundle.main.path(forResource: "video_select_print", ofType:"mp4")else {
            debugPrint("video.m4v not found")
            return
        }
        let url = URL(fileURLWithPath: path)
        url.getThumbnailImage()
    }
    
    private func setupRX() {
        self.source
            .witElementhUnretained(self)
            .bind(to: tableView.rx.items(cellIdentifier: FilesCell.identifier, cellType: FilesCell.self)) {(row, element, cell) in
                switch self.screenType {
                case .home, .folder:
                    cell.setValueHome(folđer: element)
                case .files:
                    cell.setValueFiles(folđer: element)
                case .tools:
                    if let toolFile = ToolsVC.ToolsFile.allCases.safe[row] {
                        cell.setValueTools(folđer: element, toolFile: toolFile)
                    }
                case .tabbar, .setting, .action: break
                }
            }.disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected.withUnretained(self).bind { owner, idx in
            switch self.screenType {
            case .files:
                let item = owner.source.value[idx.row]
                if let topVC = GlobalCommon.topViewController(), item.url.hasDirectoryPath {
                    let vc = FolderVC.createVC()
                    let folderName = EasyFilesManage.shared.detectPathFolder(url: item.url)
                    vc.folderName = folderName
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            case .home, .folder, .action, .setting, .tabbar, .tools: break
            }
        }.disposed(by: disposeBag)
    }
    
}
extension BaseTabbarVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
