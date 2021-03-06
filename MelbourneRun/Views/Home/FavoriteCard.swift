//
//  FavoriteCard.swift
//  MelbExercise
//
//  Created by gaoyu shi on 26/4/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteCard: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var gym:GymCore
    @State var showDetail:Bool = false
//    @StateObject var customAlertManager = CustomAlertManager()
    var body: some View {
//        WebImage(url: URL(string: NetworkManager.shared.urlBasePath + (gym.images?.allObjects as! [ImageCore])[0].name + ".jpg"))
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            Button {
                print(gym.name)
//                customAlertManager.show()
                showDetail.toggle()
            } label: {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){
                    WebImage(url: URL(string: NetworkManager.shared.urlBasePath + (gym.images?.sortedArray(using: [NSSortDescriptor(keyPath: \ImageCore.uid, ascending: true)]) as! [ImageCore])[0].name + ".jpg"))
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 15.0))
                            .frame(width: 150,height: 100)
            VisualEffectView(effect: UIBlurEffect(style: .light))

                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(width: 150,height: 100)
            VStack(alignment:.leading){
                Text(gym.name)
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(1)
                HStack{
                    Text("\(gym.distance.description) KM")
                        .font(.caption)
                        .foregroundColor(.white)
                        .bold()
                        
                        .lineLimit(1)
                    Spacer(minLength: 0)
                    
                }.padding(.top,20)
            }
            .padding(.horizontal,10)
            .padding(.vertical,10)
                }
            }

            
            Button(action: {
                context.performAndWait {
                    withAnimation {
                        gym.star.toggle()
                        try? context.save()
                    }
                }
                if gym.star{
                    print("liked")
                } else{
                    print("disliked")
                }
                
            }) {
                Image(systemName: gym.star ? "heart.fill" : "heart")
                    .foregroundColor(AppColor.shared.gymColor)
                    .font(.title)
                    
            }.offset(x:100,y:55)
        }
        .frame(width: 150,height: 100)
        .fullScreenCover(isPresented: $showDetail) {
            
            GymCardOnHomePage(gym: gym, showThisCard: $showDetail)
                .clearModalBackground()
//                .background(BackgroundBlurView())
        }
        
    }
}


//struct BackgroundBlurView: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//        let view = UIColor(.clear)
////            UIVisualEffectView(effect: UIBlurEffect(style: .light))
//        DispatchQueue.main.async {
//            view.superview?.superview?.backgroundColor = .clear
//        }
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {}
//}
