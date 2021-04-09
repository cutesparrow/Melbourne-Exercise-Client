//
//  JoggingMainListButton.swift
//  MelbExercise
//
//  Created by gaoyu shi on 8/4/21.
//

import SwiftUI



struct JoggingMainListButton: View {

    var imageName: String
    var buttonText: String

    let imageWidth: CGFloat = 22

    var body: some View {
        ZStack {
            Color.white

            HStack {
                Image(systemName: self.imageName)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .foregroundColor(Color(hex: 0x778ca3))
                    .frame(width: self.imageWidth, height: self.imageWidth)
                    .clipped()
                Spacer()
                Text(buttonText)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(Color(hex: 0x4b6584))
                Spacer()
            }.padding(.leading, 15).padding(.trailing, 15)
        }
        .frame(width: 160, height: 45)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 1)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: 0xF4F4F4), lineWidth: 1)
        )
    }
}

struct JoggingMainListButton_Previews: PreviewProvider {
    static var previews: some View {
        JoggingMainListButton(imageName: "star", buttonText: "starred")
    }
}

