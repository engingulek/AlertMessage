//
//  File.swift
//  
//
//  Created by engin gülek on 10.10.2023.
//

import SwiftUI
public enum AlertIcon: String {
    
    case multiplyCircle = "multiply.circle"
    
    var icon : Image {
       Image(systemName: String(rawValue))
    }
}
