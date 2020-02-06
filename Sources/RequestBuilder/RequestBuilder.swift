import Foundation

public var context = Context()

public struct Context {
    public var dateFormatter = ISO8601DateFormatter()
    public var stringEncoding = String.Encoding.utf8
    public var dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.iso8601
}
