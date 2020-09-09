//
//  File.swift
//  Runner
//
//  Created by Raviteja Aketi on 9/9/20.
//

import Foundation

class WhereAmIRunning {
    
    // MARK: Public
    
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

    private func hasEmbeddedMobileProvision() -> Bool{
        if let _ = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") {
            return true
        }
        return false
    }
    
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
    
    private func isSimulator() -> Bool {
        #if arch(i386) || arch(x86_64)
            return true
            #else
            return false
        #endif
    }
    
}
