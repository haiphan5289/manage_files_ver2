// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let _0085Ff = ColorAsset(name: "0085FF")
  internal static let _0085Ff50 = ColorAsset(name: "0085FF50")
  internal static let _494949 = ColorAsset(name: "494949")
  internal static let e42E2E = ColorAsset(name: "E42E2E")
  internal static let f1F1F1 = ColorAsset(name: "F1F1F1")
  internal static let fafafa = ColorAsset(name: "FAFAFA")
  internal static let black10 = ColorAsset(name: "black10")
  internal static let black40 = ColorAsset(name: "black40")
  internal static let black6 = ColorAsset(name: "black6")
  internal static let black60 = ColorAsset(name: "black60")
  internal static let whie3 = ColorAsset(name: "whie3")
  internal static let icRadioOff = ImageAsset(name: "ic_Radio_Off")
  internal static let icRadioOn = ImageAsset(name: "ic_Radio_On")
  internal static let icArrowBack = ImageAsset(name: "ic_arrow_back")
  internal static let icClose = ImageAsset(name: "ic_close")
  internal static let icDeleteBlack = ImageAsset(name: "ic_delete_black")
  internal static let icMore = ImageAsset(name: "ic_more")
  internal static let icMoreButton = ImageAsset(name: "ic_more_button")
  internal static let icMusic = ImageAsset(name: "ic_music")
  internal static let icOtherFolder = ImageAsset(name: "ic_other_folder")
  internal static let icPdf = ImageAsset(name: "ic_pdf")
  internal static let icPlusFolder = ImageAsset(name: "ic_plus_folder")
  internal static let icRotateLeft = ImageAsset(name: "ic_rotate_left")
  internal static let icSearch = ImageAsset(name: "ic_search")
  internal static let icSearchDark = ImageAsset(name: "ic_search_dark")
  internal static let icText = ImageAsset(name: "ic_text")
  internal static let icTick = ImageAsset(name: "ic_tick")
  internal static let icTickClose = ImageAsset(name: "ic_tick_close")
  internal static let icZip = ImageAsset(name: "ic_zip")
  internal static let imgArrowRight = ImageAsset(name: "img_arrow_right")
  internal static let imgCamera = ImageAsset(name: "img_camera")
  internal static let imgDrop = ImageAsset(name: "img_drop")
  internal static let imgFolder = ImageAsset(name: "img_folder")
  internal static let imgImportAddtion = ImageAsset(name: "img_import_addtion")
  internal static let imgPhoto = ImageAsset(name: "img_photo")
  internal static let imgPremium = ImageAsset(name: "img_premium")
  internal static let imgScan = ImageAsset(name: "img_scan")
  internal static let imgText = ImageAsset(name: "img_text")
  internal static let imgArchives = ImageAsset(name: "img_archives")
  internal static let imgDocs = ImageAsset(name: "img_docs")
  internal static let imgFolders = ImageAsset(name: "img_folders")
  internal static let imgImages = ImageAsset(name: "img_images")
  internal static let imgMusics = ImageAsset(name: "img_musics")
  internal static let imgOthers = ImageAsset(name: "img_others")
  internal static let imgTransfered = ImageAsset(name: "img_transfered")
  internal static let imgTrash = ImageAsset(name: "img_trash")
  internal static let imgVideos = ImageAsset(name: "img_videos")
  internal static let icCompress = ImageAsset(name: "ic_compress")
  internal static let icCopy = ImageAsset(name: "ic_copy")
  internal static let icDelete = ImageAsset(name: "ic_delete")
  internal static let icDuplicate = ImageAsset(name: "ic_duplicate")
  internal static let icInfo = ImageAsset(name: "ic_info")
  internal static let icMove = ImageAsset(name: "ic_move")
  internal static let icQuickview = ImageAsset(name: "ic_quickview")
  internal static let icRename = ImageAsset(name: "ic_rename")
  internal static let icShare = ImageAsset(name: "ic_share")
  internal static let icCheck = ImageAsset(name: "ic_check")
  internal static let icDeleteWhite = ImageAsset(name: "ic_delete_white")
  internal static let icDeselect = ImageAsset(name: "ic_deselect")
  internal static let icHelp = ImageAsset(name: "ic_help")
  internal static let icPrivacy = ImageAsset(name: "ic_privacy")
  internal static let icRate = ImageAsset(name: "ic_rate")
  internal static let icShareSetting = ImageAsset(name: "ic_share_setting")
  internal static let icTerm = ImageAsset(name: "ic_term")
  internal static let imgSetting = ImageAsset(name: "img_setting")
  internal static let icDownArrow = ImageAsset(name: "ic_down_arrow")
  internal static let icTabbarFolders = ImageAsset(name: "ic_tabbar_folders")
  internal static let icTabbarHome = ImageAsset(name: "ic_tabbar_home")
  internal static let icTabbarSettings = ImageAsset(name: "ic_tabbar_settings")
  internal static let icTabbarTools = ImageAsset(name: "ic_tabbar_tools")
  internal static let icTbSelectedFolders = ImageAsset(name: "ic_tb_selected_folders")
  internal static let icTbSelectedHome = ImageAsset(name: "ic_tb_selected_home")
  internal static let icTbSelectedSettings = ImageAsset(name: "ic_tb_selected_settings")
  internal static let icTbSelectedTools = ImageAsset(name: "ic_tb_selected_tools")
  internal static let imgHomeButton = ImageAsset(name: "img_home_button")
  internal static let imgFileTransfer = ImageAsset(name: "img_file_transfer")
  internal static let imgImgToPdf = ImageAsset(name: "img_img_to_pdf")
  internal static let imgImport = ImageAsset(name: "img_import")
  internal static let imgNotePad = ImageAsset(name: "img_notePad")
  internal static let imgVideoPlayer = ImageAsset(name: "img_video_player")
  internal static let icIp = ImageAsset(name: "ic_ip")
  internal static let icRound = ImageAsset(name: "ic_round")
  internal static let icWifi = ImageAsset(name: "ic_wifi")
  internal static let imgBgInapp = ImageAsset(name: "img_bg_inapp")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
