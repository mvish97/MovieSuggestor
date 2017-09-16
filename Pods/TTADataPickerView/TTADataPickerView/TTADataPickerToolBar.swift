//
//  TTADataPickerToolBar.swift
//  TTAUtils_Swift
//
//  Created by TobyoTenma on 03/03/2017.
//  Copyright © 2017 TobyoTenma. All rights reserved.
//

import UIKit

class TTADataPickerToolBar: UIToolbar {
    let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: nil
        , action: nil)
    let confirmButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: nil)
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil
        , action: nil)
    let titleButton = TTADataPickerTitleBarButtonItem(title: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        struct InternalClass {
            static var IQUIToolbarTextButtonClass: UIControl.Type? = NSClassFromString("UIToolbarTextButton") as? UIControl.Type
            static var IQUIToolbarButtonClass: UIControl.Type? = NSClassFromString("UIToolbarButton") as? UIControl.Type
        }
        
        var leftRect = CGRect.zero
        var rightRect = CGRect.zero
        var isTitleBarButtonFound = false
        
        let sortedSubviews = self.subviews.sorted(by: { (view1 : UIView, view2 : UIView) -> Bool in
            
            let x1 = view1.frame.minX
            let y1 = view1.frame.minY
            let x2 = view2.frame.minX
            let y2 = view2.frame.minY
            
            if x1 != x2 {
                return x1 < x2
            } else {
                return y1 < y2
            }
        })
        
        for barButtonItemView in sortedSubviews {
            if (isTitleBarButtonFound == true) {
                rightRect = barButtonItemView.frame
                rightRect.origin.x = UIScreen.main.bounds.width - rightRect.maxX <= 0 ? rightRect.origin.x - 16 : rightRect.origin.x
                barButtonItemView.frame = rightRect
                break
            } else if (type(of: barButtonItemView) === UIView.self) {
                isTitleBarButtonFound = true
            } else if ((InternalClass.IQUIToolbarTextButtonClass != nil && barButtonItemView.isKind(of: InternalClass.IQUIToolbarTextButtonClass!) == true) || (InternalClass.IQUIToolbarButtonClass != nil && barButtonItemView.isKind(of: InternalClass.IQUIToolbarButtonClass!) == true)) {
                leftRect = barButtonItemView.frame
                leftRect.origin.x = leftRect.origin.x <= 0 ? 8 : leftRect.origin.x
                barButtonItemView.frame = leftRect
            }
        }
        
        var x : CGFloat = 8
        
        if (leftRect != .zero) {
            x = leftRect.maxX + 8
        }
        
        let width : CGFloat = self.frame.width - 32 - (leftRect == .zero ? 0 : leftRect.maxX) - (rightRect == .zero ? 0 : self.frame.width - rightRect.minX)
        
        guard let unwrappedItems = items else { return }
        for item in unwrappedItems {
            guard let newItem = item as? TTADataPickerTitleBarButtonItem else { continue }
            let titleRect = CGRect(x: x, y: 0, width: width, height: self.frame.size.height)
            newItem.customView?.frame = titleRect
            break
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = 44
        return size
    }
}

fileprivate extension TTADataPickerToolBar {
    
    func setupUI() {
        sizeToFit()
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        isTranslucent = true
        tintColor = UIColor.black // default tint color is black
        barTintColor = nil
        items = [cancelButton, flexibleSpace, titleButton, flexibleSpace, confirmButton]
    }
}
