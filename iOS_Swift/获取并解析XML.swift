/*
Fetch and Parse an XML web service
Some of languages above don’t rely on external libraries and have more than one option available by default to deal with XML (e.g. Scala that “natively” albeit awkwardly supports XML parsing into objects), but Foundation provides only the SAX parser NSXMLParser, and as you may have already guessed we are not going to use it.
There are a few alternative open source libraries we could use in this case, some of them written in C or Objective-C and others in pure Swift.
This time we are going to use the pure-Swift AEXML:

上述的某些语言不需要依赖外部的库，而且默认有不止一种方案可以处理 XML 格式的数据（比如 Scala 自身就可以将 XML 解析成对象，尽管实现方法比较笨拙），但是 （Swift 的）Foundation 库仅提供了 SAX 解析器，叫做 NSXMLParser。你也许已经猜到了：我们不打算使用这个。
在这种情况下，我们可以选择一些开源的库。这些库有的用 C 实现，有的用 Objective-C 实现，还有的是纯 Swift 实现。
这次，我们打算使用纯 Swift 实现的库：AEXML：
*/

let xmlDoc = try? AEXMLDocument(xmlData: NSData(contentsOf: URL(string:"https://www.ibiblio.org/xml/examples/shakespeare/hen_v.xml")!)!) 

if let xmlDoc=xmlDoc {
    var prologue = xmlDoc.root.children[6]["PROLOGUE"]["SPEECH"]
    prologue.children[1].stringValue // Now all the youth of England are on fire,
    prologue.children[2].stringValue // And silken dalliance in the wardrobe lies:
    prologue.children[3].stringValue // Now thrive the armourers, and honour's thought
    prologue.children[4].stringValue // Reigns solely in the breast of every man:
    prologue.children[5].stringValue // They sell the pasture now to buy the horse,
}