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

### 2. Bellman-Ford （贝尔曼福特 算法是一种查找图的最短路径算法)

*Bellman-Ford.playground* 是 *Bellman-Ford* 算法基于Swift的一种简单实现，里边包含实现和测试。

```swift
    //负闭环
    enum BellmanFordError :Error {
            case NegativeClosedCycle(String) //负闭环
    }
    //点定义
    let 🚫 = Int.max //代表无穷，不可达
    let A = "A",B="B",C="C",D="D",E="E",F="F",G="G"

    let AB = 9,AC = 2,BC = 6,BD = -3,BE = 1,CD = 2,CF = 9,DE = 5,DF = 6,EF = 3,EG = 7,FG = 4

    let vertexs:Array = [A,B,C,D,E,F,G]
                                    //A  B  C  D  E  F  G
    let edges:Array<Array<Int>> =  [[00,AB,AC,🚫,🚫,🚫,🚫],//A
                                    [AB,00,BC,BD,BE,🚫,🚫],//B
                                    [AC,BC,00,CD,🚫,CF,🚫],//C
                                    [🚫,BD,CD,00,DE,DF,🚫],//D
                                    [🚫,BE,🚫,DE,00,EF,EG],//E
                                    [🚫,🚫,CF,DF,EF,00,FG],//F
                                    [🚫,🚫,🚫,🚫,EG,FG,00]] //G
    /*
     vertexs:Array<String> 点的数组
     edges:Array<Array<Int>> 点组成的网的矩阵 二维数组
     from:String 起始点
     
     return 返回值是一个元组
     (vertexValues:Dictionary<String,Int> , routes:Dictionary<String,Array<String>>)
     vertexValues: 起始点到达所有点消耗组成的数组
     routes: 起始点到达所有点最优路径的字典
     */
    func BellmanFord(vertexs:Array<String>,edges:Array<Array<Int>>,from:String) throws
            -> (vertexValues:Dictionary<String,Int> , routes:Dictionary<String,Array<String>>) 
    
    //起始点为 B 测试结果
    [(key: "A", value: 7), (key: "B", value: 0), (key: "C", value: 5), (key: "D", value: 3), (key: "E", value: 1), (key: "F", value: 4), (key: "G", value: 8)]


    BE -> ["B", "E"]
    BD -> ["B", "D"]
    BF -> ["B", "E", "F"]
    BG -> ["B", "E", "F", "G"]
    BC -> ["B", "D", "C"]
    BA -> ["B", "D", "C", "A"]

```


### 3. Dijkstras （戴克斯特拉算法 本程序实现的是戴克斯特拉算法的一种变种 查找图中起始点到个点的最短路径)

```swift
    //负权重
    enum DijkstraError :Error {
        case NegativeWeight(String) //负权重
    }
    //点定义
    let 🚫 = Int.max //代表无穷，不可达
    let A = "A",B="B",C="C",D="D",E="E",F="F",G="G"

    //定义边
    let AB = 9,AC = 2,BC = 6,BD = 3,BE = 1,CD = 2,CF = 9,DE = 5,DF = 6,EF = 3,EG = 7,FG = 4

    let vertexs:Array = [A,B,C,D,E,F,G]

    //邻接点矩阵
                                    //A  B  C  D  E  F  G
    let edges:Array<Array<Int>> =  [[00,AB,AC,🚫,🚫,🚫,🚫],//A
                                    [AB,00,BC,BD,BE,🚫,🚫],//B
                                    [AC,BC,00,CD,🚫,CF,🚫],//C
                                    [🚫,BD,CD,00,DE,DF,🚫],//D
                                    [🚫,BE,🚫,DE,00,EF,EG],//E
                                    [🚫,🚫,CF,DF,EF,00,FG],//F
                                    [🚫,🚫,🚫,🚫,EG,FG,00]]//G
    /*
    vertexs:Array<String> 点的数组
    edges:Array<Array<Int>> 点组成的网的矩阵 二维数组
    from:String 起始点
    
    return 返回值是一个元组
    (vertexValues:Dictionary<String,Int> , routes:Dictionary<String,Array<String>>)
    vertexValues: 起始点到达所有点消耗组成的数组
    routes: 起始点到达所有点最优路径的字典
    */

    func Dijkstra(vertexs:Array<String>,edges:Array<Array<Int>>,from:String) throws
        -> (vertexValues:Dictionary<String,Int> , routes:Dictionary<String,Array<String>>)
    
    //起始点为 B 测试结果
    [(key: "A", value: 7), (key: "B", value: 0), (key: "C", value: 5), (key: "D", value: 3), (key: "E", value: 1), (key: "F", value: 4), (key: "G", value: 8)]


    BE -> ["B", "E"]
    BD -> ["B", "D"]
    BF -> ["B", "E", "F"]
    BG -> ["B", "E", "F", "G"]
    BC -> ["B", "D", "C"]
    BA -> ["B", "D", "C", "A"]
```


