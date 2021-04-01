//
//  NoDivider.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 25/3/21.
//

import Foundation
import SwiftUI

struct NoButtonStyle: ButtonStyle { //no divider list
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

struct ListWithoutSepatorsAndMargins<Content: View>: View { //no divider list struct
        let content: () -> Content
    
        var body: some View {
            if #available(iOS 14.0, *) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        self.content()
                    }
                    .buttonStyle(NoButtonStyle())
                }
            } else {
                List {
                    self.content()
                }
                .listStyle(PlainListStyle())
                .buttonStyle(NoButtonStyle())
            }
        }
    }
