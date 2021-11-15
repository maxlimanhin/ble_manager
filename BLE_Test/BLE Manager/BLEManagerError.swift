//
//  BLEManagerError.swift
//  BLE_Test
//
//  Created by DIUUMA on 14/11/2021.
//

import Foundation


enum BLEManagerError: Error {
    case unknownError
    case setUpfail_moreThanThreeModule
    case setUpfail_noModule
    case failToConnectPeripheral
    case disconnectToPeripheral
    case discoverServicesFail
    case discoverCharacteristicsFail
}
