//贝尔曼福特 算法是一种查找图的最短路径算法
/*
 定义参考：https://blog.csdn.net/weixin_34405925/article/details/87093169
 Ⅰ. 定义
  1. 图：有像图 无向图
  2. 网：在图的边上加入权重
 
 Ⅱ. 存储结构
 1. 邻接矩阵:存储比较浪费空间
 2. 邻接表:存储「有向图」获取出度容易，获取入度却比较困难,需要「逆邻接表」配合使用
 3. 十字链表:解决「邻接表」存储「有向图」需要两张表得问题
 4. 邻接多重表:解决「邻接表」存储无「向图时」删除变动大得问题
 5. 边集数组：仅关注边的操作，还可以使用边集数组
 
 下边采用「邻接矩阵」
 */


import UIKit

//定点定义
let 无 = Int.max //代表无穷
let A = "A",B="B",C="C",D="D",E="E",F="F",G="G"

let AB = 9,AC = 2,BC = 6,BD = 3,BE = 1,CD = 2,CF = 9,DE = 5,DF = 6,EF = 3,EG = 7,FG = 4

let vertexs:Array = [A,B,C,D,E,F,G]
                              //A  B  C  D  E  F  G
let edges:Array<Array<Int>> = [[00,AB,AC,无,无,无,无], //A
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
    -> (vertexValues:Dictionary<String,Int> , routes:Dictionary<String,Array<String>>) {
    
    //检验edges是否为 vertexs.count *  vertexs.count 的方矩阵！
    var isLegal = (vertexs.count == edges.count)
    
    for e in edges {
        if e.count != vertexs.count {
            isLegal = false
            break
        }
    }
    
    assert(isLegal, "edges 必须为 vertexs.count *  vertexs.count 的方阵！")
    
    
    //起始点初始化为0，其他为无穷大
    var vertexValues = Dictionary<String,Int>()
    for vertex in vertexs {
        vertexValues[vertex] = 无
    }
    vertexValues[from] = 0

    
    var routes = Dictionary<String,Array<String>>()

    var success = true
    var repeatTimes = 0
    
    repeat {
        
        success = true
        
        repeatTimes += 1
        
        //一次松弛操作：估计的最短路径值渐渐地被更加准确的值替代，直至得到最优解
        for (i,fromVertex) in vertexs.enumerated() {
            
            let edge = edges[i]
            let fromVertexValue:Int! = vertexValues[fromVertex]
            
            for (j,toVertexWeight) in edge.enumerated() {
                
                let toVertex:String = vertexs[j]
                
                //A -> A 略过
                if fromVertex == toVertex {
                    continue
                }
                
                
                let toVertexValue : Int! = vertexValues[toVertex]

                if toVertexWeight >= 无 || fromVertexValue >= 无 {
                    /*1.不能直达的点略过
                        或
                      2.起始点为无穷无法计算略过*/
                    continue
                }else if (fromVertexValue + toVertexWeight > toVertexValue) {
                    //1.路径长度增加略过
                    continue
                }else{
                    
                    
                    if let oldVertexValue = vertexValues[toVertex],
                        oldVertexValue > fromVertexValue + toVertexWeight {
                        //有值更新需要repeat一次确认是否是最优解
                        success = false
                    }
                    
                    vertexValues[toVertex] = fromVertexValue + toVertexWeight

                    //记录路径
                    let fromRouteKey:String =  from + fromVertex
                    let toRouteKey:String =  from + toVertex
                    
                    var routeLine = routes[fromRouteKey] ?? [fromVertex] //默认值第一位为起始点from
                    routeLine.append(toVertex)
                    routes[toRouteKey] = routeLine
                    
                    
                    //log 每一次路径的更新
//                    for (_,e) in routes.enumerated() {
//                        print("\(e.key) -> \(e.value)")
//                    }
                    
                }
                
                //log 每一次 from点 到 其他点 的值的更新（权重的和）
//                print(vertexValues.sorted(by: { (a, b) -> Bool in
//                    return a.key < b.key
//                }))
                
            }
//            print("\n")
        }
        
        
    }while(!success)
    
    print("repeatTimes = \(repeatTimes)")


    
    
    return (vertexValues,routes)
}

//testA
let (vertexValues,routes) = BellmanFord(vertexs: vertexs, edges: edges, from:B)

//log from点 到 其他点 的最短值（最短路径值）
print("\n")
print(vertexValues.sorted(by: { (a, b) -> Bool in
    return a.key < b.key
}))

//log from点 到 其他点 的路径方法
print("\n")
for (_,e) in routes.enumerated() {
    print("\(e.key) -> \(e.value)")
}
