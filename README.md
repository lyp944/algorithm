# algorithm 算法

### 1. K-Means （K均值算法是聚类算法的一种)

*K-means.playground* 是 *K-Means* 算法基于Swift的一种简单实现，里边包含实现和测试。


```swift
 centers: 初始的中心点
 points: 需要分类的样本 CGPoint
 calculateTimes : 中心点计算次数,超过停止计算
 minVarepsilon ：最小可容忍误差
 

func KMeans(centers:Array<CGPoint> ,
			points:Array<CGPoint>,
			maxCalculateTimes:Int,
			minVarepsilon:Double = 0)
	-> (Array<Array<CGPoint>> , Array<CGPoint>)
```
