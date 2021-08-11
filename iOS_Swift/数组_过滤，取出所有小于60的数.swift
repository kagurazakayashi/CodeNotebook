/*
Filter list of numbers
In this case we are asked to partition a sequence using a provided filtering function. Many languages have in addition to the usual map, flatMap, reduce, filter, etc… also a partitionBy function that does exactly that, Swift as you know doesn’t have something similar (the NSArray function that filters by NSPredicate is not what we want here).
Therefore, we could solve this extending Sequence with a partitionBy function that we’ll use to partition an integer array:
数组过滤
假设我们需要使用一个给定的过滤函数将一个序列（sequence）分割为两部分。很多语言除了有常规的 map，flatMap，reduce，filter 等函数外，还有一个 partitionBy 函数恰好可以完成这个需求。正如你所知，Swift 没有类似的函数（我们不想在这里使用 NSArray 中的函数，并通过 NSPredicate 实现过滤功能）。
所以，我们可以通过拓展 SequenceType，并为它添加 partitionBy 函数来解决这个问题。我们使用这个函数将整数数组分割为两部分：
*/

extension SequenceType{
    typealias Element = Self.Generator.Element
    
    func partitionBy(fu: (Element)->Bool)->([Element],[Element]){
        var first=[Element]()
        var second=[Element]()
        for el in self {
            if fu(el) {
                first.append(el)
            }else{
                second.append(el)
            }
        }
        return (first,second)
    }
}

let part = [82, 58, 76, 49, 88, 90].partitionBy{$0 < 60}
part // ([58, 49], [82, 76, 88, 90])


// It’s not really a one liner and the approach is imperative. But could we use filter to improve it a little?
// 实际上，这不是单行代码，而且使用了命令式的解法。能不能使用 filter 对它略作改进呢？

extension Sequence{ 
   func anotherPartitionBy(fu: (Self.Iterator.Element)->Bool)->
          ([Self.Iterator.Element],[Self.Iterator.Element]){ 
      return (self.filter(fu),self.filter({!fu($0)})) 
   } 
} 

let part2 = [82, 58, 76, 49, 88, 90].anotherPartitionBy{$0 < 60}
part2 // ([58, 49], [82, 76, 88, 90])


/*
This is slightly better, but it traverses the sequence two times and trying to turn this into a one liner removing the enclosing function will get us something with too much duplicated stuff (the filtering function and the array that will be used in two places).
Can we build something that will transform the original sequence into a partition tuple using a single stream of data? Yes we can, using reduce.
这种解法略好一些，但是他遍历了序列两次。而且为了用单行代码实现，我们删除了闭合函数，这会导致很多重复的内容（过滤函数和数组会在两处被用到）。
能不能只用单个数据流就对原来的序列进行转换，把两个部分分别存入一个元组中呢？答案是是可以的，使用 reduce 方法：
*/

var part3 = [82, 58, 76, 49, 88, 90].reduce( ([],[]), { 
   (a:([Int],[Int]),n:Int) -> ([Int],[Int]) in 
   (n<60) ? (a.0+[n],a.1) : (a.0,a.1+[n])  
}) 

part3 // ([58, 49], [82, 76, 88, 90])

/*
What we are doing here is building the result tuple that contains the two partitions, an element at a time, testing each element of the original sequence using the filtering function and appending this element to the first or second partition array depending on the filtering result.

Finally a true one liner but notice that the fact that the partition arrays are being built via append will actually make it way slower than the two previous implementations.

这里我们创建了一个用于保存结果的元组，它包含两个部分。然后依次取出原来序列中的元素，根据过滤结果将它放到第一个或第二个部分中。

我们终于用真正的单行代码解决了这个问题。不过有一点需要注意，我们使用 append 方法来构造两个部分的数组，所以这实际上比前两种实现慢一些。

https://swift.gg/2016/04/18/10-Swift-One-Liners-To-Impress-Your-Friends/
*/