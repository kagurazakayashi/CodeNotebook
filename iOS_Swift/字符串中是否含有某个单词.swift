/*
Verify if Exists in a String
Let’s verify if a tweet contains at least one of a few selected keywords using filter:
证明字符串中含有某个单词
我们使用 filter 方法判断一条推文中是否至少含有一个被选中的关键字：
*/
let words = ["Swift","iOS","cocoa","OSX","tvOS"]
let tweet = "This is an example tweet larking about Swift"
let valid = !words.filter({tweet.containsString($0)}).isEmpty
valid //true

// @oisdk 建议这样写会更好：
words.contains(tweet.containsString)

// 另外，也可以这样写：
tweet.characters
  .split(" ")
  .lazy
  .map(String.init)
  .contains(Set(words).contains)

// https://swift.gg/2016/04/18/10-Swift-One-Liners-To-Impress-Your-Friends/