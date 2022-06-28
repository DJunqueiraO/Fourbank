//
//  BarCodeView.swift
//  Fourbank
//
//  Created by Josicleison on 17/06/22.
//
import SwiftUI
import CodeScanner

@available(iOS 13.0, *)

struct BarCodeView: View {
    
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a QR code to get started."

    var scannerSheet: some View {

        CodeScannerView(
            codeTypes: [.code128],
            completion: {result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPresentingScanner = false
                }
            }
        )
    }
    
    var body: some View {
        
        self.scannerSheet
    }
}

struct BarCodeView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        QrCodeView()
    }
}
