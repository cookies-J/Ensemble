//
//  EnsembleViewModel.swift
//  Ensemble
//
//  Created by Jele on 12/8/2022.
//

import UIKit

@objc protocol EnsembleProtocol {
    @objc func join(instrument: MusicalInstrument,
                    type: EnsembleType)
}

/// 乐器类型
@objc enum MusicalInstrument: Int {
    case guitar
    case bass
    case ukulele
//  ....
}

/// 伴奏
@objc enum EnsembleType: Int {
    case one
    case two
}

class EnsembleViewModel: NSObject {
    var instrument: MusicalInstrument = .guitar
    var ensembleType: EnsembleType?
    
   @objc public var delegate: EnsembleProtocol?
    // 准备进入伴奏一
    @objc func prepareOne() {
        print("""
        join in /
              \(MusicalInstrument.guitar) /
              \(EnsembleType.one) /
        """);
        self.delegate?.join(instrument: .guitar, type: .one)
    }
    // 准备进入伴奏二
    @objc func prepareTwo() {
        print("""
        join in /
              \(MusicalInstrument.guitar) /
              \(EnsembleType.two) /
        """);
        self.delegate?.join(instrument: .guitar, type: .two)
    }
}
