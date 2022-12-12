//
//  ContentView.swift
//  santa
//
//  Created by enPiT2016MBP-04 on 2022/12/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                SecondView()
            } label: {
                Label("Go Second View", systemImage: "figure.walk")
                    .font(.title)
                    .foregroundColor(Color.white)
                    
            }
            .frame(width: 300.0, height: 100.0)
            .background(Color.orange)
            .cornerRadius(50)
            .navigationTitle("TopView")
            .navigationBarHidden(true)
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Text("SecondView")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
