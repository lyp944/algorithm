# algorithm 算法

### 1. K-Means （K均值算法是聚类算法的一种)

*K-means.playground* 是 *K-Means* 算法基于Swift的一种简单实现，里边包含实现和测试。


```swift
 centers 初始的中心点
 points 需要分类的样本 CGPoint
 calculateTimes 中心点计算次数,超过停止计算
 minVarepsilon 最小可容忍误差
 

func KMeans(centers:Array<CGPoint> ,
			points:Array<CGPoint>,
			maxCalculateTimes:Int,
			minVarepsilon:Double = 0)
	-> (Array<Array<CGPoint>> , Array<CGPoint>)
```

### 1. Bellman-Ford （贝尔曼福特 算法是一种查找图的最短路径算法)

*Bellman-Ford.playground* 是 *Bellman-Ford* 算法基于Swift的一种简单实现，里边包含实现和测试。

```swift
//定点定义
let 无 = Int.max //代表无穷
let A = "A",B="B",C="C",D="D",E="E",F="F",G="G"

let AB = 9,AC = 2,BC = 6,BD = 3,BE = 1,CD = 2,CF = 9,DE = 5,DF = 6,EF = 3,EG = 7,FG = 4

let vertexs:Array = [A,B,C,D,E,F,G]
                    //A  B  C  D  E  F  G
let edges:Array<Array<Int>> =  [[00,AB,AC,无,无,无,无], //A
                                [AB,00,BC,BD,BE,无,无],//B
                                [AC,BC,00,CD,无,CF,无],//C
                                [无,BD,CD,00,DE,DF,无],//D
                                [无,BE,无,DE,00,EF,EG],//E
                                [无,无,CF,DF,EF,00,FG],//F
                                [无,无,无,无,EG,FG,00]] //G
/*
 vertexs:Array<String> 点的数组
 edges:Array<Array<Int>> 点组成的网的矩阵 二维数组
 from:String 起始点
 
 return 返回值是一个元组
 (vertexValues:Dictionary<String,Int> , routes:Dictionary<String,Array<String>>)
 vertexValues: 起始点到达所有点消耗组成的数组
 routes: 起始点到达所有点最优路径的字典
 */
func BellmanFord(vertexs:Array<String>,edges:Array<Array<Int>>,from:String)
    -> (vertexValues:Dictionary<String,Int> , routes:Dictionary<String,Array<String>>)

```
