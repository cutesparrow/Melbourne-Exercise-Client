//
//  PolicyView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 29/3/21.
//

import SwiftUI

struct PolicyView: View {
    let policy:AboutCovidCore
    var body: some View {
        VStack(alignment:.leading){
            Text(policy.title!+"?")
                .font(.title3)
                .bold()
                .foregroundColor(Color(.black))
            Text(policy.content!)
                .padding(.top)
                .foregroundColor(Color(.black))
        }
    }
}

