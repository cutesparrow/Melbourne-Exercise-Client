//
//  MainStyleButton.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 25/3/21.
//

import SwiftUI

struct MainStyleButton: View {
    var icon:String
    var color:Color
    var text:String
    var body: some View {
        HStack {
            if icon != ""{
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(color)
            }
            
            if text != ""{
                Text(text)
                    .foregroundColor(color)
                    .font(.caption)
                    .fontWeight(.bold)}
            
        }
        .frame(width:70)
        .padding()
        .background(
            Capsule()
                .fill(color.opacity(0.2))
        )
    }
}

struct DetailPageButton: View {
    var icon:String
    var color:Color
    var text:String
    var body: some View {
        HStack {
            if icon != ""{
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(color)
            }
            
            if text != ""{
                Text(text)
                    .foregroundColor(color)
                    .font(.caption)
                    .fontWeight(.bold)}
            
        }
        .frame(width:90)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(color.opacity(0.2))
        )
    }
}

struct MainStyleButton_Previews: PreviewProvider {
    static var previews: some View {
        MainStyleButton(icon: "", color: .purple,text: "Go")
    }
}
