//
//  JoggingHomeView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 25/3/21.
//

import SwiftUI

struct JoggingHomeView: View {
    @EnvironmentObject var userData:UserData
    var body: some View {
        Text("Coming soon!")
            .font(.title3)
            .navigationTitle("Jogging")
            .navigationBarTitleDisplayMode(.large)
    }
}

struct JoggingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        JoggingHomeView()
            .environmentObject(UserData())
    }
}
