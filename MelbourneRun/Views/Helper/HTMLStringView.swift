//
//  HTMLStringView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 12/4/21.
//

import WebKit

import SwiftUI



extension String {
    func htmlAttributedString(size: CGFloat) -> NSAttributedString? {
        let htmlTemplate = """
        <!doctype html>
        <html>
          <head>
            <style>
              body {
                font-family: -apple-system;
                font-size: \(size)px;
              }
            </style>
          </head>
          <body>
            \(self)
          </body>
        </html>
        """

        guard let data = htmlTemplate.data(using: .utf8) else {
            return nil
        }

        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
            ) else {
            return nil
        }

        return attributedString
    }
}
struct HTMLStringView: UIViewRepresentable {
   
    

       let html: String
        
       func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
            let label = UILabel()
      
            DispatchQueue.main.async {
                
//                let data = Data(self.html.utf8)
//                if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//                    label.font =  UIFont.systemFont(ofSize: 20.0)
//                   // label.adjustsFontForContentSizeCategory = true
////                    label.numberOfLines = 1
//                    label.attributedText =
//
//                }
                label.numberOfLines = 1
                label.attributedText = html.htmlAttributedString(size: 12)
                label.adjustsFontSizeToFitWidth = true
            }
            
            return label
        }
        
        func updateUIView(_ uiView: UILabel, context: Context) {}

    
}
