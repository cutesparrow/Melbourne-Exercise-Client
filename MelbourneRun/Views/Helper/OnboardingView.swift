//
//  test1.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 30/3/21.
//

import SwiftUI

struct OnboardingView: View {
    let viewPage:Int
    var body: some View {
        if viewPage == 1{
            OnboardingThree()
        } else if viewPage == 2{
            OnboardingFour()
        } else if viewPage == 3{
            OnboardingFive()
        } else if viewPage == 4{
            OnboardingSix()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewPage: 1)
    }
}
