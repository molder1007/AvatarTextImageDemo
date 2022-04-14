//
//  UIImageExtension.swift
//  AvatarTextImageDemo
//
//  Created by Molder on 2022/4/14.
//

import UIKit

extension UIImage {
    
    func createAvatarTextImage(text: String, imageSize: CGSize, imageBackgroundColor: UIColor, textFont: UIFont, textFontColor: UIColor) -> UIImage {
        
        // 建立圖案大小
        let rect: CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: imageSize)
        // 開啟點陣圖上下文
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        // 文字格式設定
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textFontColor
            ] as [NSAttributedString.Key: Any]
        // 文字位置
        let string = text as NSString
        let stringSize = string.size(withAttributes: textFontAttributes)
        let textStartX = (imageSize.width - stringSize.width) / 2
        let textStartY = (imageSize.height - stringSize.height) / 2
        let textRect = CGRect(x: textStartX,
                              y: textStartY,
                              width: stringSize.width,
                              height: stringSize.height)
        // 圖片背景色填滿
        imageBackgroundColor.setFill()
        UIRectFill(rect)
        // 文字繪製
        text.draw(in: textRect, withAttributes: textFontAttributes)
        // 從上下文中獲取裁剪完的圖片
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        // 關閉上下文
        UIGraphicsEndImageContext()
        return image
    }
}
