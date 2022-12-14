//
//  ContentView.swift
//  santa
//
//  Created by enPiT2016MBP-04 on 2022/12/11.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            NavigationLink{
                AskScheduleView()
            } label: {
                ZStack{
                    VStack{
                        Image("HomeView_back")
                            .ignoresSafeArea()
                    }
                    
                    Text("TAP to TALK")
                        .font(.custom("AB-hanamaki", size: 15))
                        .foregroundColor(Color.white)
                        .padding(.top, 700)
                        //.position(x: 137+115/2, y: 767)
                }
            }
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
                    Text("クリスマスに予定がありますか？")
                        .font(.custom("AB-hanamaki", size: 20))
                        .foregroundColor(Color.white)
                        .padding(.top, 90.0)
                        .padding(.bottom, 141.0)
                    
                    NavigationLink {
                        TestView()
                        //SelectSantaView()
                    } label: {
                        Text("ある！")
                            .font(.custom("AB-hanamaki", size: 20))
                            .frame(width: 294, height: 54)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(27)
                            .padding(.bottom, 35.0)
                    }
                    
                    Text("ない...")
                        .font(.custom("AB-hanamaki", size: 20))
                        .frame(width: 294, height: 54)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(27)
                        .padding(.bottom, 84.0)
                    
                    Image("santa")
                        .padding(.leading, 50.0)
                }
            }
            .navigationTitle("AskScheduleView")
            .navigationBarHidden(true)
            
        }
    }
}

/*
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
*/

struct TestView: View {
    var body: some View {
        Text("test")
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
        //HomeView()
        AskScheduleView()
        // SelectSantaView()
    }
}
