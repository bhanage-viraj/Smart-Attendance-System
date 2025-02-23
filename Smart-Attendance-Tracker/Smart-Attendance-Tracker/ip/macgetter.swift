////
////  ContentView.swift
////  mac add
////
////  Created by Viraj Bhanage on 23/02/25.
////
//
//import SwiftUI
//import Network
//import Foundation
//
//struct macgetter: View {
//    @State private var macAddress: String = "Fetching..."
//    
//    var body: some View {
//        VStack {
//            Text("MAC Address")
//                .font(.title)
//            Text(macAddress)
//                .font(.body)
//                .padding()
//        }
//        .onAppear {
//            fetchMACAddress()
//        }
//    }
//    
//    func fetchMACAddress() {
//        if let ipv6Address = getIPv6LinkLocalAddress(),
//           let mac = getMACAddressFromIPv6(ip: ipv6Address) {
//            macAddress = mac
//        } else {
//            macAddress = "MAC Address could not be retrieved."
//        }
//    }
//}
//
//// Your existing functions
//func getMACAddressFromIPv6(ip: String) -> String? {
//    guard let ipStruct = IPv6Address(ip)?.rawValue else {
//        return nil
//    }
//
//    let extractedMAC: [UInt8] = [
//        ipStruct[8] ^ 0b00000010,
//        ipStruct[9],
//        ipStruct[10],
//        ipStruct[13],
//        ipStruct[14],
//        ipStruct[15]
//    ]
//    
//    return extractedMAC.map { String(format: "%02x", $0) }.joined(separator: ":")
//}
//
//func getIPv6LinkLocalAddress() -> String? {
//    var address: String?
//    var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
//
//    if getifaddrs(&ifaddr) == 0 {
//        var ptr = ifaddr
//        while ptr != nil {
//            defer { ptr = ptr?.pointee.ifa_next }
//
//            guard let interface = ptr?.pointee else { continue }
//            let name = String(cString: interface.ifa_name)
//
//            if name.starts(with: "ipsec") {
//                let addrFamily = interface.ifa_addr.pointee.sa_family
//                if addrFamily == UInt8(AF_INET6) {
//                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                    if getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
//                                   &hostname, socklen_t(hostname.count),
//                                   nil, 0, NI_NUMERICHOST) == 0 {
//                        address = String(cString: hostname)
//                        break
//                    }
//                }
//            }
//        }
//        freeifaddrs(ifaddr)
//    }
//    
//    return address
//}
//
//@main
//struct MACAddressExtractorApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
