//
//  chatViewComtroller.swift
//  santa
//
//  Created by enPiT2016MBP-04 on 2022/12/17.
//

import Foundation
import WebKit
import SwiftUI
import FirebaseFirestore

struct ChatViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ChatViewController {
        return ChatViewController()
    }
    
    func updateUIViewController(_ uiViewController: ChatViewController, context: Context) {
        
    }
}

class ChatViewController: UIViewController, WKScriptMessageHandler {
    private var webView: WKWebView!
    
    private let apiKey = "a4ba4aa7-94a2-4834-ab75-01ea506d9d81185207859ef20e"
    private let uid = UUID().uuidString
    
    var cnt = 0
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        let userContentController: WKUserContentController = WKUserContentController()
        userContentController.add(self, name: "meboCallBack")
        config.userContentController = userContentController
        webView = WKWebView(frame: .zero, configuration: config)
        webView.load(URLRequest(url: URL(string: "https://mebo.work/chat/f499efbc-0c02-4899-8fc0-e10e82dec4be1852076c39eb4?name=%E3%82%B5%E3%83%B3%E3%82%BF&platform=webview")!))
        view = webView
    }
    
    //meboのチャット画面から送られてくる情報をハンドリング
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        struct ChatEvent: Codable {
            let event: String
            let bestResponse: BestResponse?
            let extensions: Extensions?
        }
        
        struct BestResponse: Codable {
            let utterance: String
            let options: [String]
        }
        
        struct Extensions: Codable {
            let appAction: String?
            let f_where: String?
            let s_time: String?
            let e_time: String?
        }
        
        struct ChatError: Codable {
            let error: ChatErrorResponse
        }
        
        struct ChatErrorResponse: Codable {
            let code: Int
            let message: String
        }
        
        guard let json = (message.body as? String)?.data(using: .utf8) else {
            return
        }
        let decoder = JSONDecoder()
        guard let chatEvent: ChatEvent = try? decoder.decode(ChatEvent.self, from: json) else {
            if let error: ChatError = try? decoder.decode(ChatError.self, from: json) {
                print(error.error.message)
                return
            }
            fatalError("不明なエラー")
        }
        
        switch chatEvent.event {
        case "agentLoaded":
            webView.evaluateJavaScript("setAppInfo(\"\(apiKey)\",\"\(uid)\");")
            break
        case "agentResponded":
            
            if let str = chatEvent.extensions?.appAction {
                print(str)
                
                if str == "add" {
                    Firestore.firestore().collection("schedules").document("cntSet").getDocument { (success, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            let data = success!.data()
                            self.cnt = data?["cnt"] as? Int ?? 0
                            print(self.cnt)
                        }
                    }
                    
                    let dateFormatter = DateFormatter()
                    
                    // フォーマット設定
                    dateFormatter.dateFormat = "yyyy/MM/dd HH-mm-ss"
                    // ロケール設定（端末の暦設定に引きづられないようにする）
                    dateFormatter.locale = Locale(identifier: "ja_JP")
                    // タイムゾーン設定（端末設定によらず、どこの地域の時間帯なのかを指定する）
                    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                    
                    print(chatEvent.extensions?.f_where! ?? "")
                    print(dateFormatter.date(from: (chatEvent.extensions?.s_time)!)!)
                    print(dateFormatter.date(from: (chatEvent.extensions?.e_time)!)!)
                    
                    Firestore.firestore().collection("schedules").document(String(cnt)).setData([
                        "name"+String(num): chatEvent.extensions?.f_where! ?? "title",
                        "startDate"+String(num): dateFormatter.date(from: (chatEvent.extensions?.s_time)!)!,
                        "endDate"+String(num): dateFormatter.date(from: (chatEvent.extensions?.e_time)!)!,
                        "num": num
                    ], merge: true)
                    num += 1
                }
                else if str == "end" {
                    cnt += 1
                    Firestore.firestore().collection("schedules").document("cntSet").setData(["cnt": cnt])
                }
            }
            
            if let str = chatEvent.extensions?.f_where {
                print(str)
            }
            
            if let str = chatEvent.extensions?.s_time {
                
                //print(str) Stringで時間
                
                //                let timeZone = TimeZone(abbreviation: "UTC")
                //                let dateFormatter = DateFormatter()
                //                var dateFormat = "yyyy/MM/dd HH-mm-ss"
                //                dateFormatter.dateFormat = dateFormat
                
                //                let dateFormatter = DateFormatter()
                //                var dateFormat = "yyyy/MM/dd HH-mm-ss"
                //                dateFormatter.dateFormat = dateFormat
                //                // 日本標準時（地域名で指定）
                //                dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                
                let dateFormatter = DateFormatter()
                
                // フォーマット設定
                dateFormatter.dateFormat = "yyyy/MM/dd HH-mm-ss"
                // ロケール設定（端末の暦設定に引きづられないようにする）
                dateFormatter.locale = Locale(identifier: "ja_JP")
                // タイムゾーン設定（端末設定によらず、どこの地域の時間帯なのかを指定する）
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                // 変換
                if let date = dateFormatter.date(from: str)  {
                    print("Date(): ", date)
                } else {
                    print("ERROR to convert")
                }
                
                //print(str)
            }
            
            if let str = chatEvent.extensions?.e_time {
                
                //print(str) //stringで日時
                let dateFormatter = DateFormatter()
                
                
                // フォーマット設定
                dateFormatter.dateFormat = "yyyy/MM/dd HH-mm-ss"
                // ロケール設定（端末の暦設定に引きづられないようにする）
                dateFormatter.locale = Locale(identifier: "ja_JP")
                // タイムゾーン設定（端末設定によらず、どこの地域の時間帯なのかを指定する）
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                // 変換
                
                
                if let date = dateFormatter.date(from: str) {
                    print("Dateend(): ", date)
                } else {
                    print("ERROR to convert")
                }
            }
            
            
            //            print(chatEvent.extensions?.appAction)
            //            print(chatEvent.extensions?.f_where)
            //            print(chatEvent.extensions?.s_time)
            //            print(chatEvent.extensions?.e_time)
            //            print(chatEvent.extensions?.nextwhere)
            
            
            break
        default:
            break
        }
    }
}
