//
//  FilesCell.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit
import EasyFiles

class FilesCell: UITableViewCell, BaseViewSetUp {

    private var cellView: FilesCellView = .loadXib()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
        self.setupRX()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension FilesCell {
    
    func setupUI() {
        self.addSubview(cellView)
        self.cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupRX() {
        
    }
    
    func setValueTools(folđer: FolderModel, toolFile: ToolsVC.ToolsFile) {
        cellView.setValueTools(folder: folđer, toolFile: toolFile)
    }
    
    func setValueFiles(folđer: FolderModel?) {
        if let f = folđer {
            cellView.setValueFiles(folder: f)
        }
    }
    
}
