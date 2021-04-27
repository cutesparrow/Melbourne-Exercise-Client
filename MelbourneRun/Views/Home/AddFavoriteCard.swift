//
//  AddFavoriteCard.swift
//  MelbExercise
//
//  Created by gaoyu shi on 26/4/21.
//

import SwiftUI

struct AddFavoriteCard: View {
    var color:Color
    var body: some View {
//        WebImage(url: URL(string: NetworkManager.shared.urlBasePath + (gym.images?.allObjects as! [ImageCore])[0].name + ".jpg"))
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            color.opacity(0.8)
                            .clipShape(RoundedRectangle(cornerRadius: 15.0))
                            .frame(width: 150,height: 100)
                            
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))

                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(width: 150,height: 100)
            HStack{
                Text("Add")
                    .foregroundColor(.gray)
                    .bold()
                    .font(.title2)
                Image(systemName: "plus.circle")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.gray)
                    
            }
            .padding(.horizontal,10)
            .padding(.vertical,10)
            
            
        }.frame(width: 150,height: 100)
    }
}

struct AddFavoriteCard_Previews: PreviewProvider {
    static var previews: some View {
        AddFavoriteCard(color:AppColor.shared.gymColor)
    }
}
