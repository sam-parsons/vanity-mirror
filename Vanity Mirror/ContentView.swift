//
//  ContentView.swift
//  Vanity Mirror
//
//  Created by Sam Parsons on 6/28/20.
//  Copyright © 2020 Sam Parsons. All rights reserved.
//

import Cocoa
import SwiftUI
import AVFoundation

struct ContentView: View {
    
    weak var camera: NSView!
    
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    var body: some View {
        
        Text("Hello, World!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
