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
        let pages = (0...4).map { i in
            AnyView(OnboardingView(viewPage: i))
        }
        var onboardingView =  ConcentricOnboardingView(pages: pages, bgColors: [Color(hex: 0xdfecd5),Color(hex: 0xb598a1),Color(hex: 0x525288),Color(hex: 0xc04851),Color(hex: 0xF9F5ED)],duration: 0.6)
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
