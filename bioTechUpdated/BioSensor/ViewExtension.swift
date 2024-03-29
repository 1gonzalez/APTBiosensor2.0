//
//  ViewExtension.swift
//  BioSensor
//
//  Created by Juan on 3/6/23.
//

import SwiftUI

extension View {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
       
        return root
    }
}

