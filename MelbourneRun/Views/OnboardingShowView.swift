//
//  testView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 27/3/21.
//

import SwiftUI


struct OnboardingShowView: View {
    @Binding var showGuideView:Bool
    var body: some View {
        let pages = (1...3).map { i in
            AnyView(OnboardingView(viewPage: i))
        }
        var a =  ConcentricOnboardingView(pages: pages, bgColors: [Color.yellow,Color.blue,Color.green])
        a.insteadOfCyclingToFirstPage = {
            showGuideView = false
        }
        return a
    }
}

struct OnboardingShowView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingShowView(showGuideView: .constant(false))
    }
}
