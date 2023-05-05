//
//  LMFontDownloadManager.swift
//  LoginModule
//
//  Created by WJK on 2022/3/26.
//

import UIKit
import SSZipArchive
import HBPublic

var locationFontPatch: URL = {
    let cacheURL = URL(fileURLWithPath: FileManager.default.cachesDirectory)
    let finalUrl =  cacheURL.appendingPathComponent("peipeiFont")
    return finalUrl
}()
public class PPFontDownloadManager: NSObject {
        /// 是否下载完成
        var isDownload = false
    /// 能使用下载字体
    public  var useDownLoadFont = false

        /// 路径
        var  fontPath: String?
        static var instance = PPFontDownloadManager()
    public  static func share() -> PPFontDownloadManager {
            return instance
        }

//    NSString *imgFilePath = [filePath path];
//    NSURL *fontUrl = [NSURL fileURLWithPath:imgFilePath];
//    CGDataProviderRef fontDataProvider =  CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
//    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
//    CGDataProviderRelease(fontDataProvider);
//    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
//    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
//    label.font = [UIFont fontWithName:fontName size:24];
    var regularFontPath = ""
    var mediumFontPath = ""
    var boldFontPath = ""
    var normalFontPath = ""
    var youSheBiaoTiHeiFontPath = ""

    public  class func canUseDownLoadFont() -> Bool {
        PPFontDownloadManager.share().useDownLoadFont && PPFontDownloadManager.share().useDownLoadFont
    }

    public  func getFontName() -> String {
        if !NSString.isEmpty(normalFontPath) {
            return normalFontPath
        }
        let fontUrl = locationFontPatch.appendingPathComponent("YouSheBiaoTiHei.ttf")
        guard let fontDataProvider = CGDataProvider(url: fontUrl as CFURL) else { return "" }
        guard let fontRef = CGFont(fontDataProvider) else { return "" }
        CTFontManagerRegisterGraphicsFont(fontRef, nil)
        guard  let fontName =  fontRef.postScriptName else {return ""}
        normalFontPath = fontName as String
        return fontName as String
    }

    public func getRegularFontName() -> String {
        if !NSString.isEmpty(regularFontPath) {
            return regularFontPath
        }
        let fontUrl = locationFontPatch.appendingPathComponent("Alibaba-PuHuiTi-Regular.ttf")
        guard let fontDataProvider = CGDataProvider(url: fontUrl as CFURL) else { return "" }
        guard let fontRef = CGFont(fontDataProvider) else { return "" }
        CTFontManagerRegisterGraphicsFont(fontRef, nil)
        guard  let fontName =  fontRef.postScriptName else {return ""}
        regularFontPath = fontName as String
        return fontName as String
    }

    public func getMediumFontName() -> String {
        if !NSString.isEmpty(mediumFontPath) {
            return mediumFontPath
        }
        let fontUrl = locationFontPatch.appendingPathComponent("Alibaba-PuHuiTi-Medium.ttf")
        guard let fontDataProvider = CGDataProvider(url: fontUrl as CFURL) else { return "" }
        guard let fontRef = CGFont(fontDataProvider) else { return "" }
        CTFontManagerRegisterGraphicsFont(fontRef, nil)
        guard  let fontName =  fontRef.postScriptName else {return ""}
        mediumFontPath = fontName as String
        return fontName as String
    }

    public  func getBoldFontName() -> String {
        if !NSString.isEmpty(boldFontPath) {
            return boldFontPath
        }
        let fontUrl = locationFontPatch.appendingPathComponent("Alibaba-PuHuiTi-Bold.ttf")
        guard let fontDataProvider = CGDataProvider(url: fontUrl as CFURL) else { return "" }
        guard let fontRef = CGFont(fontDataProvider) else { return "" }
        CTFontManagerRegisterGraphicsFont(fontRef, nil)
        guard  let fontName =  fontRef.postScriptName else {return ""}
        boldFontPath = fontName as String
        return fontName as String
    }

    public  func getYouSheBiaoTiHeiFontName() -> String {
        if !NSString.isEmpty(youSheBiaoTiHeiFontPath) {
            return youSheBiaoTiHeiFontPath
        }
        let fontUrl = locationFontPatch.appendingPathComponent("YouSheBiaoTiHei.ttf")
        guard let fontDataProvider = CGDataProvider(url: fontUrl as CFURL) else { return "" }
        guard let fontRef = CGFont(fontDataProvider) else { return "" }
        CTFontManagerRegisterGraphicsFont(fontRef, nil)
        guard  let fontName =  fontRef.postScriptName else {return ""}
        youSheBiaoTiHeiFontPath = fontName as String
        return fontName as String
    }
}

/// 下载字体
extension PPFontDownloadManager {
    /// 是否下载完成
    public  static func hasDownloadCompletes() -> Bool {
        return getDownFont()
    }

    static func checkisExistFontPath() -> Bool {// 检查字体文件是否真实存在
        let fileManager = FileManager.default
        let fontUrl = locationFontPatch.appendingPathComponent("Alibaba-PuHuiTi-Medium.ttf")
        let filePath = fontUrl.path
        return fileManager.fileExists(atPath: filePath)
    }
    /// 下载
    public   static func downLoadFont() {
        let isExistfile = checkisExistFontPath()

        if hasDownloadCompletes() && isExistfile {// 已经下载完成
            PPFontDownloadManager.share().isDownload = true
            return
        }
       let urlString = "https://ppx-resource.peipeijiaoyou.cn/peipeix-fonts.zip"
       guard let url = URL(string: urlString) else {return}
       let request = URLRequest(url: url)

       let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
       let manager  = AFURLSessionManager(sessionConfiguration: configuration)

        let _downloadTask = manager.downloadTask(with: request, progress: { progress in
            print(progress.completedUnitCount)
        }) { _, _ in

           guard  let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last else {return URL(fileURLWithPath: "")}
           // - block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
            let path = NSString(string: cachesPath).appendingPathComponent("peipeiFounZip")
            createFile(urlStr: path)
            let ext = (urlString as NSString).pathExtension
            let cacheURL = URL(fileURLWithPath: FileManager.default.cachesDirectory)
            let finalUrl = cacheURL.appendingPathComponent(urlString.md5).appendingPathExtension(ext)
           return finalUrl
       } completionHandler: { _, filePath, error in

           if error != nil {
               debugPrint("下载失败", error!)
               PPMonitorManager.sendLog(event: PPMonitorEvent.fontDownloadFail, andContent: error.debugDescription )
               return
           }
           // 下载完成
           if let fontPath = filePath?.path {
               DispatchQueue.global().async {

                   let tagartPath = locationFontPatch.path
                   let unzipSuccess = PPFontDownloadManager.share().releaseZipFilesWithUnzipFileAtPath(zipPath: fontPath, unzipPath: tagartPath)
                   debugPrint("下载-----", unzipSuccess)
                   if unzipSuccess {
                       PPFontDownloadManager.share().isDownload = true
                       PPFontDownloadManager.share().fontPath = fontPath
                       saveFontKey()
                   } else {
                       PPMonitorManager.sendLog(event: PPMonitorEvent.fontUnzipFail, andContent: urlString )
                   }
               }
           }

       }
       _downloadTask.resume()
    }

    /// 下载的第二种
    static  func down2(comp:@escaping (_ path: URL?) -> Void) {

        //        down2 { path in
        //            print(path)
        //            let cacheURL = URL(fileURLWithPath: FileManager.default.cachesDirectory)
        //           var path2 = cacheURL.appendingPathComponent("peipeiFoun")
        //            createFile(urlStr: path2.path)
        //            let tagartPath = path2.path
        //            guard let zipPath = path?.path  else {
        //                return
        //            }
        //            let unzipSuccess = DMDownloadManager.share().releaseZipFilesWithUnzipFileAtPath(zipPath:zipPath , unzipPath: tagartPath)
        //           debugPrint("下载-----",unzipSuccess)
        //        }
        //        return

        let urlString = "https://ppx-resource.peipeijiaoyou.cn/peipeix-fonts.zip"
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)

        let attachmentURL = request
        /** 开启线程去下载*/
        DispatchQueue.global().async {
            let urlSession = URLSession.shared.dataTask(with: attachmentURL, completionHandler: { (data, _, _) in
                /** 下载完毕，或者报错，转到主线程中*/
                DispatchQueue.main.async {

                    if let data = data {
                        /** 加工目的 url，将下载好的推送附件添加到沙盒中*/
                        let ext = (urlString as NSString).pathExtension
                        let cacheURL = URL(fileURLWithPath: FileManager.default.cachesDirectory)
                        let finalUrl = cacheURL.appendingPathComponent(urlString.md5).appendingPathExtension(ext)
                        /** 将下载好的附件写入沙盒*/
                        if let _ = try? data.write(to: finalUrl) {
                            comp(finalUrl)

                        } else {
                            comp(nil)
                        }
                    } else {
                        comp(nil)
                    }
                }
            })
            urlSession.resume()
        }
    }
}

// 获取沙盒地址
extension FileManager {
    var cachesDirectory: String {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }

    var documentDirectory: String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}

public extension String {
    var md5: String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        if let data = data(using: .utf8) {
            data.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> Void in
                CC_MD5(bytes, CC_LONG(data.count), &digest)
            }
        }
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }

    func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
}

/// 解压
extension PPFontDownloadManager: SSZipArchiveDelegate {
    func releaseZipFilesWithUnzipFileAtPath(zipPath: String, unzipPath: String) -> Bool {
       return SSZipArchive.unzipFile(atPath: zipPath, toDestination: unzipPath, delegate: self)
    }
    public func zipArchiveWillUnzipArchive(atPath path: String, zipInfo: unz_global_info) {
        debugPrint("将要解压。\(XHBDateUtil.getSysRealTime())")
    }
    public func zipArchiveDidUnzipArchive(atPath path: String, zipInfo: unz_global_info, unzippedPath: String) {
        debugPrint("解压完成\(XHBDateUtil.getSysRealTime())")
    }

    static  func createFile(urlStr: String) {
        let fm = FileManager.default
        let folderPath = urlStr
        if !fm.fileExists(atPath: folderPath) {
            do {
                try fm.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("failed to create folder: \(error.localizedDescription)")
            }
        }
    }
}

extension PPFontDownloadManager {

    static func saveFontKey() {
        XHBUserDefaultsUtils.store(toUserDefault: ("1" as NSString), key: "downLoadFontKey")
    }
    static func getDownFont() -> Bool {
        return (XHBUserDefaultsUtils.getValue("downLoadFontKey") as? String ?? "0") == "1"
    }

}
