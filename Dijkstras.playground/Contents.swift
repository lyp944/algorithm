
//戴克斯特拉算法: 是一种最短路径搜索算法，对于不含负权的有向图，这是目前已知的最快的单源最短路径算法。（A*搜索算法 需要提供估计信息）
//本程序是 戴克斯特拉算法 算法的一种变种

import UIKit
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
    -> (vertexValues:Dictionary<String,Int> , routes:Dictionary<String,Array<String>>) {
        
        //检验edges是否为 vertexs.count *  vertexs.count 的方矩阵！
        var isLegal = (vertexs.count == edges.count)
        let vertexCount = vertexs.count
        
        for e in edges {
            if e.count != vertexCount {
                isLegal = false
                break
            }
        }
        
        assert(isLegal, "edges 必须为 vertexs.count *  vertexs.count 的方阵！")
        
        
        //初始化各个定点的值，起始点初始化为0，其他为无穷大
        var vertexValues = Dictionary<String,Int>()
        for vertex in vertexs {
            vertexValues[vertex] = 🚫
        }
        vertexValues[from] = 0
        
        
        var routes = Dictionary<String,Array<String>>()
        
        //候先点的值
        var routeValues = Dictionary<String,Int>()
        routeValues[from] = 0
        
        
        //没有候选点，表明起始点到所有点的最短路径已经求解成功
        while routeValues.count > 0 {

            //一次松弛操作：估计的最短路径值渐渐地被更加准确的值替代，直至得到最优解
            
            let min  = routeValues.min { (arg0, arg1) -> Bool in
                return arg0.value <= arg1.value
            }
            
            routeValues.removeValue(forKey: min!.key)
            

            
            let fromVertex = min!.key
            let fromVertexValue = min!.value
            
            
            let edge = edges[vertexs.firstIndex(of: fromVertex)!]
            
            for (j,toVertexWeight) in edge.enumerated() {
                

                
                
                let toVertex:String = vertexs[j]
                
                if toVertexWeight < 0 {
                    throw DijkstraError.NegativeWeight(fromVertex+toVertex)
                }
                
                //A -> A 略过
                if fromVertex == toVertex {
                    continue
                }
                
                //next点的值
                let toVertexValue : Int! = vertexValues[toVertex]
                
                if toVertexWeight >= 🚫 || fromVertexValue >= 🚫 {
                    /*1.不能直达的next点略过
                     或
                     2.current点为无穷无法计算略过*/
                    continue
                }else if (fromVertexValue + toVertexWeight > toVertexValue) {
                    //1.路径长度增加略过
                    continue
                }else{
                    
                    //⚠️next点的值⚠️
                    vertexValues[toVertex] = fromVertexValue + toVertexWeight
                    routeValues[toVertex] = fromVertexValue + toVertexWeight
                    
                    //记录路径
                    let fromRouteKey:String =  from + fromVertex
                    let toRouteKey:String =  from + toVertex
                    
                    var routeLine = routes[fromRouteKey] ?? [fromVertex] //默认值第一位为起始点from
                    
                    routeLine.append(toVertex)
                    routes[toRouteKey] = routeLine
                    
                    
                    //                    //检测负路径
                    //                    if repeatTimes >= vertexCount-1 {
                    //                        //存在负闭环
                    //                        throw DijkstraError.NegativeClosedCycle(routes.description)
                    //                    }
                    
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
        
        return (vertexValues,routes)
}


//test

var result:(vertexValues:Dictionary<String,Int> , routes:Dictionary<String,Array<String>>)?

do {
    result = try Dijkstra(vertexs: vertexs, edges: edges, from: A)
} catch DijkstraError.NegativeWeight(let desc) {
    print("DijkstraError.NegativeWeight:\n\(desc)")
}
print("\n")

if let result = result {
    
    //log from点 到 其他点 的最短值（最短路径值）
    print(result.vertexValues.sorted(by: { (a, b) -> Bool in
        return a.key < b.key
    }))
    
    //log from点 到 其他点 的路径方法
    print("\n")
    for (_,e) in result.routes.enumerated() {
        print("\(e.key) -> \(e.value)")
    }
}
