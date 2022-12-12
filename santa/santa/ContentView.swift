//
//  ContentView.swift
//  santa
//
//  Created by enPiT2016MBP-04 on 2022/12/11.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.xRed
                    .ignoresSafeArea()
            }
            .navigationTitle("FirstView")
        }
    }
}

struct AskScheduleView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.xGreen
                .ignoresSafeArea()
            VStack {
                Text("クリスマスに予定がありますか？")
                    .foregroundColor(Color.white)
                    .padding(.bottom, 96.0)
                Text("ある！！")
                    .frame(width: 294, height: 54)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(27)
                    .padding(.bottom, 35.0)
                Text("ない…")
                    .frame(width: 294, height: 54)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(27)
            }
        }
        .navigationTitle("AskScheduleView")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        Text("<")
                    }
                ).tint(Color.orange)
            }
        }
    }
}

struct SelectSantaView: View {
    var body: some View {
        ZStack {
            Color.xGreen
                .ignoresSafeArea()
            VStack {
                HStack {
                    Circle()
                        .strokeBorder(Color.black)
                        .frame(width: 54, height: 54)
                        
                    VStack(alignment: .leading) {
                        Text("サンタ＝サン")
                        Text("日本のクリスマスをずっと見てきた。ゆったり聞いてくれます。")
                    }
                    .font(.system(size: 14))
                }
                .frame(width: 290.0, height: 54.0)
                .padding(.horizontal, 18.0)
                .padding(.vertical, 16.0)
                .background(Color.white)
                .cornerRadius(15)
                .padding(.bottom, 114.0)
                
                HStack {
                    Circle()
                        .strokeBorder(Color.black)
                        .frame(width: 54, height: 54)
                        
                    VStack(alignment: .leading) {
                        Text("サンタ＝サン")
                        Text("日本のクリスマスをずっと見てきた。ゆったり聞いてくれます。")
                    }
                    .font(.system(size: 14))
                }
                .frame(width: 290.0, height: 54.0)
                .padding(.horizontal, 18.0)
                .padding(.vertical, 16.0)
                .background(Color.white)
                .cornerRadius(15)
                .padding(.bottom, 114.0)
                
                HStack {
                    Circle()
                        .strokeBorder(Color.black)
                        .frame(width: 54, height: 54)
                        
                    VStack(alignment: .leading) {
                        Text("サンタ＝サン")
                        Text("日本のクリスマスをずっと見てきた。ゆったり聞いてくれます。")
                    }
                    .font(.system(size: 14))
                }
                .frame(width: 290.0, height: 54.0)
                .padding(.horizontal, 18.0)
                .padding(.vertical, 16.0)
                .background(Color.white)
                .cornerRadius(15)
            }
            .padding(.top, 60.0)
            Text("話を聞いてもらうサンタを選ぶ")
                .foregroundColor(Color.white)
                .frame(width: 395, height: 100)
                .background(Color.xRed)
                .padding(.bottom, 700.0)
                .font(.system(size: 20))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // AskScheduleView()
        SelectSantaView()
    }
}
