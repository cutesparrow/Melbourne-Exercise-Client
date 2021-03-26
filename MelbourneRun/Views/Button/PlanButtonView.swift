//
//  PlanButtonView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 22/3/21.
//

import SwiftUI

struct PlanButtonView: View {
    @Binding var bottomSheetIsShow: Bool

    var body: some View {
        Button(action: {
            bottomSheetIsShow.toggle()
        }) {
            
            DetailPageButton(icon: "book.closed", color: .red, text: "PLAN")
        }
    }
}

