//
//  HGPlazaDetailTextView.swift
//  艾特处理
//
//  Created by karl on 2017/10/12.
//  Copyright © 2017年 Karl. All rights reserved.
//

import UIKit

class HGPlazaDetailTextView: UITextView, UITextViewDelegate {

  var selectedViews = [UIView]()
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    backgroundColor = UIColor.green
    isScrollEnabled = false
    isEditable = false
    textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
    delegate = self
    
  }
  
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    return false
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    UIMenuController.shared.isMenuVisible = false
    return false
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    guard let atUsers = attributedText.attribute("atUsers", at: 0, effectiveRange: nil) as? [HGAtUser] else {
      return
    }
    
    var isContain = false
    let point = touch.location(in: self)
    for atUser in atUsers {
      selectedRange = atUser.range
      if let textRange = selectedTextRange {
        guard let array = (selectionRects(for: textRange) as? [UITextSelectionRect])?.lazy.filter({ $0.rect.width > 0 && $0.rect.height > 0 }), array.count > 0 else {
          return
        }
        
        isContain = array.lazy.filter({ $0.rect.contains(point) }).count > 0
        
        if isContain {
          for rectObject in array {
            let selectedView = UIView(frame: rectObject.rect)
            selectedView.backgroundColor = UIColor.blue
            selectedView.layer.cornerRadius = 5
            insertSubview(selectedView, at: 0)
            selectedViews.append(selectedView)
          }
          print(atUser.id)
          break
        }
      }
    }
    resignFirstResponder()
    selectedRange = NSRange(location: 0, length: 0)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    selectedViews.forEach({ $0.removeFromSuperview() })
    
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    selectedViews.forEach({ $0.removeFromSuperview() })
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
