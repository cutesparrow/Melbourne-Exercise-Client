//
//  test1.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 30/3/21.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var show:Bool
    let viewPage:Int
    var body: some View {
        if viewPage == 0{
            OnboardingZero(show:$show)
        }
        else if viewPage == 1{
            OnboardingThree(show:$show)
        } else if viewPage == 2{
            OnboardingFour(show:$show)
        }
//        } else if viewPage == 3{
//            OnboardingFive(show:$show)
//        } else if viewPage == 4{
//            OnboardingSix()
//        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(show: .constant(true), viewPage: 1)
    }
}
