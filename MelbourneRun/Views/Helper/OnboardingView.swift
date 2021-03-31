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
            Text("1")
        } else if viewPage == 2{
            Text("2")
        } else if viewPage == 3{
            Text("3")
        } else if viewPage == 4{
            Text("4")
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewPage: 1)
    }
}
