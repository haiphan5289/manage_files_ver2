//
//  BaseSetting.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import Foundation
import EasyFiles
import EasyBaseCodes
import RxSwift
import RxCocoa

class BaseSetting: BaseVC, SetupTableView {
    
    enum IndexStatus {
        case first, middle, last
        
        static func getStt(total: Int, index: Int) -> Self {
            if index == 0 {
                return .first
            }
            
            if index + 1 == total {
                return .last
            }
            
            return .middle
        }
    }
    
    var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    let source: BehaviorRelay<[BaseSettingModel]> = BehaviorRelay.init(value: [])
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }

}
extension BaseSetting {
    private func setupUI() {
        self.setupTableView(delegate: self, name: SettingCell.self)
    }
    
    private func setupRX() {
        self.source
            .witElementhUnretained(self)
            .bind(to: tableView.rx.items(cellIdentifier: SettingCell.identifier, cellType: SettingCell.self)) {(row, element, cell) in
                switch self.screenType {
                case .setting:
                    cell.setValueSetting(model: element)
                    switch IndexStatus.getStt(total: self.source.value.count, index: row) {
                    case .first: cell.radiusTop()
                    case .middle: cell.radiusNormal()
                    case .last: cell.radiusBottom()
                    }
                default: break
                }
            }.disposed(by: disposeBag)
    }
}
extension BaseSetting: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
