//
//  AnnotationView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 19/5/21.
//

import SwiftUI

struct AnnotationView: View,Equatable {
    static func == (lhs: AnnotationView, rhs: AnnotationView) -> Bool {
        return lhs.mark.uid == lhs.mark.uid
    }
    
    
    @Binding var selectedGymUid:Int
    var mark:GymCore
    var body: some View {
        
        Button {
            withAnimation {
                self.selectedGymUid = Int(mark.uid)
            }
    } label: {
        RoundedGymIconOnMapView(name:mark.name)
            .clipShape(Circle())
                .overlay(Circle().stroke(selectedGymUid == Int(mark.uid) ? Color(.green).opacity(0.5) : AppColor.shared.joggingColor.opacity(0.5),lineWidth: 1.4))
            .scaleEffect(selectedGymUid == Int(mark.uid) ? 2 : 1)
            .shadow(radius: 5)
            
    }
    }
}


