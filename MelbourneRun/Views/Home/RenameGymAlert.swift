//
//  RenameAlert.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/5/21.
//

import SwiftUI

struct RenameGymAlert: View {
    @ObservedObject var gym:GymCore
    @Environment(\.managedObjectContext) var context
    @State var newName:String = ""
    @Binding var showDetail:Bool
    func rename() -> Void{
        if !newName.isEmpty{
            context.performAndWait {
            withAnimation {
                gym.showName = newName
                try? context.save()
            }
        }
        }
    }
    var body: some View {
        ZStack{
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
                .cornerRadius(20.0)
                .shadow(radius: 6)
            VStack{
                Text("Rename")
                    .font(.title2)
                
                TextField("New name ...", text: $newName)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "pencil.circle")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                        
                        }
                    )
                    .frame(width:UIScreen.main.bounds.width/2)
                    .padding()
                HStack{
                    Button(action: {
                        showDetail.toggle()
                    }, label: {
                        Text("Cancel")
                            .frame(width: 70)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.2)))
                            
                    })
                    Spacer(minLength: 0)
                        .frame(width:30)
                    Button(action: {
                        rename()
                        showDetail.toggle()
                    }, label: {
                        Text("OK")
                            .frame(width: 70)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.2)))
                    })
                }
            }
        }.frame(width: UIScreen.main.bounds.width/1.4, height: 200, alignment: .center)
    }
}


