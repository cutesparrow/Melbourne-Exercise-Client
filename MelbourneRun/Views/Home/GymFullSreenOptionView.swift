//
//  FullSreenOptionView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/5/21.
//

import SwiftUI

struct GymFullSreenOptionView: View {
    @ObservedObject var gym:GymCore
    @Binding var showDetail:Bool
    @Binding var showRenameAlert:Bool
    var body: some View {
        if showRenameAlert{
            RenameGymAlert(gym: gym,showDetail:$showDetail)
                .onDisappear{
                    showRenameAlert.toggle()
                }
                .clearModalBackground()
        } else {
            GymCardOnHomePage(gym: gym, showThisCard: $showDetail)
            .clearModalBackground()}
    }
}

