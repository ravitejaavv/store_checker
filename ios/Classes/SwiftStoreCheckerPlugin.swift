import Flutter
import UIKit
import Foundation

public class SwiftStoreCheckerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "store_checker", binaryMessenger: registrar.messenger())
        let instance = SwiftStoreCheckerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    // Find the origin of installed app 
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let isTestFlight = isRunningInTestFlightEnvironment();
        let isAppStore = isAppStoreReceiptSandbox();
        if isTestFlight{
            result("TestFlight")
        }else if isAppStore{
            result("AppStore")
        }else{
            result("")
        }
    }
    
    // Check whether current app is TestFlight Beta app or not
    func isRunningInTestFlightEnvironment() -> Bool{
        if isSimulator() {
            return false
        } else {
            if isAppStoreReceiptSandbox() && !hasEmbeddedMobileProvision() {
                return true
            } else {
                return false
            }
        }
    }
    
    // Check whether current app is App Store build app or not
    func isRunningInAppStoreEnvironment() -> Bool {
        if isSimulator(){
            return false
        } else {
            if isAppStoreReceiptSandbox() || hasEmbeddedMobileProvision() {
                return false
            } else {
                return true
            }
        }
    }
    
    // Check whether current app is App is embedded or mobileprovision
    private func hasEmbeddedMobileProvision() -> Bool{
        if let _ = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") {
            return true
        }
        return false
    }
    
    // Check whether current app is App Store receipt sandbox app or not
    private func isAppStoreReceiptSandbox() -> Bool {
        if isSimulator() {
            return false
        } else {
            if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL {
                if appStoreReceiptURL.lastPathComponent == "sandboxReceipt" {
                    return true
                }
            }
            return false
        }
    }
    
    // Check current app is running on simulator or not
    private func isSimulator() -> Bool {
        #if arch(i386) || arch(x86_64)
        return true
        #else
        return false
        #endif
    }
}
