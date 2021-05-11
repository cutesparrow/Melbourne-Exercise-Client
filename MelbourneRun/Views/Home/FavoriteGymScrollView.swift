//
//  FavoriteScrollView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 26/4/21.
//

import SwiftUI

struct FavoriteGymScrollView: View {
    @Binding var bottomBarSelected:Int
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)],predicate: NSPredicate(format: "star == %i", true)) var result: FetchedResults<GymCore>
//    @State var showRenameAlert:Bool = false
    @State var newName:String = ""
    var body: some View {
        
        VStack(alignment:.leading){
//            Text("Favorite Gyms")
//                .font(.title3)
//                .bold()
//                .foregroundColor(Color(.label))
//                .padding(.leading)
//                .padding(.bottom,-5)
        
            ScrollView(.horizontal,showsIndicators: false){
                
                HStack{
                    ForEach(self.result){ gym in
                        FavoriteGymCard(gym:gym)
                            .padding(.leading)
                            
                    }
                    AddFavoriteCard(color: Color(.systemBackground))
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation{bottomBarSelected = 1}
                        }
                }
                
            }
            
        }
    }
}

extension View {

    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        title: String) -> some View {
        TextFieldAlert(isShowing: isShowing,
                       text: text,
                       presenting: self,
                       title: title)
    }

}


struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    @Binding var text: String
    let presenting: Presenting
    let title: String

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(isShowing)
                VStack {
                    Text(self.title)
                    TextField("Rename", text: $text)
                    Divider()
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.isShowing.toggle()
                            }
                        }) {
                            Text("Cancel")
                        }
                        Button(action: {
                            withAnimation {
                                self.isShowing.toggle()
                            }
                        }) {
                            Text("Ok")
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .frame(
                    width: deviceSize.size.width*0.7,
                    height: deviceSize.size.height*0.7
                )
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }

}
