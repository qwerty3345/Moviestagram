//
//  RatingSlider.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/05.
//

import UIKit

final class RatingSlider: UISlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        // 드래그 뿐만 아니라 터치로도 값을 변경할 수 있게 설정
        let width = self.frame.size.width
        let tapPoint = touch.location(in: self)
        let fPercent = tapPoint.x / width
        let nNewValue = self.maximumValue * Float(fPercent)
        if nNewValue != self.value {
            self.value = nNewValue
        }
        return true
    }
}
