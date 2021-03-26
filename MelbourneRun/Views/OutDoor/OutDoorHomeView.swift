//
//  OutDoorHomeView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 25/3/21.
//

import SwiftUI

struct OutDoorHomeView: View {
    @EnvironmentObject var userData:UserData
    var body: some View {
        Text("Coming soon!")
            .font(.title3)
            .navigationTitle("Outdoor")
            .navigationBarTitleDisplayMode(.large)
    }
}

struct OutDoorHomeView_Previews: PreviewProvider {
    static var previews: some View {
        OutDoorHomeView()
            .environmentObject(UserData())
    }
}
