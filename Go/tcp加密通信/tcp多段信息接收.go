/*
在使用 Go 语言的 conn.Write 方法发送信息和对方使用 reader.Read 方法接收信息时，可能会出现信息被分成多段接收的情况。这种现象主要是由于 TCP 协议的传输特性所致。TCP 是一个基于流的协议，它不保证数据的边界，也就是说，TCP 把数据看作一个连续的字节流，而不是独立的消息块。因此，即使发送方一次性发送了一个完整的数据块，接收方可能会分几次接收到这些数据，每次接收的大小取决于多种因素，如网络状况、缓冲区大小等。

要解决这个问题，你可以采用以下几种方法：

消息边界标记：可以在发送的每个消息末尾添加特定的分隔符或者前缀每个消息以其长度。这样接收方就可以识别出每个独立的消息，即使它们是在一个单独的 Read 调用中被接收的。

使用分隔符：例如，如果你知道消息中永远不会出现特定的字符，你可以使用这个字符作为消息的结束标记。
长度前缀：在每个消息前添加一个固定长度的头部，指明主体消息的长度，这样接收方可以先读取长度，然后根据这个长度来读取正确数量的数据。
固定长度消息：如果所有消息都是固定长度的，那么接收方可以每次都读取固定的字节数。

使用高级库：使用一些高级的网络库，例如 gRPC 或 WebSocket，这些库通常内置了消息边界的处理机制。

循环读取：在接收端，循环使用 Read 方法直到你收集到一个完整的消息。通常需要根据上述的消息边界标记或消息长度来确定何时一个消息被完整地接收。

这里有一个简单的示例，展示了如何在发送和接收消息时使用长度前缀：
*/

// 发送端
func sendMessage(conn net.Conn, message []byte) error {
    // 将消息长度作为前缀
    length := uint32(len(message))
    lengthBytes := make([]byte, 4)
    binary.BigEndian.PutUint32(lengthBytes, length)
    _, err := conn.Write(lengthBytes)
    if err != nil {
        return err
    }
    _, err = conn.Write(message)
    return err
}

// 接收端
func receiveMessage(conn net.Conn) ([]byte, error) {
    lengthBytes := make([]byte, 4)
    _, err := io.ReadFull(conn, lengthBytes)
    if err != nil {
        return nil, err
    }
    length := binary.BigEndian.Uint32(lengthBytes)
    message := make([]byte, length)
    _, err = io.ReadFull(conn, message)
    if err != nil {
        return nil, err
    }
    return message, nil
}

// 在这个示例中，发送方首先发送消息的长度，然后才是消息本身。接收方首先读取长度信息，然后根据这个长度读取相应数量的数据。这种方式可以确保每个消息都能被完整接收，不会因为 TCP 的流特性而被截断或合并。
