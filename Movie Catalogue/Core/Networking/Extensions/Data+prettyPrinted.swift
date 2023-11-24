import Foundation

extension Data {
    var prettyPrinted: String? {
        do {
            let object = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(
                withJSONObject: object,
                options: [.prettyPrinted]
            )
            let prettyPrintedString = NSString(
                data: data,
                encoding: String.Encoding.utf8.rawValue
            )
            return prettyPrintedString as String?
        } catch {
            return String(decoding: self, as: UTF8.self)
        }
    }
}
