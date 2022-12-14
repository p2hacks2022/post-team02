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
    var body: some View {
        NavigationStack {
            ZStack {
                Color.xGreen
                    .ignoresSafeArea()
                VStack {
                    Text("クリスマスに予定がありますか？?")
                        .foregroundColor(Color.white)
                        .padding(.bottom, 96.0)
                    
                    NavigationLink {
                        SelectSantaView()
                    } label: {
                        Text("ある！！")
                            .frame(width: 294, height: 54)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(27)
                            .padding(.bottom, 35.0)
                    }
                    
                    Text("ない…")
                        .frame(width: 294, height: 54)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(27)
                }
            }
            .navigationTitle("AskScheduleView")
            .navigationBarHidden(true)
            
        }
    }
}

struct SelectSantaView: View {
    
    @Environment(\.dismiss) var dismiss
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.red
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.xGreen
                    .ignoresSafeArea()
                Text("話を聞いてもらうサンタを選ぶ")
                    .foregroundColor(Color.white)
                    .frame(width: 395, height: 120)
                    .padding(.top, 30.0)
                    .background(Color.xRed)
                    .cornerRadius(20)
                    .padding(.bottom, 680.0)
                    .font(.system(size: 20))
                VStack {
                    HStack {
                        Circle()
                            .strokeBorder(Color.black)
                            .frame(width: 54, height: 54)
                            
                        VStack(alignment: .leading) {
                            Text("サンタ＝サン")
                                .fontWeight(.black)
                                .font(.system(size: 15))
                            Text("日本のクリスマスをずっと見てきた。ゆったり話を聞いてくれます。")
                                .font(.system(size: 13))
                        }
                        
                    }
                    .frame(width: 290.0, height: 54.0)
                    .padding(.horizontal, 18.0)
                    .padding(.vertical, 16.0)
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.bottom, 100.0)
                    
                    HStack {
                        Circle()
                            .strokeBorder(Color.black)
                            .frame(width: 54, height: 54)
                            
                        VStack(alignment: .leading) {
                            Text("サンタ＝マン")
                                .fontWeight(.black)
                                .font(.system(size: 15))
                            Text("アメリカ生まれのアメリカ育ち。ファンキーに話を聞いてくれます。")
                                .font(.system(size: 13))
                        }
                    }
                    .frame(width: 290.0, height: 54.0)
                    .padding(.horizontal, 18.0)
                    .padding(.vertical, 16.0)
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.bottom, 100.0)
                    
                    HStack {
                        Circle()
                            .strokeBorder(Color.black)
                            .frame(width: 54, height: 54)
                            
                        VStack(alignment: .leading) {
                            Text("サンタ＝イエア")
                                .fontWeight(.black)
                                .font(.system(size: 15))
                                
                            Text("世界中を飛び回っている。感情豊かに話を聞いてくれます")
                                .font(.system(size: 13))
                        }
                    }
                    .frame(width: 290.0, height: 54.0)
                    .padding(.horizontal, 18.0)
                    .padding(.vertical, 16.0)
                    .background(Color.white)
                    .cornerRadius(15)
                }
                .padding(.top, 60.0)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(
                        action: {
                            dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(Color.white)
                                Text("本当は予定がなかった…")
                                    .foregroundColor(Color.white)
                            }
                        }
                    )
                    Spacer()
                }
            }
        }
    }
}

struct CustomBackButton: ViewModifier {
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(
                        action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(Color.white)
                        }
                    )
                    Spacer()
                }
            }
    }
}

extension View {
    func customBackButton() -> some View {
        self.modifier(CustomBackButton())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AskScheduleView()
        // SelectSantaView()
    }
}
