//
//  PolicyView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 29/3/21.
//

import SwiftUI

struct PolicyView: View {
    let policy:SafetyPolicy
    var body: some View {
        VStack{
            
                Text(policy.title)
                
                .font(.title3)
                .bold()
                    .lineLimit(1)
                .foregroundColor(Color(.label))
            Text(policy.date)
                .font(.caption)
                .foregroundColor(Color(.label))
            
            
          
            
            Text(policy.content)
                .padding(.top)
        }
    }
}

struct PolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PolicyView(policy: SafetyPolicy(id: 1, date: "", title: "", content: ""))
    }
}
