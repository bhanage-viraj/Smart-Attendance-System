////
////  NetworkManager.swift
////  ip adress
////
////  Created by Viraj Bhanage on 22/02/25.
////
//
//import Foundation
//
//class NetworkManager {
//    static func getIPAddress() -> String? {
//        var address: String?
//        var ifaddr: UnsafeMutablePointer<ifaddrs>?
//
//        if getifaddrs(&ifaddr) == 0 {
//            var ptr = ifaddr
//            while ptr != nil {
//                defer { ptr = ptr?.pointee.ifa_next }
//
//                let interface = ptr!.pointee
//                let addrFamily = interface.ifa_addr.pointee.sa_family
//
//                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
//                    let name = String(cString: interface.ifa_name)
//                    if name == "en0" {  // Wi-Fi interface
//                        var addr = interface.ifa_addr.pointee
//                        var buffer = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                        if getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len),
//                                       &buffer, socklen_t(buffer.count),
//                                       nil, socklen_t(0), NI_NUMERICHOST) == 0 {
//                            address = String(cString: buffer)
//                        }
//                    }
//                }
//            }
//            freeifaddrs(ifaddr)
//        }
//        return address
//    }
//}
