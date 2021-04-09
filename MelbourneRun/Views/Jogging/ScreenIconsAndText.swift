//
//  testView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 8/4/21.
//

import SwiftUI
import FloatingButton





struct MainButton: View {
    
    var imageName: String
    var color: Color

    var width: CGFloat = 50

    var body: some View {
        ZStack {
            color
                .frame(width: width, height: width)
                .cornerRadius(width/2)
                .shadow(color: color.opacity(0.3), radius: 15, x: 0, y: 15)
            Image(systemName: imageName).foregroundColor(.white)
        }
    }
}



struct IconAndTextButton: View {
    @State var selectedSheet:String
    @EnvironmentObject var userData:UserData
    @Binding var mainswitch:Bool
    @Binding var isshow:Bool
    @Binding var sheetKind:Int
    var imageName: String
    var buttonText: String
    let imageWidth: CGFloat = 22
    var body: some View {
        Button(action: {self.isshow.toggle()
            self.mainswitch.toggle()
            if selectedSheet == "popular"{
                sheetKind = 1
            } else{
                sheetKind = 2
            }
        }, label: {
            ZStack {
                Color.white
                HStack {
                    Image(systemName: self.imageName)
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(Color(hex: "778ca3"))
                        .frame(width: self.imageWidth, height: self.imageWidth)
                        .clipped()
                    Spacer()
                    Text(buttonText)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(Color(hex: "4b6584"))
                    Spacer()
                }.padding(.leading, 15).padding(.trailing, 15)
            }
            .frame(width: 160, height: 45)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "F4F4F4"), lineWidth: 1)
            )
        })
    }
}

struct MockData {

    static let iconAndTextImageNames = [
        "star.circle",
        "pencil.circle"
    ]

    static let iconAndTextTitles = [
        "Popular",
        "Customize"
    ]
}

extension Color {
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
    
}
