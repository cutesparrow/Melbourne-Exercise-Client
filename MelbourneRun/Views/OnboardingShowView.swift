//
//  testView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 27/3/21.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct OnboardingShowView: View {
    @Binding var showGuideView:Bool
    var body: some View {
        let pages = (0...2).map { i in
            AnyView(OnboardingView(show: $showGuideView, viewPage: i))
        }
        var onboardingView =  ConcentricOnboardingView(pages: pages, bgColors: [.white,.white,.white],duration: 0.6)
        onboardingView.insteadOfCyclingToFirstPage = {
            showGuideView = false
        }
        return onboardingView
    }
}

struct OnboardingShowView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingShowView(showGuideView: .constant(false))
    }
}
