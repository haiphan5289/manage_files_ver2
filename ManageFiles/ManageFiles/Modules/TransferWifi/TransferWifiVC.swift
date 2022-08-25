
//
//  
//  TransferWifiVC.swift
//  ManageFiles
//
//  Created by haiphan on 25/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import MultipeerConnectivity
import SystemConfiguration.CaptiveNetwork
import CoreLocation

class TransferWifiVC: BaseVC, MoveToProtocol {
    
    // Add here outlets
    @IBOutlet weak var lbWifeName: UILabel!
    private var locationManager: CLLocationManager?
    
    // Add here your view model
    private var viewModel: TransferWifiVM = TransferWifiVM()
    // Add here your view model
    private var mgr = SGWiFiUploadManager.shared()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeBorder(font: UIFont.systemFont(ofSize: 17),
                     bgColor: .white,
                     textColor: .black)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mgr?.stopHTTPServer()
    }
}
extension TransferWifiVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        self.screenType = .folder
                locationManager = CLLocationManager()
                locationManager?.delegate = self
                locationManager?.requestAlwaysAuthorization()
        setupServer()
    }
    
    private func setupRX() {
        // Add here the setup for the RX
    }
    
    private func setupServer() {
        
        let success = mgr?.startHTTPServer(atPort: 8) ?? false
        if success {
            mgr?.setFileUploadStartCallback({ (filname, savePath) in
                print("File %@ Upload Start \(filname)")
            })
            
            mgr?.setFileUploadProgressCallback({ (fileName, savePath, progress) in
                print("File %@ on progress %f \(fileName) -- \(progress)")
            })
            
            mgr?.setFileUploadFinishCallback({ (fileName, savePath) in
                print("==== upload successfully")
                if let filePath = savePath {
                    let url = URL(fileURLWithPath: filePath)
                    self.moveToActionFiles(url: [url], status: .cloud)
                }
            })
        }
        
        if !success {
            mgr = SGWiFiUploadManager.shared()
            let success = mgr?.startHTTPServer(atPort: 8) ?? false
            if success {
                mgr?.setFileUploadStartCallback({ (filname, savePath) in
                    print("File %@ Upload Start \(filname)")
                })

                mgr?.setFileUploadProgressCallback({ (fileName, savePath, progress) in
                    print("File %@ on progress %f \(fileName) -- \(progress)")
                })

                mgr?.setFileUploadFinishCallback({ (fileName, savePath) in
                    if let filePath = savePath {
                        let url = URL(fileURLWithPath: filePath)
                        self.dismiss(animated: true) {
                        }
                        
                    }
                    
                })
            }
        }
        
        if let ip = mgr?.ip(), let port = mgr?.port() {
            let text = "\(ip):\(port)"
            self.setupTextViewNote(textIP: text)
        } else {
        }
        
    }
    
    private func setupTextViewNote(textIP: String) {
        let attrs1 = [NSAttributedString.Key.font : UIFont.mySystemFont(ofSize: 17),
                      NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.mySystemFont(ofSize: 17),
                      NSAttributedString.Key.foregroundColor : Asset._0085Ff.color]
        
        let attrs3 = [NSAttributedString.Key.font : UIFont.mySystemFont(ofSize: 17),
                      NSAttributedString.Key.foregroundColor : UIColor.black]
        
        
        
        let attributedString1 = NSMutableAttributedString(string:"On others device, enter address ", attributes:attrs1 as [NSAttributedString.Key : Any])
        
        let attributedString2 = NSMutableAttributedString(string:"\(textIP) ", attributes:attrs2 as [NSAttributedString.Key : Any])
        let attributedString3 = NSMutableAttributedString(string:" in the browser", attributes:attrs3 as [NSAttributedString.Key : Any])
        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        self.lbWifeName.attributedText = attributedString1
    }
    
}
extension TransferWifiVC: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      if status == .authorizedAlways || status == .authorizedAlways || status == .authorizedWhenInUse {
    }
  }
}
public class SSID {
    class func fetchNetworkInfo() -> [NetworkInfo]? {
        if let interfaces: NSArray = CNCopySupportedInterfaces() {
            var networkInfos = [NetworkInfo]()
            for interface in interfaces {
                let interfaceName = interface as! String
                var networkInfo = NetworkInfo(interface: interfaceName,
                                              success: false,
                                              ssid: nil,
                                              bssid: nil)
                if let dict = CNCopyCurrentNetworkInfo(interfaceName as CFString) as NSDictionary? {
                    networkInfo.success = true
                    networkInfo.ssid = dict[kCNNetworkInfoKeySSID as String] as? String
                    networkInfo.bssid = dict[kCNNetworkInfoKeyBSSID as String] as? String
                }
                networkInfos.append(networkInfo)
            }
            return networkInfos
        }
        return nil
    }
}

struct NetworkInfo {
    var interface: String
    var success: Bool = false
    var ssid: String?
    var bssid: String?
}
