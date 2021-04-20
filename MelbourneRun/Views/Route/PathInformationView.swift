//
//  PathInformationView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/4/21.
//

import SwiftUI

struct PathInformationView: View {
    var imageName:String
    var text:String
    var data:String
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(Color(.systemGray5))
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding()
                Image(systemName: imageName)
                .font(.system(size: 16, weight: .regular))}
            Text(text)
                .bold()
                .padding(.horizontal)
                
            Spacer()
            Text(data)
                .padding(.horizontal)
        }
    }
}


struct PathInformationStarView: View {
    var imageName:String
    var text:String
    var starNumber:Int
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(Color(.systemGray5))
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding()
                Image(systemName: imageName)
                .font(.system(size: 16, weight: .regular))}
            Text(text)
                .bold()
                .padding(.horizontal)
                
            Spacer()
            HStack{
                Image(systemName: starNumber>=5 ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                Image(systemName: starNumber>=4 ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                Image(systemName: starNumber>=3 ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                Image(systemName: starNumber>=2 ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                Image(systemName: starNumber>=1 ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
                .padding(.horizontal)
        }
    }
}


struct PathInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PathInformationView(imageName: "star", text: "Good", data: "2020")
    }
}
