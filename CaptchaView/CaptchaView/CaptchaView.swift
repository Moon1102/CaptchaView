//
//  CaptchaView.swift
//  CaptchaView
//
//  Created by Cheer on 16/9/27.
//  Copyright © 2016年 joekoe. All rights reserved.
//

import UIKit

class CaptchaView: UIView {

    private var dataArray:[String]!//字符素材数组
    private var authCodeStr:String!//验证码字符串
    
    private let kRandomColor = UIColor(red: CGFloat(arc4random()) % 256 / 256.0, green: CGFloat(arc4random()) % 256 / 256.0, blue: CGFloat(arc4random()) % 256 / 256.0, alpha: 1)
    private let kLineCount = 5
    private let kLineWidth:CGFloat = 1.0
    private let kCharCount = 5
    private let kFontSize = UIFont.systemFontOfSize(CGFloat(arc4random()) % 5 + 15)
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backgroundColor = kRandomColor
        
        getAuthCode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getAuthCode()
    {
        dataArray = [
                "0","1","2","3","4","5","6","7","8","9",
            "Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M",
            "q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","m"
        ]
        authCodeStr = String(stringInterpolationSegment: kCharCount)
        
        for _ in 0..<kCharCount
        {
            let index = Int(arc4random()) % (dataArray.count - 1)
            authCodeStr = authCodeStr.stringByAppendingString(dataArray[index])
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        refresh()
    }
    func refresh()
    {
        getAuthCode()
        
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        
        backgroundColor = kRandomColor
        
        let text = NSString(string: authCodeStr)
        let cSize = NSString(string: "A").sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(22)])
        let width = rect.size.width / CGFloat(text.length) - cSize.width
        let height = rect.size.height - cSize.height;
        
        var point:CGPoint!
        var pX:CGFloat ,pY:CGFloat = 0
        
        for i in 0..<text.length
        {
            pX = CGFloat(arc4random()) % width + rect.size.width / CGFloat(text.length) * CGFloat(i)
            pY = CGFloat(arc4random()) % height
            point = CGPointMake(pX, pY)
            
            let c = text.characterAtIndex(i)
            let textC = NSString(format: "%C",c)
            textC.drawAtPoint(point, withAttributes: [NSFontAttributeName:kFontSize])
        }
        
        //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
        if let context = UIGraphicsGetCurrentContext()
        {
            //设置线条宽度
            CGContextSetLineWidth(context, kLineWidth)
            
            //绘制干扰线
            for _ in 0..<kLineCount
            {
                CGContextSetStrokeColorWithColor(context, kRandomColor.CGColor)
                //设置线的起点
                pX = CGFloat(arc4random()) % rect.size.width
                pY = CGFloat(arc4random()) % rect.size.height
                CGContextMoveToPoint(context, pX, pY)
                //设置线终点
                pX = CGFloat(arc4random()) % rect.size.width
                pY = CGFloat(arc4random()) % rect.size.height
                CGContextAddLineToPoint(context, pX, pY)
                //画线
                CGContextStrokePath(context);
            }
        }
    }
    
    deinit
    {
        print("\(classForCoder)--hello there")
    }


}
