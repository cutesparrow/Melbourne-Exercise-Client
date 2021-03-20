//
//  Activity.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 14/3/21.
//

import SwiftUI

struct ActivityView: View {
    var activity:Activity
    var body: some View {
        HStack{
            Spacer()
        ZStack{
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(activity.RoundedRectangleColor)
                .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.width/5)
            Text(activity.name)
                .foregroundColor(activity.textColor)
                .offset(CGSize(width: -80.0, height: 0.0))
            activity.logo
                .font(.system(size: UIScreen.main.bounds.width/9, weight: .regular))
                .offset(CGSize(width: 90.0, height: 0.0))
        }
            Spacer()
    }
    }
    
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activity: activities.list[0])
    }
}
