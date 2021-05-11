//
//  LegendView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 29/3/21.
//

import SwiftUI

struct LegendView: View {
    var body: some View {
        VStack(spacing:0){
            Text("Risk Level")
                .font(.caption)
                .foregroundColor(Color(.label))
            HStack{
                Circle()
                    .fill(AppColor.shared.highRiskColor)
                    .frame(width: 10, height: 10)
                Text("high")
                    .foregroundColor(Color(.label))
                    .font(.caption2)
                
                Circle()
                    .fill(AppColor.shared.midRiskColor)
                    .frame(width: 10, height: 10)
                Text("medium")
                    .foregroundColor(Color(.label))
                    .font(.caption2)
                
                Circle()
                    .fill(AppColor.shared.lowRiskColor)
                    .frame(width: 10, height: 10)
                Text("low")
                    .foregroundColor(Color(.label))
                    .font(.caption2)
                
                Circle()
                    .fill(AppColor.shared.noRiskColor)
                    .frame(width: 10, height: 10)
                Text("no")
                    .foregroundColor(Color(.label))
                    .font(.caption2)
                
            }
        }
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView()
    }
}
