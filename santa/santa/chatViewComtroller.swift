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

class ChatViewController: UIViewController, WKScriptMessageHandler, ObservableObject {
    private var webView: WKWebView!
    
    private let apiKey = "APIkey"
    private let uid = UUID().uuidString
    
    var cnt = 0
    var num = 0
    @Published var flagForHave: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        let userContentController: WKUserContentController = WKUserContentController()
        userContentController.add(self, name: "meboCallBack")
        config.userContentController = userContentController
        webView = WKWebView(frame: .zero, configuration: config)
        webView.load(URLRequest(url: URL(string: "URL&platform=webview")!))
        view = webView
        Firestore.firestore().collection("schedules").document("cntSet").getDocument { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let data = success!.data()
                self.cnt = data?["cnt"] as? Int ?? 0
                print(self.cnt)
            }
        }
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
                    
                    let dateFormatter = DateFormatter()
                    
                    // フォーマット設定
                    dateFormatter.dateFormat = "yyyy/MM/dd HH-mm-ss"
                    // ロケール設定（端末の暦設定に引きづられないようにする）
                    dateFormatter.locale = Locale(identifier: "ja_JP")
                    // タイムゾーン設定（端末設定によらず、どこの地域の時間帯なのかを指定する）
                    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                    
//                    print(chatEvent.extensions?.f_where! ?? "")
//                    print(dateFormatter.date(from: (chatEvent.extensions?.s_time)!)!)
//                    print(dateFormatter.date(from: (chatEvent.extensions?.e_time)!)!)
                    
                    print("cnt: " + String(cnt))
                    Firestore.firestore().collection("schedules").document(String(cnt)).setData([
                        "name"+String(num): chatEvent.extensions?.f_where! ?? "title",
                        "startDate"+String(num): dateFormatter.date(from: (chatEvent.extensions?.s_time)!)!,
                        "endDate"+String(num): dateFormatter.date(from: (chatEvent.extensions?.e_time)!)!,
                        "num": num
                    ], merge: true)
                    num += 1
                }
                else if str == "end" {
                    self.cnt += 1
                    Firestore.firestore().collection("schedules").document("cntSet").setData(["cnt": cnt])
                    flagForHave = true
                }
            }
            
            break
        default:
            break
        }
    }
}
