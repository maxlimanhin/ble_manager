//
//  Command.swift
//  BLE_Test
//
//  Created by DIUUMA on 14/11/2021.
//

import Foundation

class BLECommand {
    enum General {
        case reset
        
        func toCommand() -> [UInt8] {
            switch self {
            case .reset:
                return [0xfe, 0x02]
            }
        }
    }
    
    enum AccelerometerModule {
        case accelerometerModuleEnable
        case accelerometerModuleDisable
        
        func toCommand() -> [UInt8] {
            switch self {
            case .accelerometerModuleEnable:
                return [0xf1, 0xd0]
            case .accelerometerModuleDisable:
                return [0xf1, 0xdd]
            }
        }
    }
    
    enum SetAccelerometerRange {
        case g2
        case g4
        case g8
        case g16
        
        func toCommand() -> [UInt8] {
            switch self {
            case .g2:
                return [0xf1, 0xd1]
            case .g4:
                return [0xf1, 0xd2]
            case .g8:
                return [0xf1, 0xd3]
            case .g16:
                return [0xf1, 0xd4]
            }
        }
    }
    
    enum SetAccelerometerOutputDataRate{
        case hz25
        case hz50
        case hz100
        
        func toCommand() -> [UInt8] {
            switch self {
            case .hz25:
                return [0xf1, 0xd5]
            case .hz50:
                return [0xf1, 0xd6]
            case .hz100:
                return [0xf1, 0xd7]
            }
        }
    }
    
    enum GyroModule {
        case gyroModuleEnable
        case gyroModuleDisable
        
        func toCommand() -> [UInt8] {
            switch self {
            case .gyroModuleEnable:
                return [0xf2, 0xd0]
            case .gyroModuleDisable:
                return [0xf2, 0xdd]
            }
        }
    }
    
    enum SetGyroRange {
        case dps125
        case dps250
        case dps500
        case dps1000
        case dps2000
        
        func toCommand() -> [UInt8] {
            switch self {
            case .dps125:
                return [0xf2, 0xd1]
            case .dps250:
                return [0xf2, 0xd2]
            case .dps500:
                return [0xf2, 0xd3]
            case .dps1000:
                return [0xf2, 0xd4]
            case .dps2000:
                return [0xf2, 0xd5]
            }
        }
    }
    
    enum SetGyroOutputDataRate {
        case hz25
        case hz50
        case hz100
        
        func toCommand() -> [UInt8] {
            switch self {
            case .hz25:
                return [0xf2, 0xd6]
            case .hz50:
                return [0xf2, 0xd7]
            case .hz100:
                return [0xf2, 0xd8]
            }
        }
    }
    
    enum MagnetometerModule {
        case magnetometerModuleEnable
        case magnetometerModuleDisable
        
        func toCommand() -> [UInt8] {
            switch self {
            case .magnetometerModuleEnable:
                return [0xf6, 0xd0]
            case .magnetometerModuleDisable:
                return [0xf6, 0xdd]
            }
        }
    }
    
    enum SetMagnetometerPreset {
        case low_power
        case regular1
        case regular2
        case enhanced_regular
        
        func toCommand() -> [UInt8] {
            switch self {
            case .low_power:
                return [0xf6, 0xd1]
            case .regular1:
                return [0xf6, 0xd2]
            case .regular2:
                return [0xf6, 0xd3]
            case .enhanced_regular:
                return [0xf6, 0xd4]
            }
        }
    }
    
    enum QuaternionModule {
        case quaternionModuleEnable
        case quaternionModuleDisable
        
        func toCommand() -> [UInt8] {
            switch self {
            case .quaternionModuleEnable:
                return [0xf7, 0xd0]
            case .quaternionModuleDisable:
                return [0xf7, 0xdd]
            }
        }
    }
    
    enum LinearAcceleration {
        case linearAccelerationModuleEnable
        case linearAccelerationModuleDisable
        
        func toCommand() -> [UInt8] {
            switch self {
            case .linearAccelerationModuleEnable:
                return [0xf8, 0xd0]
            case .linearAccelerationModuleDisable:
                return [0xf8, 0xdd]
            }
        }
    }
    
    enum SetSensorFusionMode {
        case setSensorFusionModeOn
        case setSensorFusionModeOff
        
        func toCommand() -> [UInt8] {
            switch self {
            case .setSensorFusionModeOn:
                return [0xf7, 0xd1]
            case .setSensorFusionModeOff:
                return [0xf7, 0xde]
            }
        }
    }
    
    enum SetTXPower {
        case negative16
        case negative8
        case negative4
        case zero
        case postive4
        
        func toCommand() -> [UInt8] {
            switch self {
            case .negative16:
                return [0xf9, 0xd1]
            case .negative8:
                return [0xf9, 0xd2]
            case .negative4:
                return [0xf9, 0xd3]
            case .zero:
                return [0xf9, 0xd4]
            case .postive4:
                return [0xf9, 0xd5]
            }
        }
    }
    
    enum Streaming {
        case startStreaming
        case stopStreaming
        
        func toCommand() -> [UInt8] {
            switch self {
            case .startStreaming:
                return [0xf3, 0xd0]
            case .stopStreaming:
                return [0xf3, 0xdd]
            }
        }
    }
    
    enum Logging {
        case startLogging
        case stopLogging
        
        func toCommand() -> [UInt8] {
            switch self {
            case .startLogging:
                return [0xf3, 0xd1]
            case .stopLogging:
                return [0xf4, 0xd1]
            }
        }
    }
    
    enum DownloadLoggedData {
        case downloadOn
        case downloadOff
        
        func toCommand() -> [UInt8] {
            switch self {
            case .downloadOn:
                return [0xf5, 0xd1]
            case .downloadOff:
                return [0xf5, 0xde]
            }
        }
    }
    
    enum LogEntries {
        case logEntries
        
        func toCommand() -> [UInt8] {
            switch self {
            case .logEntries:
                return [0xfe, 0xce]
            }
        }
    }
        
    enum Updatefirmware {
        case updateFirmware
        
        func toCommand() -> [UInt8] {
            switch self {
            case .updateFirmware:
                return [0xfe, 0x01]
            }
        }
    }
}
