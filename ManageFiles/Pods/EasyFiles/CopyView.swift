//
//  CopyView.swift
//  ManageFiles
//
//  Created by haiphan on 15/01/2022.
//

import UIKit

public class CopyView: UIView {
    
    struct Constant {
        static let distanceToLeft: Int = 25
    }
    
    public let url: URL
    public let numberOffoldes: Int
    
    public var actionTap: ((Bool) -> Void)?
    private let stackParent: UIStackView = UIStackView(arrangedSubviews: [],
                                         axis: .vertical,
                                         spacing: 0,
                                         alignment: .fill,
                                         distribution: .fill)
    private let stackExplain: UIStackView = UIStackView(arrangedSubviews: [],
                                         axis: .vertical,
                                         spacing: 0,
                                         alignment: .fill,
                                         distribution: .fill)
    private let btPress: UIButton = UIButton(frame: .zero)
    private let checkImg: UIImageView
    private let imgArrow: UIImageView
    private let explainView: UIView = UIView(frame: .zero)
    private let imgArrowRight: UIImage
    private let imDrop: UIImage
    private let icOtherFolder: UIImage
    
    public required init(url: URL,
                  numberOffoldes: Int,
                  imgCheck: String,
                  imgArrowRight: String,
                  imgDrop: String,
                  icOtherFolder: String) {
        self.url = url
        self.numberOffoldes = numberOffoldes
        self.imgArrowRight = UIImage(named: imgArrowRight) ?? UIImage.init()
        self.imDrop = UIImage(named: imgDrop) ?? UIImage.init()
        self.icOtherFolder = UIImage(named: icOtherFolder) ?? UIImage.init()
        self.checkImg = UIImageView(image: UIImage(named: imgCheck))
        self.imgArrow = UIImageView(image: UIImage(named: imgArrowRight))
        super.init(frame: .zero)
        self.setupUI()
        self.setupRX()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CopyView {
    
    private func setupUI() {
        self.checkImg.isHidden = true
        self.setupView(url: self.url)
        self.btPress.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        if self.btPress.isSelected {
            self.btPress.isSelected = false
            self.hideCheckImg()
            self.actionTap?(false)
        } else {
            self.btPress.isSelected = true
            self.showCheckImg()
            self.actionTap?(true)
        }
    }
    
    private func setupRX() {
    }
    
    public func addViewToStackExplain(copyView: CopyView) {
        self.stackExplain.addArrangedSubview(copyView)
    }
    
    public func hideCheckImg() {
        self.checkImg.isHidden = true
        self.imgArrow.image = self.imgArrowRight
        self.btPress.isSelected = false
    }
    
    public func showCheckImg() {
        self.checkImg.isHidden = false
        self.imgArrow.image = self.imDrop
        self.btPress.isSelected = true
    }
    
    public func removeSubviewStackView() {
        self.stackExplain.subviews.forEach { v in
            v.removeFromSuperview()
        }
    }
    
    public func showExplainView(isHide: Bool) {
        self.explainView.isHidden = isHide
    }
    
    private func setupView(url: URL) {
        let v: UIView = UIView(frame: .zero)
//        v.snp.makeConstraints { make in
//            make.height.equalTo(48)
//        }
        v.addHeight().addValueConstraint(value: 48)
        
        let stackView: UIStackView = UIStackView(arrangedSubviews: [],
                                                 axis: .horizontal,
                                                 spacing: 12,
                                                 alignment: .center,
                                                 distribution: .fill)
//        self.imgArrow.snp.makeConstraints { make in
//            make.height.width.equalTo(16)
//        }
        self.imgArrow.addHeight().addWidth().addValueConstraint(value: 16)
        
        let img: UIImageView = UIImageView(image: self.uploadImage(url: url))
//        img.snp.makeConstraints { make in
//            make.height.width.equalTo(28)
//        }
        img.addHeight().addWidth().addValueConstraint(value: 28)
        
        let lbName: UILabel = UILabel(frame: .zero)
        lbName.font = UIFont.systemFont(ofSize: 17)
        lbName.textColor = .black
        lbName.text = "\(url.lastPathComponent)"
        lbName.textAlignment = .left
        
//        self.checkImg.snp.makeConstraints { make in
//            make.height.width.equalTo(20)
//        }
        self.checkImg.addHeight().addWidth().addValueConstraint(value: 20)
                
        stackView.addArrangedSubview(imgArrow)
        stackView.addArrangedSubview(img)
        stackView.addArrangedSubview(lbName)
        stackView.addArrangedSubview(self.checkImg)
        v.addSubview(stackView)
//        stackView.snp.makeConstraints { make in
//            make.bottom.top.equalToSuperview()
//            make.right.equalToSuperview().inset(16)
//            make.left.equalToSuperview().inset(8)
//        }
        stackView.addTopArea().addBottomArea().addValueArea()
        stackView.addRightArea().addValueArea(value: 16)
        stackView.addLeftArea().addValueArea(value: 8)
        
        let lineView: UIView = UIView(frame: .zero)
        lineView.backgroundColor = .gray
        v.addSubview(lineView)
//        lineView.snp.makeConstraints { make in
//            make.right.bottom.equalToSuperview()
//            make.height.equalTo(1)
//            make.left.equalTo(lbName)
//        }
        lineView.addRightArea().addBottomArea().addValueArea()
        lineView.addHeight().addValueConstraint(value: 1)
        lineView.addLeftArea().addValueArea(view: lbName)
        
        v.addSubview(self.btPress)
//        self.btPress.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        self.btPress.addEdges()
        
        stackParent.addArrangedSubview(v)
        
        self.explainView.isHidden = true
        self.explainView.addSubview(self.stackExplain)
//        self.stackExplain.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        self.stackExplain.addEdges()
        
        self.stackParent.addArrangedSubview(self.explainView)
//        self.explainView.snp.makeConstraints { make in
//        }
        
        self.addSubview(self.stackParent)
//        self.stackParent.snp.makeConstraints { make in
//            make.right.bottom.top.equalToSuperview()
//            make.left.equalToSuperview().inset(self.numberOffoldes * Constant.distanceToLeft)
//        }
        self.stackParent.addRightArea().addBottomArea().addTopArea().addValueArea()
        self.stackParent.addLeftArea().addValueArea(value: CGFloat(self.numberOffoldes * Constant.distanceToLeft))
    }
    
    private func uploadImage(url: URL) -> UIImage {
        if let index = ManageApp.shared.folders.firstIndex(where: { $0.url.getNamePath().uppercased().contains(url.getNamePath().uppercased())}),
           let name = ManageApp.shared.folders[index].imgName {
            return UIImage(named: name) ?? icOtherFolder
        }

        return icOtherFolder
    }
    
}
