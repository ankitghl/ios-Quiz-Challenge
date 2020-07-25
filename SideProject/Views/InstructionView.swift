//
//  InstructionView.swift
//  SideProject
//
//  Created by Ankit.Gohel on 19/07/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

import SwiftUI
import WebKit

struct InstructionView: View {    
    var body: some View {
        Text("Instruction View")
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
//struct InstructionView: View {
//    var body: some View {
//        NavigationView {
//            
//        }
////        VStack {
////            Text("Instructions")
////            Spacer()
////            getGameInstructions { (instructions) in
////
////            }
////            HTMLStringView(htmlContent: "<h1>This is HTML String</h1>")
////            Spacer()
////        }
//    }
//}
//
//struct Test_Previews: PreviewProvider {
//    static var previews: some View {
//        InstructionView()
//    }
//}
//
//struct HTMLStringView: UIViewRepresentable {
//    let htmlContent: String
//    
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//    
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.loadHTMLString(htmlContent, baseURL: nil)
//    }
//}
